import 'package:flutter/material.dart';
import 'section_a/a_animated.dart';
import 'section_a/a_section.dart';
import 'section_a/d_dialog.dart';
import 'section_item/contain.dart';


Map<String, WidgetBuilder> routeLists = {
  'SectionA': (context) => SectionA(),
  'Animated': (context) => AnimatWidget(),
  'Dialog': (context) => DialogShow(),
  '容器类Widget': (context) => ContainerWidget(),
};