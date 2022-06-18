import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Notifier with ChangeNotifier {
  bool _ispopUp = true;

  bool get ispopUp => _ispopUp;
  set ispopUp(bool value) {
    _ispopUp = value;
    debugPrint('value ispopOp = ' + _ispopUp.toString());
    notifyListeners();
  }
}

// class Notifier2 with ChangeNotifier {
//   bool _ispopUp = true;

//   bool get ispopUp => _ispopUp;
//   set ispopUp(bool value) {
//     _ispopUp = value;
//     print(_ispopUp);
//     notifyListeners();
//   }
// }
