import 'package:flutter/material.dart';



class FindPage extends StatefulWidget {

  static const String routeName = "/find";

  final String _message;

  FindPage(this._message);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {

  

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('发现')),
        body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text(message),
              onPressed: () => {}
            ),
            
          ],
        )
      ),
    );
  }

}