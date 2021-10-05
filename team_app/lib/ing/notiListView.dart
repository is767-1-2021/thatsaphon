import 'package:flutter/material.dart';
import 'package:team_app/main.dart';

class Item {
  String noti;
  String update;
  Icon icon;

  Item({required this.noti, required this.update, required this.icon});
}

final List<Item> _item = [
  Item(
      noti: 'เสียใจด้วย งวดนี้ไม่ถูกนะ T^T',
      update: '1 ตุลาคม 2564',
      icon: Icon(Icons.bolt)),
  Item(
      noti: 'คุณยังไม่ได้ชำระคำสั่งซื้อในตะกร้า',
      update: '30 กันยายน 2564',
      icon: Icon(Icons.notification_important_rounded)),
  Item(
      noti: 'เลขเด็ดแม่น้ำหนึ่ง มาแล้ว!!',
      update: '29 กันยายน 2564',
      icon: Icon(Icons.brightness_low))
];

class Listviewtest extends StatefulWidget {
  @override
  _ListviewtestState createState() => _ListviewtestState();
}

class _ListviewtestState extends State<Listviewtest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'การแจ้งเตือน',
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: ListView.builder(
        itemCount: _item.length,
        itemBuilder: (BuildContext context, int index) {
          Item item = _item[index];

          return ListTile(
            title: Text(
              item.noti,
            ),
            subtitle: Text(item.update),
            leading: item.icon,
            tileColor: Colors.deepPurple[50],
          );
        },
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
