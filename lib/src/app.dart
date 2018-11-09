import 'package:flutter/material.dart';
import './screens/news_list.dart';
import './screens/news_details.dart';
import './blocs/stories_provider.dart';
import './blocs/comments_provider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: route,
        )
      ),
    );
  }

  Route route(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return NewsList();
        }
      );
    } else {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          CommentsBloc commentsBloc = CommentsProvider.of(context);
          int itemId = int.parse(settings.name.replaceFirst('/', ''));

          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetail(itemId: itemId);
        }
      );
    }
  }
}
