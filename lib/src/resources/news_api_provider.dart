import 'package:http/http.dart' show Client, Response;
import 'dart:convert';
import '../models/item_model.dart';
import 'dart:async';

final String _baseUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    Response response = await client.get('$_baseUrl/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    Response response = await client.get('$_baseUrl/item/$id');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
