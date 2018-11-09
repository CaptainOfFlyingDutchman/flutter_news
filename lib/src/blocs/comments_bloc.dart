import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/item_model.dart';

class CommentsBloc {

  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  CommentsBloc() {
    _commentsFetcher.stream.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  // Sinks
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  // Streams
  Observable<Map<int, Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;

  ScanStreamTransformer<int, Map<int, Future<ItemModel>>> _commentsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        cache[id].then((ItemModel item) {
          item.kids.forEach((kid) => fetchItemWithComments(kid));
        });
        return cache; 
      },
      <int, Future<ItemModel>>{}
    );
  }

  close() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }

}
