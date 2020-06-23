import 'package:flutter/material.dart';

class CollegePage extends StatefulWidget {
  CollegePage({Key key}) : super(key: key);

  @override
  _CollegePageState createState() => _CollegePageState();
}

class _CollegePageState extends State<CollegePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('学院')),
        body: Container(
        child: Column(
          children: <Widget>[

          ],
        )
      ),
    );
  }
}