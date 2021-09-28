import 'package:flutter/material.dart';
import 'package:team_app/models/prize.dart';
import 'package:provider/provider.dart';

class SorryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'เสียใจด้วยนะ อิอิ',
          style: TextStyle(color: Colors.purple[500], fontSize: 24),
        )),
        backgroundColor: Colors.purple[50],
      ),
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
      ),
      body: Center(
        child: Container(
          height: 300.0,
          margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
          padding: EdgeInsets.all(7.0),
          decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<FirstFormModel>(
                builder: (context, form, child) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Text(
                        'ขอแสดงความเศร้าเสียใจ หมายเลข ${form.lottoNo} ของคุณไม่ถูกรางวัล ',
                        style: TextStyle(fontSize: 40, color: Colors.grey),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
