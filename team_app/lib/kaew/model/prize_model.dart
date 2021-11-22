import 'package:cloud_firestore/cloud_firestore.dart';

class LottoCheck {
  final String date;
  final String lottoNum;
  final String prize;

  LottoCheck(this.date, this.lottoNum, this.prize);

  factory LottoCheck.fromJson(
    Map<String, dynamic> json,
  ) {
    return LottoCheck(
      json['date'] as String,
      json['lottoNum'] as String,
      json['prize'] as String,
    );
  }
}

class AllLottoCheck {
  final List<LottoCheck> lottocheck;
  AllLottoCheck(this.lottocheck);

  factory AllLottoCheck.fromJson(List<dynamic> json) {
    List<LottoCheck> lottocheck;

    lottocheck = json.map((index) => LottoCheck.fromJson(index)).toList();
    return AllLottoCheck(lottocheck);
  }

  factory AllLottoCheck.fromSnapshot(QuerySnapshot s) {
    List<LottoCheck> lottocheck = s.docs
        .map((DocumentSnapshot ds) =>
            LottoCheck.fromJson(ds.data() as Map<String, dynamic>))
        .toList();

    return AllLottoCheck(lottocheck);
  }
}
