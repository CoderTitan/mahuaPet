import 'package:flutter/material.dart';

class FlutterWidgetList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeLists = demoPages.keys.toList();
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Widget Demo')),
      body: ListView.builder(
        itemCount: routeLists.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            child: Card(
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: Text(demoPages.keys.toList()[index]),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(routeLists[index]);
            },
          );
        }
      ),
    );
  }
}

Map<String, WidgetBuilder> demoPages = {
  
};