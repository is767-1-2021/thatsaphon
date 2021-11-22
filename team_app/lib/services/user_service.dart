import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/models/user_models.dart';

abstract class Services {
  Future<List<Accname>> getname();
  Future<void> updateProfile(
    String birthDate,
    String email,
    String fullName,
    String phone,
    String username,
    String image,
  );
}

class AccnameServices {
  @override
  Future<List<Accname>> getname() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('million_user_profile')
        .where('email', isEqualTo: 'abc@gmail.com')
        .get();

    print(snapshot);

    AllAccname accname = AllAccname.fromSnapshot(snapshot);
    return accname.accname;
  }

  Future<void> updateProfile(
    String birthDate,
    String email,
    String fullName,
    String phone,
    String username,
    String image,
  ) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('million_user_profile')
        .where('email', isEqualTo: email)
        .get();

    await snapshot.docs[0].reference.update({
      'birthDate': birthDate,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'username': username,
      'image': image
    });
  }
}
