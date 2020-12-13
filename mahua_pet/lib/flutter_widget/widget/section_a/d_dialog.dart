
import 'package:flutter/material.dart';

class DialogShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SectionA')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: renderItems(context),
        ),
      ),
      floatingActionButton: RaisedButton(
          child: Text('titles[i]'),
          onPressed: () {
            _showGeneralDialog(context);
          }
        ),
    );
  }

  List<Widget> renderItems(BuildContext context) {
    List<Widget> items = [];

    List<String> titles = ['Dialog', 'GeneralDialog', 'BottomSheet', 'ModalBottomSheet', 'Menu', 'Search', 'CupertinoDialog',  'AboutDialog', 'LicensePage'];
    for (var i = 0; i < titles.length; i++) {
      Widget button = Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: RaisedButton(
          child: Text(titles[i]),
          onPressed: () {
            buttonAction(i, context);
          }
        ),
      );

      items.add(button);
    }

    return items;
  }

  void buttonAction(int index, BuildContext context) {
    switch (index) {
      case 0:
        _showDialog(context);
        break;
      case 0:
        _showGeneralDialog(context);
        break;
      case 1:
        _showBottomSheet(context);
        break;
      case 2:
        _showModalBottomSheet(context);
        break;
      case 3:
        
        break;
      case 4:
        
        break;
      case 5:
        
        break;
      case 6:
        
        break;
      case 7:
        
        break;
      default:
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black45,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          title: Text('title'),
          content: Text('content'),
        );
      }
    );
  }

  void _showGeneralDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black45,
      transitionDuration: Duration(milliseconds: 250),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(scale: animation, child: child);
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Center(
          child: Container(
            height: 100,
            width: 100,
            color: Colors.orange,
          ),
        );
      }
    );
  }

  // ['Dialog', 'GeneralDialog', 'BottomSheet', 'ModalBottomSheet', 'Menu', 'Search', 'CupertinoDialog',  'AboutDialog', 'LicensePage']
  void _showBottomSheet(BuildContext context) {
    showBottomSheet(
      context: context, 
      backgroundColor: Colors.black45,
      // clipBehavior: Clip.hardEdge,
      builder: (ctx) {
        return Center(
          child: Container(
            height: 100,
            width: 100,
            color: Colors.orange,
          ),
        );
      }
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      backgroundColor: Colors.black45,
      clipBehavior: Clip.hardEdge,
      builder: (ctx) {
        return Center(
          child: Container(
            height: 100,
            width: double.maxFinite,
            color: Colors.orange,
          ),
        );
      }
    );
  }
}

