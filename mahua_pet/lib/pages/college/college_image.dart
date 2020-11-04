import 'package:flutter/material.dart';

class HYImageDetail extends StatelessWidget {
  final String imageURL;

  HYImageDetail(this.imageURL);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Image.network(
            this.imageURL,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        )
      ),
    );
  }
}