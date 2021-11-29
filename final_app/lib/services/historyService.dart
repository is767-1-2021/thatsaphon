import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/models/historyModel.dart';

class HistoryService {
  Future<List<HistoryModel>> getHistoryFromFirebase() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('history').get();

    HistoriesModel hisories = HistoriesModel.fromSnapshot(snapshot);
    return hisories.histories;
  }

  addHistoryToFirebase(String calculation, String result) async {
    final historyRef = FirebaseFirestore.instance
        .collection('history')
        .withConverter<HistoryModel>(
            fromFirestore: (snapshot, _) =>
                HistoryModel.fromJson(snapshot.data()!),
            toFirestore: (history, _) => history.toJson());

    await historyRef.add(HistoryModel(calculation, result, Timestamp.now()));
  }
}
