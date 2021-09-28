import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:team_app/main.dart';
import 'package:team_app/models/notiform.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    // final List<String> entries = <String>[
    //   // '1',
    //   // '2',
    //   // '3',
    //   // '4',
    //   // '5',
    // ];
    List<String> entries = context.read<NotiformModel>().alert;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'การแจ้งเตือน',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple[200],
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
          child: Icon(Icons.keyboard_arrow_left_sharp),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notification_add_rounded,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/input');
            },
          ),
        ],
      ),
      body: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.white,
            child: Consumer<NotiformModel>(
              builder: (context, form, child) {
                return Text('การแจ้งเตือน : ${form.alert[index]}');
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
