import 'package:cloud_firestore/cloud_firestore.dart';

class PurHistory {
  final int qtyPurchase;
  final int pricePurchase;
  final String email;
  final String lotNumPurchase;
  final String datePurchase;
  final String date;

  PurHistory(this.qtyPurchase, this.pricePurchase, this.email,
      this.lotNumPurchase, this.datePurchase, this.date);

  factory PurHistory.fromJson(
    Map<String, dynamic> json,
  ) {
    return PurHistory(
      json['qtyPurchase'] as int,
      json['pricePurchase'] as int,
      json['email'] as String,
      json['lotNumPurchase'] as String,
      json['datePurchase'] as String,
      json['date'] as String,
    );
  }
}

class AllPurHistory {
  final List<PurHistory> purhistory;
  AllPurHistory(this.purhistory);

  factory AllPurHistory.fromJson(List<dynamic> json) {
    List<PurHistory> purhistory;

    purhistory = json.map((index) => PurHistory.fromJson(index)).toList();
    return AllPurHistory(purhistory);
  }

  factory AllPurHistory.fromSnapshot(QuerySnapshot s) {
    List<PurHistory> purhistory = s.docs.map((DocumentSnapshot ds) {
      return PurHistory.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();

    return AllPurHistory(purhistory);
  }
}
