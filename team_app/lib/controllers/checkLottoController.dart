import 'dart:async';

import 'package:team_app/models/prize.dart';
import 'package:team_app/services/checkLottoService.dart';

class CheckLottoController {
  CheckLottoService service = CheckLottoService();
  List<LottoPrize> prizes = [];

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  CheckLottoController();

  Future<List<LottoPrize>> fetchPrizes(String date) async {
    onSyncController.add(true);
    prizes = await service.getPrizesByDate(date);
    onSyncController.add(false);
    print(prizes);
    return prizes;
  }
}
