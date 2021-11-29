import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HistoryModel {
  String calculation = "";
  String result = "0";

  Timestamp timestamp;

  HistoryModel(this.calculation, this.result, this.timestamp);

  factory HistoryModel.toJson(Map<String, dynamic> json) {
    return HistoryModel(json['calculation'], json['result'], json['timestamp']);
  }
  Map<String, dynamic> toJson() {
    return {
      'calculation': calculation,
      'result': result,
      'timestamp': timestamp,
    };
  }

  factory HistoryModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return HistoryModel(
      json['calculation'] as String,
      json['result'] as String,
      json['timestamp'] as Timestamp,
    );
  }

  List<HistoryModel> historiesFromSnapShot(QuerySnapshot s) {
    List<HistoryModel> histories = s.docs
        .map((e) => HistoryModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();

    return histories;
  }
}

class HistoriesModel extends ChangeNotifier {
  List<HistoryModel> histories = [];
  get getHistories => this.histories;

  set setHistories(histories) {
    this.histories = histories;
    notifyListeners();
  }

  addHistory(history) {
    this.histories.add(history);
    notifyListeners();
  }

  HistoriesModel(this.histories);

  factory HistoriesModel.fromSnapshot(QuerySnapshot s) {
    List<HistoryModel> histories = s.docs
        .map((e) => HistoryModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();

    return HistoriesModel(histories);
  }
}
