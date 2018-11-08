import 'package:http/http.dart' show Client, Response;
import 'dart:convert';
import 'dart:async';
import '../models/item_model.dart';
import './repository.dart';

final String _baseUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  @override
  Future<List<int>> fetchTopIds() async {
    Response response = await client.get('$_baseUrl/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    Response response = await client.get('$_baseUrl/item/$id.json');

    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
