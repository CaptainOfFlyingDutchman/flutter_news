import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final Repository _repository = Repository();

  final PublishSubject<List<int>> _topIds = PublishSubject();

  // Getters to Streams
  Observable<List<int>> get topIds => _topIds.stream;

  void fetchTopIds() async {
    List<int> ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  void dispose() {
    _topIds.close();
  }
}
