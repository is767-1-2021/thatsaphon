import 'dart:async';

import 'package:team_app/kaew/model/purchase_model.dart';
import 'package:team_app/kaew/services/purchase_ser.dart';

class PurHistoryController {
  final Services service;
  List<PurHistory> purhistory = List.empty();

  StreamController<bool> onSyncController =
      StreamController(); // checking status stream onsync (on process / finish)
  Stream<bool> get onSync => onSyncController.stream;

  PurHistoryController(this.service);

  Future<List<PurHistory>> Fectlotto() async {
    onSyncController.add(true); // stream connected
    purhistory = await service.getlotto();
    onSyncController.add(false); // stop connected
    return purhistory;
  }
}
