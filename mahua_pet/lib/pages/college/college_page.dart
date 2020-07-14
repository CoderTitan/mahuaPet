import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';


class CollegePage extends StatefulWidget {
  CollegePage({Key key}) : super(key: key);

  @override
  _CollegePageState createState() => _CollegePageState();
}

class _CollegePageState extends State<CollegePage> {

  final imageURL = 'https://static.ieasydog.com/dog/df307246788c48fd8b778af1b1e68101.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('学院')),
        body: Container(
          child: Column(
            children: <Widget>[
              FlatButton(
                color: Colors.yellow,
                child: Text('text'),
                onPressed: () {
                  showHasInputDialog();
                },
              )
            ],
          )
        )
    );
  }


  void showHasInputDialog() {
    var widget = Center(
      child: Container(
        height: 40,
        width: double.infinity,
        child: Material(
          child: TextField(),
        ),
      ),
    );
    showDialog(context: context, builder: (_) => InputDialog());
  }
}




class InputDialog extends StatefulWidget {
  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQueryData.fromWindow(ui.window);
    return AnimatedContainer(
      color: Colors.transparent,
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
      child: Container(
        height: 50,
        width: SizeFit.screenWidth,
        child: TextField()
      ),
      alignment: Alignment.center,
    );
  }
}