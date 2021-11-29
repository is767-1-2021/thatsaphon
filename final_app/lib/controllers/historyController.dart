import 'dart:async';

import 'package:final_app/models/historyModel.dart';
import 'package:final_app/services/historyService.dart';

class HistoryController {
  HistoryService service = new HistoryService();
  List<HistoryModel> histories = [];

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  Future<List<HistoryModel>> fetchHistories() async {
    onSyncController.add(true);
    histories = await service.getHistoryFromFirebase();
    histories.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    onSyncController.add(false);
    return histories;
  }

  addHistory(String calculation, String result) async {
    await service.addHistoryToFirebase(calculation, result);
  }
}
