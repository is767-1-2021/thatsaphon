import 'package:flutter/material.dart';
import 'package:team_app/alif/lottoList.dart';
import 'package:team_app/main.dart';
import 'package:team_app/models/prize.dart';
import 'package:provider/provider.dart';

class CheckPage extends StatefulWidget {
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  final _formKey = GlobalKey<FormState>();
  String _lottoNo = "";
  String _dialog = "";

  List<LottoList> NoList = [
    LottoList('รางวัลที่ 1', '145621'),
    LottoList('เลขหน้า 3 ตัว', '118 309'),
    LottoList('เลขท้าย 3 ตัว', '143 716'),
    LottoList('เลขท้าย 2 ตัว', '12'),
    LottoList('รางวัลที่ 2', '123456  123456  123456  123456  123456'),
    LottoList('รางวัลที่ 3',
        '123456  123456  123456  123456  123456  123456  123456  123456  123456  123456'),
  ];

  @override
  Widget build(BuildContext context) {
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
            children: <Widget>[_form(), _list()],
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

                      if (_lottoNo == '145621') {
                        _dialog = "ยินดีด้วยคุณถูกรางวัลที่ 1";
                        // Navigator.pushNamed(
                        //   context,
                        //   '/congrat',
                        // );
                      } else if (_lottoNo.substring(0, 3) == '118' ||
                          _lottoNo.substring(0, 3) == '309') {
                        _dialog = "ยินดีด้วยคุณถูกเลขหน้า 3 ตัว";
                        // Navigator.pushNamed(context, '/congrat');
                      } else if (_lottoNo.substring(3, 6) == '143' ||
                          _lottoNo.substring(3, 6) == '716') {
                        _dialog = "ยินดีด้วยคุณถูกเลขท้าย 3 ตัว";
                        // Navigator.pushNamed(context, '/congrat');
                      } else if (_lottoNo.substring(4, 6) == '12') {
                        _dialog = "ยินดีด้วยคุณถูกเลขท้าย 2 ตัว";
                        // Navigator.pushNamed(context, '/congrat');
                      } else if (_lottoNo != '145622') {
                        _dialog = "คุณไม่ถูกรางวัล";
                        // Navigator.pushNamed(context, '/sorry');
                      }

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

  _list() => Expanded(
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
