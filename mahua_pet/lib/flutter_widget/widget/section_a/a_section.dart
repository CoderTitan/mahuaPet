import 'package:flutter/material.dart';

class SectionA extends StatefulWidget {
  @override
  _SectionAState createState() => _SectionAState();
}

class _SectionAState extends State<SectionA> {

  int _selectIndex = 0;
  List<int> _filter = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SectionA')),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              renderAboutListTile(),
              renderAbsorbPointer(),
              renderClip(),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderAboutListTile() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      child: Column(
        children: [
          Text('AboutListTile', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          AboutListTile(
            icon: Icon(Icons.apps),
            child: Text('AboutListTile'),
            applicationIcon: Icon(Icons.person),
            applicationName: 'Widget Demo',
            applicationVersion: '1.0.0',
            applicationLegalese: '练习Widget Demo',
          ),
        ],
      ),
    );
  }

  Widget renderAbsorbPointer() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      child: Column(
        children: [
          Text('AbsorbPointer', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('禁止用户输入的控件', style: TextStyle(fontSize: 12)),
          AbsorbPointer(
            // absorbing为false可以相应事件, 为true不响应
            absorbing: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(onPressed: (){ print('object'); },),
                RaisedButton(onPressed: (){ print('object'); },),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Text('IgnorePointer', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('AbsorbPointer本身可以接收点击事件，消耗掉事件，而IgnorePointer无法接收点击事件，其下的控件可以接收到点击事件', style: TextStyle(fontSize: 13)),
          IgnorePointer(
            ignoring: true,
            child: RaisedButton(onPressed: (){ print('object'); }),
          )
        ],
      ),
    );
  }

  Widget renderClip() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      child: Column(
        children: [
          Text('Clip', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          SizedBox(height: 10,),
          Text('RawChip是Material风格标签控件，此控件是其他标签控件的基类，通常情况下，不会直接创建此控件，而是使用如下控件: Chip, InputChip, ChoiceChip, FilterChip, ActionChip', style: TextStyle(fontSize: 13)),
          SizedBox(height: 10,),
          RawChip(
            label: Text('RawChip'),
            // avatar: Icon(Icons.person),
            deleteIcon: Icon(Icons.close),
            deleteButtonTooltipMessage: 'delete',
            onDeleted: () {},
            selected: true,
            showCheckmark: true,
          ),
          Chip(
            label: Text('Chip: 简化版的RawChip'),
            deleteIcon: Icon(Icons.delete),
            deleteButtonTooltipMessage: 'delete',
            onDeleted: (){},
          ),
          InputChip(
            label: Text('InputChip: 紧凑的形式表示一条复杂的信息'),
          ),

          SizedBox(height: 20,),
          Text('ChoiceChip选中标签', style: TextStyle(fontSize: 13)),
          Wrap(
            spacing: 20,
            children: List.generate(4, (index) {
              return ChoiceChip(
                label: Text('ChoiceChip-$index'), 
                selected: _selectIndex == index,
                onSelected: (i) {
                  setState(() {
                    _selectIndex = index;
                  });
                },
              );
            }).toList(),
          ),

          SizedBox(height: 20,),
          Text('FilterChip过滤标签', style: TextStyle(fontSize: 13)),
          Wrap(
            spacing: 20,
            children: List.generate(4, (index) {
              return FilterChip(
                label: Text('FilterChip-$index'), 
                selected: _filter.contains(index),
                selectedColor: Colors.blue[300],
                onSelected: (isSelect) {
                  if (isSelect) {
                    _filter.add(index);
                  } else {
                    _filter.removeWhere((element) => element == index);
                  }
                  setState(() {});
                },
              );
            }).toList(),
          ),

          SizedBox(height: 20,),
          Text('ActionChip类似按钮Button', style: TextStyle(fontSize: 13)),
          ActionChip(
            label: Text('ActionChip'), 
            onPressed: () {},
          )
        ],
      ),
    );
  }
}