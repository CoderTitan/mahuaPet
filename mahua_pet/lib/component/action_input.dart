import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:mahua_pet/styles/app_style.dart';


typedef ActionInputSelect = void Function(String text);


class TKActionComment {
  static void showActionSheet(BuildContext context,{
    FocusNode focusNode,
    TextEditingController textController,
    String placehold = '',
    ActionInputSelect submitAction,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return TKActionInputDialog(
          placehold: placehold,
          focusNode: focusNode,
          textController: textController,
          submitAction: submitAction,
        );
    });
  } 
}

class TKActionInputDialog extends StatefulWidget {
  final String placehold;
  final FocusNode focusNode;
  final TextEditingController textController;
  final ActionInputSelect submitAction;

  TKActionInputDialog({
    Key key,
    @required this.placehold,
    this.focusNode,
    this.textController,
    this.submitAction,
  }): super(key: key);

  @override
  _TKActionInputDialogState createState() => _TKActionInputDialogState();
}

class _TKActionInputDialogState extends State<TKActionInputDialog> with WidgetsBindingObserver {
  

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    if (this.mounted) {
      setState(() { });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQueryData.fromWindow(ui.window);
    return AnimatedContainer(
      color: Colors.transparent,
      duration: Duration(milliseconds: 200),
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
      child: Material(
        child: Container(
          height: 50.px,
          color: TKColor.white,
          padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
          child: Row(
            children: <Widget>[
              renderTextInput(),
              renderSenderButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget renderTextInput() {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.text,
        focusNode: widget.focusNode,
        controller: widget.textController,
        autofocus: true,
//        maxLines: null,
        style: TextStyle(fontSize: 14.px, color: TKColor.color_333333),
        textInputAction: TextInputAction.send,
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 4.px, horizontal: 16.px),
          hintText: widget.placehold,
          hintStyle: TextStyle(fontSize: 14.px, color: TKColor.color_cccccc),
          counterText: '',
          filled: true,
          fillColor: TKColor.color_f7f7f7,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none, color: Colors.transparent), borderRadius: BorderRadius.circular(30.px)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none, color: Colors.transparent), borderRadius: BorderRadius.circular(30.px)),
        ),
        onSubmitted: (text) {
          widget.focusNode.unfocus();
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          widget.submitAction(text);
        },
      ),
    );
  }

  Widget renderSenderButton() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 16.px),
        child: Center(
          child: Text('发送', style: TextStyle(fontSize: 16.px, color: TKColor.main_color)),
        ),
      ),
      onTap: () {
        widget.focusNode.unfocus();
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        widget.submitAction(widget.textController.text);
      },
    );
  }
}