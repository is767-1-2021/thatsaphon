import 'package:flutter/material.dart';
import 'package:midterm_app/models/inventories.dart';
import 'package:midterm_app/pages/blankPage.dart';
import 'package:midterm_app/pages/homepage.dart';
import 'package:midterm_app/pages/searchLottoPage.dart';
import 'package:midterm_app/pages/searchedNumberPage.dart';
import 'models/bottomBarIndex.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomBarIndex(),
        ),
        ChangeNotifierProvider(
          create: (context) => Inventories(),
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
          fontFamily: 'JasmineUPC',
          bottomAppBarColor: Colors.purple[200]),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => HomeScreen(),
        '/search': (context) => SearchLottoPage(),
        '/searched': (context) =>
            SearchedNumberPage("ค้นหาเลข", "Title for test"),
        '/blank': (context) => BlankPage(),
      },
    );
  }
}
