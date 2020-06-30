import 'package:flutter/material.dart';

class PetListPage extends StatelessWidget {

  static const routeName = '/pet_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加宠物'),
      ),
      body: PetListContent(),
    );
  }
}

class PetListContent extends StatefulWidget {
  @override
  _PetListContentState createState() => _PetListContentState();
}

class _PetListContentState extends State<PetListContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}