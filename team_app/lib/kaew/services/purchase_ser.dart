import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/kaew/model/purchase_model.dart';

abstract class Services {
  Future<List<PurHistory>> getlotto(String email);
}

class PurHistoryServices extends Services {
  @override
  Future<List<PurHistory>> getlotto(String email) async {
    QuerySnapshot snapshot = // read DB
        await FirebaseFirestore.instance
            .collection('million_purchase_history')
            .where('email', isEqualTo: email)
            .get();

    AllPurHistory purhistory = AllPurHistory.fromSnapshot(snapshot);
    return purhistory.purhistory;
  }
}
