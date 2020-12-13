import 'package:flutter/material.dart';

import 'list_items.dart';


class WidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemLists = routeLists.keys.toList();
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Widget')),
      body: Container(
        child: ListView.builder(
          itemCount: routeLists.length,
          itemBuilder: (ctx, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12))
              ),
              child: ListTile(
                title: Text(routeLists.keys.toList()[index]),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).pushNamed(itemLists[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}