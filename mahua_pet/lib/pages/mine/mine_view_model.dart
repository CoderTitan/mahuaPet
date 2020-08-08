
import 'package:flutter/material.dart';


class MineViewModel extends ChangeNotifier {

  int _counter = 0;

  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  int get counter {
    return _counter;
  }
  
  MineViewModel() {
    counter = counter + 1;
  }
}