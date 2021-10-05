import 'package:flutter/material.dart';
import 'package:team_app/ice/component/screen/login/login.dart';
import 'package:team_app/main.dart';
import 'package:team_app/models/usernameForm.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _formKey = GlobalKey<FormState>();

  String? _Username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'บัญชีของฉัน',
          style: TextStyle(
            fontSize: 26.0,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.account_circle_rounded)),
        ],
      ),
      body: Column(children: <Widget>[
        Container(
          height: 150.0,
          padding: EdgeInsets.all(8.0),
          color: Colors.deepPurple[100],
          child: Row(children: [
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(1000.0)),
                child: Image.asset(
                  'assets/alif.jpg',
                )),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  padding: const EdgeInsets.only(
                      left: 20.0, bottom: 10.0, top: 30.0),
                  child: Consumer<UsernameFormModel>(
                      builder: (context, form, child) {
                    return Text(
                      '${form.Username}',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: (FontWeight.w300)),
                    );
                  })),
              Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: ElevatedButton(
                    child: const Text(
                      'แก้ไข username',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext Context) {
                          return AlertDialog(
                            content: Container(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                  Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'แก้ไข Username',
                                        icon: Icon(Icons.edit),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณาแก้ไข Username';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _Username = value;
                                      },
                                      initialValue: context
                                          .read<UsernameFormModel>()
                                          .Username,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: 20.0,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();

                                          context
                                              .read<UsernameFormModel>()
                                              .Username = _Username;

                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        'บันทึก',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ])),
                          );
                        },
                      );
                    },
                  ))
            ])
          ]),
        ),
        Expanded(
          child: ListView(shrinkWrap: true, children: [
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              tileColor: Colors.purple[50],
              title: Text(
                'แก้ไขข้อมูลส่วนตัว',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              leading: Icon(Icons.mode_edit),
            ),
            ListTile(
              tileColor: Colors.purple[50],
              title: Text(
                'กระเป๋าเงิน',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              leading: Icon(Icons.local_atm),
            ),
            ListTile(
                tileColor: Colors.purple[50],
                title: Text(
                  'ประวัติการซื้อ',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                leading: Icon(Icons.history),
                onTap: () {
                  Navigator.pushNamed(context, '/his');
                }),
            ListTile(
              tileColor: Colors.purple[50],
              title: Text(
                'ตั้งค่า',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              leading: Icon(Icons.settings),
            ),
            ListTile(
                tileColor: Colors.purple[50],
                title: Text(
                  'ช่องทางการติดต่อ',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                leading: Icon(
                  Icons.place,
                )),
            ListTile(
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName('/login'));
                },
                tileColor: Colors.purple[50],
                title: Text(
                  'ออกจากระบบ',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                leading: Icon(
                  Icons.logout,
                ))
          ]),
        )
      ]),
      bottomNavigationBar: BottomBar(),
    );
  }
}
