
import 'package:flutter/material.dart';
import '../models/swiper_model.dart';

class HomeViewModel extends ChangeNotifier {

  List<SwiperModel> _swiperArray = [];
  int _counter = 0;

  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  int get counter {
    return _counter;
  }
  

  set swiperArray(List<SwiperModel> value) {
    _swiperArray = value;
    notifyListeners();
  }

  List<SwiperModel> get swiperArray {
    return _swiperArray;
  }
}