import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserSession extends ChangeNotifier {
  String email = '';
  get getEmail => this.email;

  set setEmail(email) => {this.email = email, notifyListeners()};
  // get email => this.email;

  // set Username(value) {
  //   this._Username = value;
  //   notifyListeners();
  // }

}
