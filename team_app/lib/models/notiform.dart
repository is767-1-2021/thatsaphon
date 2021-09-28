import 'package:flutter/material.dart';

class NotiformModel extends ChangeNotifier {
  List<String> _alert = <String>[];

  get alert => this._alert;

  set alert(value) {
    this._alert = value;
    notifyListeners();
  }
}
