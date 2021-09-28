import 'package:flutter/material.dart';
import 'package:team_app/ing/noti.dart';
import 'package:team_app/models/notiform.dart';
import 'package:provider/provider.dart';

class Notiinput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input การแจ้งเตือน'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: InputForm(),
    );
  }
}

class InputForm extends StatefulWidget {
  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  String _alert = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Input การแจ้งเตือน :',
              icon: Icon(Icons.notification_add_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'ยังไม่ได้อัพเดทการแจ้งเตือนใหม่';
              }
              return null;
            },
            onSaved: (value) {
              _alert = value!;
            },
            // initialValue: context.read<NotiformModel>().alert
          ),

          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (context.read<NotiformModel>().alert == null) {
                  //ถ้ากล่องยังไม่ได้สร้าง (เป็นค่าว่าง) ก้สร้างกล่อง [] (V)
                  var temp = <String>[];
                  //สร้างตัวแปรเพื่อเก็บกล่องเปล่า
                  temp.add(_alert);
                  context.read<NotiformModel>().alert = temp;

                  return;
                }
                if (context.read<NotiformModel>().alert != null) {
                  var temp = new List<String>.from(
                      context.read<NotiformModel>().alert);
                  temp.add(_alert);
                  context.read<NotiformModel>().alert = temp;
                }

                //click แล้วใส่ string เข้าไป

                // context.read<NotiformModel>().alert = _alert;
              }
            },
            child: Text('อัพโหลดข้อมูล'),
          ),

          // Icon ไว้ link to Noti page เฉยๆ
          IconButton(
            icon: Icon(
              Icons.home_max,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Notifications(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
