import 'package:flutter/material.dart';
import 'package:team_app/alif/checkPage.dart';
import 'package:team_app/alif/congratPage.dart';
import 'package:team_app/alif/lottoNewsPage.dart';
import 'package:team_app/alif/newsPage.dart';
import 'package:team_app/alif/sorryPage.dart';
import 'package:team_app/ice/component/screen/account/account.dart';
import 'package:team_app/ice/component/screen/login/login.dart';
import 'package:team_app/ice/component/screen/register/register.dart';
import 'package:team_app/ing/homepage.dart';
import 'package:team_app/ing/notiInput.dart';
import 'package:team_app/ing/statistic.dart';
import 'package:team_app/models/inventories.dart';
import 'package:team_app/models/notiform.dart';
import 'package:team_app/models/prize.dart';
import 'package:team_app/models/usernameForm.dart';
import 'package:team_app/nat/searchLottoPage.dart';
import 'package:provider/provider.dart';

import 'ing/notiListView.dart';
import 'kaew/account.dart';
import 'kaew/history.dart';
import 'models/bottomBarIndex.dart';
import 'nat/cartPage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Inventories(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotiformModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirstFormModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UsernameFormModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomBarIndex(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: AppBarTheme(
            color: Colors.deepPurple[200],
          ),
          fontFamily: 'Prompt',
          bottomAppBarColor: Colors.purple[200]),
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/': (context) => HomeScreen(),
        '/acc': (context) => Account(),
        '/his': (context) => History(),
        '/sta': (context) => Statistic(),
        '/lotto-news': (context) => LottoNewsPage(),
        '/news': (context) => NewsPage(),
        '/check': (context) => CheckPage(),
        '/congrat': (context) => CongratPage(),
        '/sorry': (context) => SorryPage(),
        '/noti': (context) => Listviewtest(),
        '/input': (context) => Notiinput(),
        '/search': (context) => SearchLottoPage(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/profile': (context) => ProfileScreen(),
        '/cart': (context) => CartPage(),
      },
    );
  }
}

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
              if (context.read<BottomBarIndex>().bottomBarIndex != 0) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
                setState(() {
                  context.read<BottomBarIndex>().bottomBarIndex = 0;
                });
              }
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
              Navigator.pushNamed(context, '/check');
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
              Navigator.pushNamed(context, '/noti');
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
                Navigator.pushNamed(context, '/acc');
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
