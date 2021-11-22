import 'dart:async';

import 'package:team_app/models/user_models.dart';
import 'package:team_app/services/user_service.dart';

// import 'package:team_app/kaew/model/account_model.dart';
// import 'package:team_app/kaew/services/account_ser.dart';

class AccnameController {
  AccnameServices service = new AccnameServices();
  List<Accname> accname = List.empty();

  StreamController<bool> onSyncController =
      StreamController(); // checking status stream onsync (on process / finish)
  Stream<bool> get onSync => onSyncController.stream;

  Future<List<Accname>> fectname() async {
    onSyncController.add(true); // stream connected
    accname = await service.getname();
    onSyncController.add(false); // stop connected
    return accname;
  }

  updateProfile(
    String birthDate,
    String email,
    String fullName,
    String phone,
    String username,
    String image,
  ) async {
    await service.updateProfile(
      birthDate,
      email,
      fullName,
      phone,
      username,
      image,
    );
  }
}
