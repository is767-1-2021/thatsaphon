import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseHistory {
  String date = "";
  String lotNumPurchase = "";
  int pricePurchase = 0;
  int qtyPurchase = 0;
  String email = "";

  PurchaseHistory(this.date, this.lotNumPurchase, this.pricePurchase,
      this.qtyPurchase, this.email);

  factory PurchaseHistory.fromJson(
    Map<String, dynamic> json,
  ) {
    return PurchaseHistory(
      json['datePurchase'] as String,
      json['lotNumPurchase'] as String,
      json['pricePurchase'] as int,
      json['qtyPurchase'] as int,
      json['email'] as String,
    );
  }

  String getMonth(String date) {
    var monthNumber = date.substring(5, 7);
    if (monthNumber == "1") return "มกราคม";
    if (monthNumber == "2") return "กุมภาพันธ์";
    if (monthNumber == "3") return "มีนาคม";
    if (monthNumber == "4") return "เมษายน";
    if (monthNumber == "5") return "พฤษภาคม";
    if (monthNumber == "6") return "มิถุนายน";
    if (monthNumber == "7") return "กรกฎาคม";
    if (monthNumber == "8") return "สิงหาคม";
    if (monthNumber == "9") return "กันยายน";
    if (monthNumber == "10") return "ตุลาคม";
    if (monthNumber == "11") return "พฤศจิกายน";
    if (monthNumber == "12") return "ธันวาคม";
    return "";
  }

  Map<String, dynamic> toJson() {
    var month = getMonth(date);
    var newDate =
        date.substring(8, 10) + " " + month + " " + date.substring(0, 4);

    return {
      'datePurchase': newDate,
      'lotNumPurchase': lotNumPurchase,
      'pricePurchase': pricePurchase,
      'qtyPurchase': qtyPurchase,
      'email': email,
    };
  }

  factory PurchaseHistory.getUsername(QuerySnapshot s, String username) {
    List<PurchaseHistory> purchaseHistories = s.docs
        .map((DocumentSnapshot ds) =>
            PurchaseHistory.fromJson(ds.data() as Map<String, dynamic>))
        .toList();

    List<PurchaseHistory> newPurchase = purchaseHistories
        .where((element) => element.email == username)
        .toList();

    return newPurchase[0];
  }
}
