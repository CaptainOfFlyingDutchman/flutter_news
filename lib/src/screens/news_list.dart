import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  Widget build(BuildContext context) {
    final StoriesBloc bloc = StoriesProvider.of(context);

    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            bloc.fetchItem(snapshot.data[index]);

            return Text('${snapshot.data[index]}');
          },
        );
      },
    );
  }

//  Widget buildList() {
//    return ListView.builder(
//      itemCount: 1000,
//      itemBuilder: (BuildContext context, int index) {
//        return FutureBuilder(
//          future: getFuture(),
//          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//            return Container(
//              height: 80.0,
//              child: snapshot.hasData
//                ? Text('Im visible $index')
//                : Text('Im not visible yet $index'),
//            );
//          },
//        );
//      },
//    );
//  }

//  Future<String> getFuture() {
//    return Future.delayed(Duration(seconds: 2), () {
//      return 'Hi';
//    });
//  }
}
