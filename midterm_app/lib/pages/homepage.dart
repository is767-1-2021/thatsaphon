import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/components/bottomBar.dart';
import 'package:midterm_app/models/bottomBarIndex.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String randomNumber = '';

  @override
  Widget build(BuildContext context) {
    context.read<BottomBarIndex>().bottomBarIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('หน้าหลัก'),
        backgroundColor: Colors.deepPurple[200],
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () => Navigator.pushNamed(context, '/blank'),
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
                  Navigator.pushNamed(context, '/search');
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(
                          Icons.search_outlined,
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(right: 5),
                      ),
                      Text(
                        'ค้นหาเลข',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
                  Navigator.pushNamed(context, "/searched");
                },
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Icon(
                              Icons.list,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(right: 5),
                          ),
                          Text(
                            'หน้าเลขที่ค้นหาได้',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '(Title รับส่งค่า ควรกดจากหน้าค้นหา)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
                  Navigator.pushNamed(context, '/blank');
                },
                child: Container(
                  child: Text(
                    'Blank',
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
