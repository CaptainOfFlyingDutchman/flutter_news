import 'package:flutter/material.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> comments;

  Comment({this.itemId, this.comments});

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: comments[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading comment.');
        }

        return Text(snapshot.data.text);
      },
    );
  }
}
