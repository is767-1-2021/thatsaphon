import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsernameFormModel extends ChangeNotifier {
  String _Username = 'AlifInwZa55+';

  get Username => this._Username;

  set Username(value) {
    this._Username = value;
    notifyListeners();
  }
}
