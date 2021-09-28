import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:team_app/models/userNameForm.dart';
import 'package:provider/provider.dart';

class Changeuser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แก้ไข Username',
          style: TextStyle(
            fontSize: 34.0,
          ),
        ),
      ),
      body: Center(child: Fillform()),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: 'คำสั่งซื้อ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'ตรวจรางวัล',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'การแจ้งเตือน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'บัญชีของฉัน',
          ),
        ],
        currentIndex: 4,
      ),
    );
  }
}

class Fillform extends StatefulWidget {
  @override
  _FillformState createState() => _FillformState();
}

class _FillformState extends State<Fillform> {
  final _formKey = GlobalKey<FormState>();
  String? _Username;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        padding: EdgeInsets.only(left: 50.0, right: 50.0),
        child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                style: TextStyle(
                  fontSize: 35.0,
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
                initialValue: context.read<UsernameFormModel>().Username,
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20.0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      context.read<UsernameFormModel>().Username = _Username;

                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'บันทึก',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ])),
      )
    ]);
  }
}
