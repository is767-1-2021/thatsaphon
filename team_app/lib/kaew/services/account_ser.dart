import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/kaew/model/account_model.dart';

abstract class Services {
  Future<List<Accname>> getname();
}

class AccnameServices extends Services {
  @override
  Future<List<Accname>> getname() async {
    QuerySnapshot snapshot = // read DB
        await FirebaseFirestore.instance
            .collection('million_user_profile')
            .where('email', isEqualTo: 'abc@gmail.com')
            .get();

    AllAccname accname = AllAccname.fromSnapshot(snapshot);
    return accname.accname;
  }
}
