import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_app/main.dart';

class Statistic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สถิติหวยย้อนหลัง 15 ปี',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple[200],
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
          child: Icon(Icons.keyboard_arrow_left_sharp),
        ),
      ),
      body: Image.asset(
        'assets/History.JPG',
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
