import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/redux/models/pet_model.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import 'package:mahua_pet/styles/app_style.dart';

class PetAddPage extends StatelessWidget {

  final bool isAdd;
  final PetModel model;
  PetAddPage({this.isAdd, this.model});

  @override
  Widget build(BuildContext context) {
    final title = isAdd ? '添加宠物' : '编辑宠物';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: PetAddContent(isAdd: isAdd, model: model),
    );
  }
}

class PetAddContent extends StatefulWidget {

  final bool isAdd;
  final PetModel model;
  PetAddContent({this.isAdd, this.model});

  @override
  _PetAddContentState createState() => _PetAddContentState(isAdd: isAdd, model: model);
}

class _PetAddContentState extends State<PetAddContent> {


  ScrollController _scrollController = ScrollController();
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  final PetModel model;
  String _petImage = '';
  String _nickname = '';
  String _petSex = '';
  String _petBreed = '';
  String _birthday = '';
  String _homeDay = '';
  String _isDisable = '';
  String _petWeight = '';
  bool _disabled = false;

  _PetAddContentState({bool isAdd, this.model}): 
    _petImage = isAdd ? '' : (model.petImg ?? ''),
    _nickname = isAdd ? '' : model.petName,
    _petSex = isAdd ? '' : (model.sex == '0' ? 'GG' : 'MM'),
    _petBreed = isAdd ? '' : model.petBreed,
    _birthday = isAdd ? '' : model.birthday,
    _homeDay = isAdd ? '' : model.adoptionDate,
    _isDisable = isAdd ? '' : (model.isSterilization == '0' ? '已绝育' : '未绝育'),
    _petWeight = isAdd ? '' : model.petKg,
    _nicknameController = TextEditingController(text: isAdd ? '' : model.petName),
    _weightController = TextEditingController(text: isAdd ? '' : model.petKg),
    _disabled = !isAdd;

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => inputFocusNode(context),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.px),
            animalHeaderItem(_petImage),
            TextSelectCell(
              height: 50.px,
              backcolorColor: TKColor.color_f7f7f7, 
              leftTitle: '必填', 
              leftTitleFont: 14.px, 
              leftTitleColor: TKColor.color_999999,
              showArrow: false,
            ),
            TextInputCell(
              controller: _nicknameController,
              leftTitle: '昵称',
              placeholder: '请输入宠物昵称',
              showLine: true,
              lineColor: TKColor.color_f7f7f7,
              onChanged: (text) {
                _nickname = text;
                updateButtonState();
              },
            ),
            TextSelectCell(
              leftTitle: '性别',
              rightTitle: _petSex.length > 0 ? _petSex : '请选择宠物性别',
              rightTitleColor: _petSex.length > 0 ? TKColor.color_333333 : TKColor.color_cccccc,
              onTap: () {
                TKActionSheet.showActionSheet(context, 
                  rows: ['GG', 'MM'],
                  selectAction: (index, title) {
                    _petSex = title;
                    updateButtonState();
                  }
                );
              },
            ),
            TextSelectCell(
              leftTitle: '宠物品种',
              rightTitle: _petBreed.length > 0 ? _petBreed : '请选择宠物品种',
              rightTitleColor: _petBreed.length > 0 ? TKColor.color_333333 : TKColor.color_cccccc,
              onTap: () {
                  // _petSex = title;
                  updateButtonState();
              },
            ),
            TextSelectCell(
              leftTitle: '出生日期',
              rightTitle: _birthday.length > 0 ? _birthday : '请选择出生日期',
              rightTitleColor: _birthday.length > 0 ? TKColor.color_333333 : TKColor.color_cccccc,
              onTap: () {
                TKDatePickerAction.showActionSheet(context, 
                  initialDateTime: DateTime.now(),
                  minimumDate: DateTime(2015, 1, 1),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (date) {
                    final dateStr = '${date.year}-${date.month}-${date.day}';
                    setState(() {
                      _birthday = dateStr;
                    });
                    updateButtonState();
                  }
                );
              },
            ),
            TextSelectCell(
              leftTitle: '领养日期',
              rightTitle: _homeDay.length > 0 ? _homeDay : '请选择领养日期',
              rightTitleColor: _homeDay.length > 0 ? TKColor.color_333333 : TKColor.color_cccccc,
              onTap: () {
                  TKDatePickerAction.showActionSheet(context, 
                    initialDateTime: DateTime.now(),
                    minimumDate: DateTime(2015, 1, 1),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (date) {
                      _homeDay = '${date.year}-${date.month}-${date.day}';
                      updateButtonState();
                    }
                  );
              },
            ),
            TextSelectCell(
              leftTitle: '绝育状态',
              rightTitle: _isDisable.length > 0 ? _isDisable : '请选择绝育状态',
              rightTitleColor: _isDisable.length > 0 ? TKColor.color_333333 : TKColor.color_cccccc,
              onTap: () {
                  TKActionSheet.showActionSheet(context, 
                    rows: ['已绝育', '未绝育'],
                    selectAction: (index, title) {
                      _isDisable = title;
                      updateButtonState();
                    }
                  );
              },
            ),
            TextInputCell(
              controller: _weightController,
              leftTitle: '宠物体重',
              placeholder: '请输入宠物体重',
              showLine: false,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                _petWeight = text;
                updateButtonState();
              },
            ),
            SizedBox(height: 30.px),
            LargeButton(
              title: '保存',
              disabled: _disabled,
              onPressed: () {
                saveAnimalInfo(context, model);
              }
            ),
            SizedBox(height: 100.px),
          ],
        ),
      ),
    );
  }

  Widget animalHeaderItem(String animalIcon) {
    return Container(
      height: 130.px,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TKNetworkImage(
            width: 73.px,
            height: 73.px,
            boxRadius: 50.px,
            fit: BoxFit.cover,
            imageUrl: animalIcon,
            placeholder: '${TKImages.image_path}animal_moren_icon.png',
          ),
          SizedBox(height: 5.px),
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('${TKImages.image_path}animal_change.png', width: 12.px, height: 10.px),
                Text('上传头像', style: TextStyle(fontSize: 12.px, color: TKColor.color_b6b6b6))
              ],
            ),
            onTap: () {
              updateButtonState();
            },
          )
        ],
      ),
    );
  }

  void inputFocusNode(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void updateButtonState() {
    final disabled = _petImage.length > 0 && 
                    _nickname.length > 0 &&
                    _petSex.length > 0 &&
                    _petBreed.length > 0 &&
                    _birthday.length > 0 &&
                    _homeDay.length > 0 &&
                    _isDisable.length > 0 &&
                    _petWeight.length > 0;
    
    setState(() {
      _disabled = disabled;
    });
  }

  void saveAnimalInfo(BuildContext context, PetModel model) {
    Map<String, dynamic> params = {
      "petImg": _petImage,
      "petId": model.petId,
      "adoptionDate": _homeDay,
      "userId": '${SharedStorage.loginInfo?.userId ?? 0}',
      "petKg": _petWeight,
      "petName": _nickname,
      "isSterilization": _isDisable == '已绝育' ? '1' : '0',
      "birthday": _birthday,
      "sex": _petSex == 'GG' ? '0' : '1',
      "petBreed": _petBreed
    };
    TKToast.showLoading();
    TKRequest.requestData(HttpConfig.pet_save, method: 'post', params: params)
      .then((value) {
        if (value.isSuccess) {
          // PetViewModel();
          TKToast.showSuccess('保存成功');
          Navigator.of(context).pop();
        } else {
          TKToast.showError(value.message);
        }
      })
      .catchError((error) {
        // TKToast.dismiss();
      });
  }
}