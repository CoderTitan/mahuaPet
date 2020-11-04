// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Mahua Pet`
  String get app_title {
    return Intl.message(
      'Mahua Pet',
      name: 'app_title',
      desc: '',
      args: [],
    );
  }

  /// `Not logged in`
  String get login_no {
    return Intl.message(
      'Not logged in',
      name: 'login_no',
      desc: '',
      args: [],
    );
  }

  /// `login successful`
  String get login_success {
    return Intl.message(
      'login successful',
      name: 'login_success',
      desc: '',
      args: [],
    );
  }

  /// `Choose pet`
  String get pet_select {
    return Intl.message(
      'Choose pet',
      name: 'pet_select',
      desc: '',
      args: [],
    );
  }

  /// `Add pet`
  String get pet_add {
    return Intl.message(
      'Add pet',
      name: 'pet_add',
      desc: '',
      args: [],
    );
  }

  /// `No pet added`
  String get pet_add_no {
    return Intl.message(
      'No pet added',
      name: 'pet_add_no',
      desc: '',
      args: [],
    );
  }

  /// `has`
  String get home_has {
    return Intl.message(
      'has',
      name: 'home_has',
      desc: '',
      args: [],
    );
  }

  /// `Daily clock in`
  String get home_card {
    return Intl.message(
      'Daily clock in',
      name: 'home_card',
      desc: '',
      args: [],
    );
  }

  /// `Health management`
  String get home_fit {
    return Intl.message(
      'Health management',
      name: 'home_fit',
      desc: '',
      args: [],
    );
  }

  /// `Weight records`
  String get home_weight {
    return Intl.message(
      'Weight records',
      name: 'home_weight',
      desc: '',
      args: [],
    );
  }

  /// `Rookie help`
  String get home_help {
    return Intl.message(
      'Rookie help',
      name: 'home_help',
      desc: '',
      args: [],
    );
  }

  /// `Feeding guide`
  String get home_guide {
    return Intl.message(
      'Feeding guide',
      name: 'home_guide',
      desc: '',
      args: [],
    );
  }

  /// `grass`
  String get home_grass {
    return Intl.message(
      'grass',
      name: 'home_grass',
      desc: '',
      args: [],
    );
  }

  /// `Temporarily no data`
  String get empty_data {
    return Intl.message(
      'Temporarily no data',
      name: 'empty_data',
      desc: '',
      args: [],
    );
  }

  /// `Click the refresh`
  String get empty_refresh {
    return Intl.message(
      'Click the refresh',
      name: 'empty_refresh',
      desc: '',
      args: [],
    );
  }

  /// `Mine`
  String get mine_title {
    return Intl.message(
      'Mine',
      name: 'mine_title',
      desc: '',
      args: [],
    );
  }

  /// `Won the praise`
  String get mine_agree {
    return Intl.message(
      'Won the praise',
      name: 'mine_agree',
      desc: '',
      args: [],
    );
  }

  /// `Fans`
  String get mine_fans {
    return Intl.message(
      'Fans',
      name: 'mine_fans',
      desc: '',
      args: [],
    );
  }

  /// `Focus`
  String get mine_flower {
    return Intl.message(
      'Focus',
      name: 'mine_flower',
      desc: '',
      args: [],
    );
  }

  /// `my pets`
  String get mine_pet {
    return Intl.message(
      'my pets',
      name: 'mine_pet',
      desc: '',
      args: [],
    );
  }

  /// `all`
  String get mine_all {
    return Intl.message(
      'all',
      name: 'mine_all',
      desc: '',
      args: [],
    );
  }

  /// `Set the theme`
  String get mine_theme {
    return Intl.message(
      'Set the theme',
      name: 'mine_theme',
      desc: '',
      args: [],
    );
  }

  /// `Set the language`
  String get mine_local {
    return Intl.message(
      'Set the language',
      name: 'mine_local',
      desc: '',
      args: [],
    );
  }

  /// `The default theme`
  String get theme_0 {
    return Intl.message(
      'The default theme',
      name: 'theme_0',
      desc: '',
      args: [],
    );
  }

  /// `Theme 1`
  String get theme_1 {
    return Intl.message(
      'Theme 1',
      name: 'theme_1',
      desc: '',
      args: [],
    );
  }

  /// `Theme 2`
  String get theme_2 {
    return Intl.message(
      'Theme 2',
      name: 'theme_2',
      desc: '',
      args: [],
    );
  }

  /// `Theme 3`
  String get theme_3 {
    return Intl.message(
      'Theme 3',
      name: 'theme_3',
      desc: '',
      args: [],
    );
  }

  /// `Theme 4`
  String get theme_4 {
    return Intl.message(
      'Theme 4',
      name: 'theme_4',
      desc: '',
      args: [],
    );
  }

  /// `Theme 5`
  String get theme_5 {
    return Intl.message(
      'Theme 5',
      name: 'theme_5',
      desc: '',
      args: [],
    );
  }

  /// `Theme 6`
  String get theme_6 {
    return Intl.message(
      'Theme 6',
      name: 'theme_6',
      desc: '',
      args: [],
    );
  }

  /// `Recommend`
  String get find_recom {
    return Intl.message(
      'Recommend',
      name: 'find_recom',
      desc: '',
      args: [],
    );
  }

  /// `Topic`
  String get find_topic {
    return Intl.message(
      'Topic',
      name: 'find_topic',
      desc: '',
      args: [],
    );
  }

  /// `You might want to meet them~`
  String get find_know {
    return Intl.message(
      'You might want to meet them~',
      name: 'find_know',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get find_change {
    return Intl.message(
      'Change',
      name: 'find_change',
      desc: '',
      args: [],
    );
  }

  /// `There are {count} concerns`
  String find_focus_count(Object count) {
    return Intl.message(
      'There are $count concerns',
      name: 'find_focus_count',
      desc: '',
      args: [count],
    );
  }

  /// `Focused`
  String get find_focused {
    return Intl.message(
      'Focused',
      name: 'find_focused',
      desc: '',
      args: [],
    );
  }

  /// `Hot topic`
  String get find_hot_topic {
    return Intl.message(
      'Hot topic',
      name: 'find_hot_topic',
      desc: '',
      args: [],
    );
  }

  /// `Hot discussion`
  String get find_hot_talk {
    return Intl.message(
      'Hot discussion',
      name: 'find_hot_talk',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get find_more {
    return Intl.message(
      'More',
      name: 'find_more',
      desc: '',
      args: [],
    );
  }

  /// `Dynamic details`
  String get find_detail {
    return Intl.message(
      'Dynamic details',
      name: 'find_detail',
      desc: '',
      args: [],
    );
  }

  /// `Comment on the cute ones~`
  String get find_comment {
    return Intl.message(
      'Comment on the cute ones~',
      name: 'find_comment',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}