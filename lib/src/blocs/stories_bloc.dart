import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/item_model.dart';

class StoriesBloc {
  final Repository _repository = Repository();

  final PublishSubject<List<int>> _topIds = PublishSubject();
  final BehaviorSubject<int> _items = BehaviorSubject<int>();

  Observable<Map<int, Future<ItemModel>>> items;

  // Getters to Streams
  Observable<List<int>> get topIds => _topIds.stream;

  // Getters to Sinks
  Function(int) get fetchItem => _items.sink.add;

  StoriesBloc() {
    items = _items.stream.transform(this._itemsTransformer());
  }

  void fetchTopIds() async {
    List<int> ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  ScanStreamTransformer<int, Map<int, Future<ItemModel>>> _itemsTransformer() {
    return new ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{}
    );
  }

  void dispose() {
    _topIds.close();
    _items.close();
  }
}
