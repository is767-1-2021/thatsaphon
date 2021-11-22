import 'dart:async';

import 'package:flutter/material.dart';
import 'package:team_app/alif/lottoList.dart';
import 'package:team_app/controllers/checkLottoController.dart';
import 'package:team_app/main.dart';
import 'package:team_app/models/prize.dart';
import 'package:provider/provider.dart';
import 'package:team_app/services/checkLottoService.dart';

class CheckPage extends StatefulWidget {
  var service = CheckLottoService();
  var controller;
  CheckPage() {
    controller = CheckLottoController();
  }

  @override
  _CheckPageState createState() => _CheckPageState(this.controller);
}

class _CheckPageState extends State<CheckPage> {
  final _formKey = GlobalKey<FormState>();
  String _lottoNo = "";
  String _dialog = "";
  List<LottoPrize> prizes = [];
  bool isLoading = false;

  CheckLottoController controller;

  _CheckPageState(this.controller);

  @override
  void initState() {
    super.initState();
    _getPrizes();
    controller.onSync
        .listen((bool synState) => setState(() => isLoading = synState));
  }

  var firstPrize = "";
  String secondPrize = "";
  String thirdPrize = "";
  String firstThree = "";
  String lastThree = "";
  String lastTwo = "";

  void _getPrizes() async {
    var newPrizes = await controller.fetchPrizes("1 พฤศจิกายน 2564");
    newPrizes.forEach((prize) {
      setState(() {
        prize.prize == "รางวัลที่ 1"
            ? firstPrize = prize.lottoNum
            : prize.prize == "รางวัลที่ 2"
                ? secondPrize += " " + prize.lottoNum
                : prize.prize == "รางวัลที่ 3"
                    ? thirdPrize += " " + prize.lottoNum
                    : prize.prize == "รางวัลเลขหน้า 3 ตัว"
                        ? firstThree += " " + prize.lottoNum
                        : prize.prize == "รางวัลเลขท้าย 2 ตัว"
                            ? lastTwo += " " + prize.lottoNum
                            : prize.prize == "รางวัลเลขท้าย 3 ตัว"
                                ? lastThree += " " + prize.lottoNum
                                : print("wrong format");
      });
    });
    setState(() {
      prizes = newPrizes;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<LottoList> NoList = [
      LottoList('รางวัลที่ 1', firstPrize),
      LottoList('เลขหน้า 3 ตัว', firstThree),
      LottoList('เลขท้าย 3 ตัว', lastThree),
      LottoList('เลขท้าย 2 ตัว', lastTwo),
      LottoList('รางวัลที่ 2', secondPrize),
      LottoList('รางวัลที่ 3', thirdPrize),
    ];
    return Scaffold(
        backgroundColor: Colors.purple[50],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            'ตรวจหวยจ้า',
            style: TextStyle(color: Colors.purple[500], fontSize: 24),
          )),
          backgroundColor: Colors.purple[50],
        ),
        bottomNavigationBar: BottomBar(),
        body: Center(
          child: Column(
            children: <Widget>[_form(), _list(NoList)],
          ),
        ));
  }

  _form() => Container(
        color: Colors.purple[100],
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'ตรวจสลากของท่าน'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'โปรดใส่เลขสลากของท่าน';
                    } else if (int.parse(value) > 999999) {
                      return 'หมายเลขต้องมีความยาว 6 ตัว';
                    }
                    // if (value == '145621') {
                    //   Navigator.pushNamed(
                    //     context,
                    //     '/congrat',
                    //   );
                    // } else if (value.substring(0, 3) == '118' ||
                    //     value.substring(0, 3) == '309') {
                    //   Navigator.pushNamed(context, '/congrat');
                    // } else if (value.substring(3, 6) == '143' ||
                    //     value.substring(3, 6) == '716') {
                    //   Navigator.pushNamed(context, '/congrat');
                    // } else if (value.substring(4, 6) == '12') {
                    //   Navigator.pushNamed(context, '/congrat');
                    // } else if (value != '145622') {
                    //   Navigator.pushNamed(context, '/sorry');
                    // }
                    return null;
                  },
                  onSaved: (value) {
                    _lottoNo = value!;
                  },
                  initialValue: context.read<FirstFormModel>().lottoNo,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      _dialog = "คุณไม่ถูกรางวัล";
                      prizes.forEach((prize) {
                        if (_lottoNo.length != 6) {
                          _dialog = "โปรดใส่เลขให้ครบ 6 หลัก";
                          return;
                        }
                        if (prize.prize == "รางวัลที่ 1" &&
                            _lottoNo == prize.lottoNum) {
                          _dialog = "ยินดีด้วยคุณถูกรางวัลที่ 1";
                          return;
                        }

                        if (prize.prize == "รางวัลที่ 2" &&
                            _lottoNo == prize.lottoNum) {
                          _dialog = "\nยินดีด้วยคุณถูกรางวัลที่ 2";
                          return;
                        }
                        if (prize.prize == "รางวัลที่ 3" &&
                            _lottoNo == prize.lottoNum) {
                          _dialog = "ยินดีด้วยคุณถูกรางวัลที่ 3";
                          return;
                        }
                        if (prize.prize == "รางวัลเลขท้าย 2 ตัว" &&
                            _lottoNo.substring(4, 6) == prize.lottoNum) {
                          _dialog = "\nยินดีด้วยคุณถูกเลขท้าย 2 ตัว";
                          return;
                        }
                        if (prize.prize == "รางวัลเลขท้าย 3 ตัว" &&
                            _lottoNo.substring(0, 3) == prize.lottoNum) {
                          _dialog = "ยินดีด้วยคุณถูกเลขท้าย 3 ตัว";
                          return;
                        }
                        if (prize.prize == "รางวัลเลขหน้า 3 ตัว" &&
                            _lottoNo.substring(0, 3) == prize.lottoNum) {
                          _dialog = "ยินดีด้วยคุณถูกเลขหน้า 3 ตัว";
                          return;
                        }
                      });

                      // if (_lottoNo == '145621') {
                      //   _dialog = "ยินดีด้วยคุณถูกรางวัลที่ 1";
                      //   // Navigator.pushNamed(
                      //   //   context,
                      //   //   '/congrat',
                      //   // );
                      // } else if (_lottoNo.substring(0, 3) == '118' ||
                      //     _lottoNo.substring(0, 3) == '309') {
                      //   _dialog = "ยินดีด้วยคุณถูกเลขหน้า 3 ตัว";
                      //   // Navigator.pushNamed(context, '/congrat');
                      // } else if (_lottoNo.substring(3, 6) == '143' ||
                      //     _lottoNo.substring(3, 6) == '716') {
                      //   _dialog = "ยินดีด้วยคุณถูกเลขท้าย 3 ตัว";
                      //   // Navigator.pushNamed(context, '/congrat');
                      // } else if (_lottoNo.substring(4, 6) == '12') {
                      //   _dialog = "ยินดีด้วยคุณถูกเลขท้าย 2 ตัว";
                      //   // Navigator.pushNamed(context, '/congrat');
                      // } else if (_lottoNo != '145622') {
                      //   _dialog = "คุณไม่ถูกรางวัล";
                      //   // Navigator.pushNamed(context, '/sorry');
                      // }

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'ผลการตรวจรางวัล',
                              style: TextStyle(fontSize: 25.0),
                            ),
                            content: Container(
                              child: Text(
                                '$_dialog',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            actions: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  icon: Icon(Icons.clear_outlined))
                            ],
                          );
                        },
                      );

                      context.read<FirstFormModel>().lottoNo = _lottoNo;
                    }
                  },
                  child: Text('ตรวจ'),
                  style: ElevatedButton.styleFrom(primary: Colors.purple[200]),
                ),
              ),
            ],
          ),
        ),
      );

  _list(List<LottoList> NoList) => Expanded(
        child: Card(
          color: Colors.purple[100],
          margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: Scrollbar(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                LottoList huay = NoList[index];
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Center(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          child: Text(
                            huay.name,
                            style: TextStyle(
                                color: Colors.purple[500],
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ),
                      ),
                      subtitle: Center(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          child: Text(
                            huay.prize,
                            style: TextStyle(
                                color: Colors.purple[500], fontSize: 22),
                          ),
                        ),
                      ),
                      isThreeLine: true,
                      onTap: () {},
                    ),
                    Divider(
                      height: 5.0,
                    ),
                  ],
                );
              },
              itemCount: NoList.length,
            ),
          ),
        ),
      );
}
