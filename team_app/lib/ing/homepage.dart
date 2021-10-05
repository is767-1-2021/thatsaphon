import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String randomNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('หน้าหลัก'),
        backgroundColor: Colors.deepPurple[200],
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'เส้นทางเศรษฐี',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Colors.deepPurple[300],
              ),
            ),
            Image.asset(
              'assets/star.png',
              width: 250,
              height: 100,
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/sta');
                },
                child: Container(
                  child: Text(
                    'สถิติหวยย้อนหลัง 15 ปี',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.deepPurple[100],
              ),
              margin: EdgeInsets.all(1.0),
              padding: EdgeInsets.all(15.0),
              width: 320,
              alignment: Alignment.center,
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    randomNumber = (Random().nextInt(1001)).toString();
                  });
                },
                child: Container(
                  child: Text(
                    'เลขเด็ดแนะนำ $randomNumber',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.deepPurple[100],
                  ),
                  margin: EdgeInsets.all(1.0),
                  padding: EdgeInsets.all(15.0),
                  width: 320,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/lotto-news');
                },
                child: Container(
                  child: Text(
                    'ข่าวสารเลขเด็ด',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.deepPurple[100],
              ),
              margin: EdgeInsets.all(1.0),
              padding: EdgeInsets.all(15.0),
              width: 320,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
