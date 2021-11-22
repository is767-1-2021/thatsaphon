import 'dart:async';

import 'package:team_app/kaew/model/account_model.dart';
import 'package:team_app/kaew/services/account_ser.dart';

class AccnameController {
  final Services service;
  List<Accname> accname = List.empty();

  StreamController<bool> onSyncController =
      StreamController(); // checking status stream onsync (on process / finish)
  Stream<bool> get onSync => onSyncController.stream;

  AccnameController(this.service);

  Future<List<Accname>> Fectname(String email) async {
    onSyncController.add(true); // stream connected
    accname = await service.getname(email);
    onSyncController.add(false); // stop connected
    return accname;
  }
}
