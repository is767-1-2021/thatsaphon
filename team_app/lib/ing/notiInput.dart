import 'package:flutter/material.dart';
import 'package:team_app/controllers/notiController.dart';
import 'package:team_app/ing/noti.dart';
import 'package:team_app/ing/notiListView.dart';
import 'package:team_app/models/notiform.dart';
import 'package:provider/provider.dart';
import 'package:team_app/services/notiService.dart';

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
  String notificationTitle = '';
  String notificationDetail = '';
  String email = '';

  var service = NotisServices();
  var controller;

  _InputFormState() {
    controller = NotisController(service);
  }

  _addNotis(
      String email, String notificationTitle, String notificationDetail) async {
    await controller.addNotis(email, notificationTitle, notificationDetail);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'เพิ่ม email ที่ต้องการส่งแจ้งเตือน :',
              icon: Icon(Icons.notification_add_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'ยังไม่ได้อัพเดทการแจ้งเตือนใหม่';
              }
              return null;
            },
            onSaved: (value) {
              email = value!;
            },
            // initialValue: context.read<Notis>().alert
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'เพิ่ม Notification Title :',
              icon: Icon(Icons.notification_add_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'ยังไม่ได้อัพเดทการแจ้งเตือนใหม่';
              }
              return null;
            },
            onSaved: (value) {
              notificationTitle = value!;
            },
            // initialValue: context.read<Notis>().alert
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'เพิ่ม Notifiaction Detail :',
              icon: Icon(Icons.notification_add_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'ยังไม่ได้อัพเดทการแจ้งเตือนใหม่';
              }
              return null;
            },
            onSaved: (value) {
              notificationDetail = value!;
            },
            // initialValue: context.read<Notis>().alert
          ),

          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
              _addNotis(email, notificationTitle, notificationDetail);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Listviewtest(),
                ),
              );
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
                  builder: (context) => Listviewtest(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
