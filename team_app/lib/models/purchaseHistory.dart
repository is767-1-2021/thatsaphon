import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseHistory {
  String date = "";
  String lotNumPurchase = "";
  int pricePurchase = 0;
  int qtyPurchase = 0;
  String username = "";

  PurchaseHistory(this.date, this.lotNumPurchase, this.pricePurchase,
      this.qtyPurchase, this.username);

  factory PurchaseHistory.fromJson(
    Map<String, dynamic> json,
  ) {
    return PurchaseHistory(
      json['date'] as String,
      json['lotNumPurchase'] as String,
      json['pricePurchase'] as int,
      json['qtyPurchase'] as int,
      json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'lotNumPurchase': lotNumPurchase,
      'pricePurchase': pricePurchase,
      'qtyPurchase': qtyPurchase,
      'username': username,
    };
  }

  factory PurchaseHistory.getUsername(QuerySnapshot s, String username) {
    List<PurchaseHistory> purchaseHistories = s.docs
        .map((DocumentSnapshot ds) =>
            PurchaseHistory.fromJson(ds.data() as Map<String, dynamic>))
        .toList();

    List<PurchaseHistory> newPurchase = purchaseHistories
        .where((element) => element.username == username)
        .toList();

    return newPurchase[0];
  }
}
