import 'package:cloud_firestore/cloud_firestore.dart';

class Accname {
  final String birthDate;
  final String email;
  final String fullName;
  final String phone;
  final String username;
  final String image;

  Accname(this.birthDate, this.email, this.fullName, this.phone, this.username,
      this.image);

  factory Accname.toJson(Map<String, dynamic> json) {
    return Accname(json['birthDate'], json['email'], json['fullName'],
        json['phone'], json['username'], json['image']);
  }
  Map<String, dynamic> toJson() {
    return {
      'birthDate': birthDate,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'username': username,
      'image': image,
    };
  }

  factory Accname.fromJson(
    Map<String, dynamic> json,
  ) {
    return Accname(
      json['birthDate'] as String,
      json['email'] as String,
      json['fullName'] as String,
      json['phone'] as String,
      json['username'] as String,
      json['image'] as String,
    );
  }
}

class AllAccname {
  final List<Accname> accname;
  AllAccname(this.accname);

  factory AllAccname.fromJson(List<dynamic> json) {
    List<Accname> accname;

    accname = json.map((index) => Accname.fromJson(index)).toList();
    return AllAccname(accname);
  }

  factory AllAccname.fromSnapshot(QuerySnapshot s) {
    List<Accname> accname = s.docs.map((DocumentSnapshot ds) {
      return Accname.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();

    return AllAccname(accname);
  }
}
