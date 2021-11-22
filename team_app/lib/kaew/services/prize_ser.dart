import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/kaew/model/prize_model.dart';

abstract class Services {
  Future<List<LottoCheck>> getLottoCheck();
}

// class LottoCheckService {
//   @override
//   Future<List<LottoCheck>> getLottoCheck() async {
//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('million_lottoprize'))
//         .get();

//     AllLottoCheck lottocheck = AllLottoCheck.fromSnapshot(snapshot);
//     return lottocheck.lottocheck;
//   }
// }
