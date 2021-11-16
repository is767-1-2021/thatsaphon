import 'dart:async';

import 'package:team_app/models/prize.dart';
import 'package:team_app/services/checkLottoService.dart';

class CheckLottoController {
  final CheckLottoService service;
  List<LottoPrize> prizes = [];

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  CheckLottoController(this.service);

  Future<List<LottoPrize>> fetchPrizes(String date) async {
    onSyncController.add(true);
    prizes = await service.getPrizesByDate(date);
    onSyncController.add(false);
    print(prizes);
    return prizes;
  }
}
