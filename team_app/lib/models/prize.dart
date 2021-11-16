import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirstFormModel extends ChangeNotifier {
  String? _lottoNo;

  get lottoNo => this._lottoNo;

  set lottoNo(value) {
    this._lottoNo = value;
    notifyListeners();
  }
}

class LottoPrize extends ChangeNotifier {
  String date = "";
  String lottoNum = "";
  String prize = "";

  LottoPrize(this.date, this.lottoNum, this.prize);

  factory LottoPrize.fromJson(
    Map<String, dynamic> json,
  ) {
    return LottoPrize(
      json['date'] as String,
      json['lottoNum'] as String,
      json['prize'] as String,
    );
  }

  // get lottoNo => this._lottoNo;

  // set lottoNo(value) {
  //   this._lottoNo = value;
  //   notifyListeners();
  // }
}

class AllLottoPrize {
  List<LottoPrize> allLottoPrize = [];

  AllLottoPrize(this.allLottoPrize);

  factory AllLottoPrize.fromJson(List<dynamic> json) {
    List<LottoPrize> lottoPrizes;

    lottoPrizes = json.map((todo) {
      print(todo);
      return LottoPrize.fromJson(todo);
    }).toList();

    return AllLottoPrize(lottoPrizes);
  }

  factory AllLottoPrize.fromSnapshot(QuerySnapshot s) {
    List<LottoPrize> lottoPrizes = s.docs
        .map((DocumentSnapshot ds) =>
            LottoPrize.fromJson(ds.data() as Map<String, dynamic>))
        .toList();

    return AllLottoPrize(lottoPrizes);
  }
}
