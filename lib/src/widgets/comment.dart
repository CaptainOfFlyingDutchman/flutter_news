import 'package:flutter/material.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> comments;
  final int depth;

  Comment({this.itemId, this.comments, this.depth});

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: comments[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading comment.');
        }

        ItemModel item = snapshot.data;

        final List<Widget> children = [
          ListTile(
            title: Text(item.text),
            subtitle: item.by == '' ? Text('Deleted') : Text(item.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: (depth + 1) * 16.0
            ),
          ),
          Divider()
        ];

        item.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            comments: comments,
            depth: depth + 1,
          ));
        });

        return Column(children: children);
      },
    );
  }
}
