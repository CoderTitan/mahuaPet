import 'package:flutter/material.dart';

import 'package:mahua_pet/component/component.dart';

class PetAddPage extends StatelessWidget {

  static const routeName = '/pet_add';

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> settingMap = ModalRoute.of(context).settings.arguments;
    final isAdd = settingMap['add'] ?? true;
    final title = isAdd ? '添加宠物' : '编辑宠物';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: PetAddContent(),
    );
  }
}

class PetAddContent extends StatefulWidget {
  @override
  _PetAddContentState createState() => _PetAddContentState();
}

class _PetAddContentState extends State<PetAddContent> {

  String _rightTitle = 'wod';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          TextInputCell(
            leftTitle: '性别',
            showLine: true,
            lineColor: Colors.red,
          ),
          SizedBox(height: 30),
          TextSelectCell(
            leftTitle: '计算机室',
            rightTitle: _rightTitle,
            onTap: () {
                setState(() {
                  _rightTitle = '大家的';
                });
            },
          )
        ],
      ),
    );
  }
}