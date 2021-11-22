import 'package:cloud_firestore/cloud_firestore.dart';

class Notis {
  final String email;
  final String notificationTitle;
  final String notificationDetail;
  // final String icon;

  Notis(
    this.email,
    this.notificationTitle,
    this.notificationDetail,
    // this.icon
  );

  factory Notis.fromJson(
    Map<String, dynamic> json,
  ) {
    return Notis(
      json['email'] as String,
      json['notificationTitle'] as String,
      json['notificationDetail'] as String,
      // json['icon'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'notificationTitle': notificationTitle,
      'notificationDetail': notificationDetail,
    };
  }
}

class AllNotis {
  final List<Notis> notis;
  AllNotis(this.notis);

  factory AllNotis.fromJson(List<dynamic> json) {
    List<Notis> notis;

    notis = json.map((index) => Notis.fromJson(index)).toList();

    return AllNotis(notis);
  }

  // for convert snapshot ไปเปน todo ข้างบน
  factory AllNotis.fromSnapshot(QuerySnapshot s) {
    List<Notis> notis = s.docs.map((DocumentSnapshot ds) {
      return Notis.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();

    return AllNotis(notis);
  }
}
