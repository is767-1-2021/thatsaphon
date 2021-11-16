import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/models/prize.dart';

// class CheckLottoService {}

class CheckLottoService {
  @override
  Future<List<LottoPrize>> getPrizesByDate(String date) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('million_lottoprize')
        .where('date', isEqualTo: date)
        .get();

    AllLottoPrize allLottoPrize = AllLottoPrize.fromSnapshot(snapshot);
    return allLottoPrize.allLottoPrize;
  }
}
