import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  DiscoverPage({Key key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('发现')),
        body: Container(
        child: Column(
          children: <Widget>[

          ],
        )
      ),
    );
  }
}