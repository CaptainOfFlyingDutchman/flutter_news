import 'package:flutter/material.dart';
import './screens/news_list.dart';
import './screens/news_details.dart';
import './blocs/stories_provider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'News',
        onGenerateRoute: route,
      )
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
      int itemId = int.parse(settings.name.replaceFirst('/', ''));
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return NewsDetail(itemId: itemId);
        }
      );
    }
  }
}
