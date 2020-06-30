import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahua_pet/styles/app_style.dart';

class TextInput extends StatefulWidget {

  final FocusNode focusNode;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextStyle style;
  final TextAlign textAlign;
  final bool autofocus;
  final int maxLines;
  final int maxLength;
  final Widget suffix;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  final String placeText;
  final TextStyle placeStyle;
  final TextCleanType cleanType;
  final bool showObscure;
  

  TextInput({
    Key key,
    TextEditingController controller,
    FocusNode focusNode,
    TextInputType keyboardType,
    this.textInputAction,
    this.style,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.showObscure = false,
    this.maxLines = 1,
    this.maxLength,
    this.suffix,
    this.onChanged,
    this.onSubmitted,
    this.cleanType = TextCleanType.never,
    this.placeText,
    this.placeStyle
  }): keyboardType = keyboardType ?? (maxLines == 1 ? TextInputType.text : TextInputType.multiline), 
    controller = controller ?? TextEditingController(),
    focusNode = focusNode ?? FocusNode(),
    super(key: key);

  @override
  _TextInputState createState() => _TextInputState(showObscure: showObscure, cleanType: cleanType);
}

class _TextInputState extends State<TextInput> {

  final bool showObscure;
  final TextCleanType cleanType;
  bool _securityText = false;
  bool _showClean = false;

  _TextInputState({
    this.showObscure,
    this.cleanType
  }): _securityText = showObscure, _showClean = cleanType == TextCleanType.always;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        keyboardType: widget.keyboardType,
        focusNode: widget.focusNode,
        controller: widget.controller,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        autofocus: widget.autofocus,
        obscureText: _securityText,
        style: widget.style,
        textAlign: widget.textAlign,
        textInputAction: widget.textInputAction,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12.px),
          hintText: widget.placeText,
          hintStyle: widget.placeStyle,
          counterText: '',
          fillColor: Colors.transparent,
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.none, color: Colors.transparent)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.none, color: Colors.transparent)),
          suffixIcon: getSuffixWidget()
        ),
        onChanged: (text) {
          bool isShowClean = _showClean;
          if (widget.cleanType == TextCleanType.whileEditing) {
            isShowClean = text.isNotEmpty;
          } else if (widget.cleanType == TextCleanType.never) {
            isShowClean = false;
          } else {
            isShowClean = true;
          }
          setState(() {
            _showClean = isShowClean;
          });

          widget.onChanged(text);
        },
        onSubmitted: (text) {
          widget.onSubmitted(text);
        },
      ),
    );
  }

  Widget getSuffixWidget() {
    if (widget.suffix != null) {
      return widget.suffix;
    }
    if (_showClean || widget.showObscure) {
      return Container(
        width: 60.px,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: getListIcon()
        ),
      );
    }
    return null;
  }

  List<Widget> getListIcon() {
    List<Widget> listIcons = [];
    if (_showClean) {
      SizedBox cleanIcon = SizedBox(
        width: 30.px,
        height: 24.px,
        child: IconButton(
          iconSize: 16.px,
          padding: EdgeInsets.all(5.px),
          icon: Image.asset('${TKImages.image_path}login_clean.png', width: 14.px, height: 14.px, fit: BoxFit.contain),
          onPressed: () {
            bool isShowClean = false;
            if (widget.cleanType == TextCleanType.always) {
              isShowClean = true;
            }
            setState(() {
              widget.controller.text = '';
              _showClean = isShowClean;
            });
            widget.onChanged('');
          }
        )
      );
      listIcons.add(cleanIcon);
    }
    if (widget.showObscure) {
      String eyeImg = !_securityText ? '${TKImages.image_path}login_eye.png' : '${TKImages.image_path}login_eye_un.png';
      SizedBox cleanIcon = SizedBox(
          width: 30.px,
          height: 24.px,
          child: IconButton(
            iconSize: 16.px,
            padding: EdgeInsets.all(4.px),
            icon: Image.asset(eyeImg, width: 16.px, height: 16.px, fit: BoxFit.contain),
            onPressed: () {
              setState(() {
                _securityText = !_securityText;
              });
            }
        )
      );
      listIcons.add(cleanIcon);
    }
    return listIcons;
  } 
}


enum TextCleanType {
  never,
  whileEditing,
  always,
}