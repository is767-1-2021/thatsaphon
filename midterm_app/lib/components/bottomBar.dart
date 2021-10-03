import 'package:flutter/material.dart';
import 'package:midterm_app/models/bottomBarIndex.dart';
import 'package:midterm_app/pages/searchLottoPage.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {},
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/');
              setState(() {
                context.read<BottomBarIndex>().bottomBarIndex = 0;
              });
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home),
                  ],
                ),
              ],
            ),
          ),
          label: 'หน้าหลัก',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              setState(() {
                context.read<BottomBarIndex>().bottomBarIndex = 1;
              });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchLottoPage()));
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search),
                  ],
                ),
              ],
            ),
          ),
          label: 'ค้นหาเลข',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/blank');
              setState(() {
                context.read<BottomBarIndex>().bottomBarIndex = 2;
              });
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.money),
                  ],
                ),
              ],
            ),
          ),
          label: 'ตรวจรางวัล',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/blank');
              setState(() {
                context.read<BottomBarIndex>().bottomBarIndex = 3;
              });
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications),
                  ],
                ),
              ],
            ),
          ),
          label: 'การแจ้งเตือน',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              setState(() {
                Navigator.pushNamed(context, '/blank');
                context.read<BottomBarIndex>().bottomBarIndex = 4;
              });
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person),
                  ],
                ),
              ],
            ),
          ),
          label: 'บัญชีของฉัน',
        ),
      ],
      currentIndex: context.read<BottomBarIndex>().bottomBarIndex,
    );
  }
}
