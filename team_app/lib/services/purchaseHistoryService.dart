import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/models/purchaseHistory.dart';

class PurchaseHistoryService {
  final invenRef = FirebaseFirestore.instance
      .collection('million_purchase_history')
      .withConverter<PurchaseHistory>(
          fromFirestore: (snapshot, _) =>
              PurchaseHistory.fromJson(snapshot.data()!),
          toFirestore: (purchaseHistory, _) => purchaseHistory.toJson());

  addInventory(String date, String lotNumPurchase, int pricePurchase,
      int qtyPurchase, String email) async {
    await invenRef.add(
      PurchaseHistory(date, lotNumPurchase, pricePurchase, qtyPurchase, email),
    );
  }
}
