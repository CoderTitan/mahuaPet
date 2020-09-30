
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:mahua_pet/pages/home/view_model/home_view_model.dart';
import 'package:mahua_pet/pages/home/view_model/pet_view_model.dart';

import 'package:mahua_pet/pages/find/view_model/topic_page_provide.dart';
import 'user_provider.dart';


class ProviderConfig {
  
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (ctx) => PetViewModel()),
    ChangeNotifierProvider(create: (ctx) => HomeViewModel()),
    ChangeNotifierProvider(create: (ctx) => UserProvider()),
    ChangeNotifierProvider(create: (ctx) => TopicPageProvider()),
  ];
}