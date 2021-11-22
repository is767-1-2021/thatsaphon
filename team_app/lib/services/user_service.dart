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
  Future<void> addProfile(
    String birthDate,
    String email,
    String fullName,
    String phone,
    String username,
    String image,
  );
}

class AccnameServices {
  Future<List<Accname>> getname(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('million_user_profile')
        .where('email', isEqualTo: email)
        .get();

    print(snapshot);

    AllAccname accname = AllAccname.fromSnapshot(snapshot);
    return accname.accname;
  }

  Future<void> addProfile(
    String birthDate,
    String email,
    String fullName,
    String phone,
    String username,
    String image,
  ) async {
    final userRef = FirebaseFirestore.instance
        .collection('million_user_profile')
        .withConverter<Accname>(
            fromFirestore: (snapshot, _) => Accname.fromJson(snapshot.data()!),
            toFirestore: (notis, _) => notis.toJson());

    await userRef.add(
      Accname(
        birthDate,
        email,
        fullName,
        phone,
        username,
        image,
      ),
    );
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
