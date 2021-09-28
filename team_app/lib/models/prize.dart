import 'package:flutter/material.dart';

class FirstFormModel extends ChangeNotifier {
  String? _lottoNo;

  get lottoNo => this._lottoNo;

  set lottoNo(value) {
    this._lottoNo = value;
    notifyListeners();
  }
}
