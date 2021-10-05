import 'package:flutter/material.dart';

import '../main.dart';

final _item = <Item>[
  Item(headerValue: 'งวดวันที่ 16 กันยายน 2564', expandedValue: [
    Item2(lotto: '145621', number: '1ใบ'),
    Item2(lotto: '118468', number: '2ใบ'),
    Item2(lotto: '205716', number: '2ใบ'),
    Item2(lotto: '157312', number: '5ใบ')
  ]),
  Item(headerValue: 'งวดวันที่ 1 กันยายน 2564', expandedValue: [
    Item2(lotto: '651950', number: '1ใบ'),
    Item2(lotto: '541327', number: '4ใบ')
  ]),
];

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Widget _buildListPanel() {
    return ExpansionPanelList.radio(
      children: _item
          .map((tile) => ExpansionPanelRadio(
                value: tile.headerValue,
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) => buildTile(tile),
                backgroundColor: Colors.deepPurple[100],
                body: Column(
                  children: tile.expandedValue.map(buildTile2).toList(),
                ),
              ))
          .toList(),
    );
  }

  Widget buildTile(Item tile) => ListTile(
        leading: Icon(Icons.local_attraction_sharp),
        tileColor: Colors.deepPurple[100],
        title: Text(
          tile.headerValue,
          style: TextStyle(fontSize: 20.0),
        ),
      );

  Widget buildTile2(Item2 tile2) => ListTile(
      leading: Icon(Icons.local_attraction_sharp),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          tile2.lotto,
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          tile2.number,
          style: TextStyle(fontSize: 18.0),
        )
      ]),
      tileColor: Colors.purple[50],
      trailing: IconButton(
          icon: Icon(
            Icons.check_box_outlined,
            color: Colors.purple,
          ),
          onPressed: () {
            if (tile2.lotto == '145621') {
              showDialog(
                context: context,
                builder: (BuildContext Context) {
                  return AlertDialog(
                    title: Text(
                      'ผลการตรวจรางวัล',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    content: Container(
                      child: Text(
                        'ยินดีด้วย คุณถูกรางวัลที่1!!',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          icon: Icon(Icons.clear_outlined))
                    ],
                  );
                },
              );
            } else if (tile2.lotto.substring(0, 3) == '118' ||
                tile2.lotto.substring(0, 3) == '309') {
              showDialog(
                context: context,
                builder: (BuildContext Context) {
                  return AlertDialog(
                    title: Text(
                      'ผลการตรวจรางวัล',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    content: Container(
                      child: Text(
                        'ยินดีด้วย คุณถูกเลขหน้า3ตัว!',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          icon: Icon(Icons.clear_outlined))
                    ],
                  );
                },
              );
            } else if (tile2.lotto.substring(3, 6) == '143' ||
                tile2.lotto.substring(3, 6) == '716') {
              showDialog(
                context: context,
                builder: (BuildContext Context) {
                  return AlertDialog(
                    title: Text(
                      'ผลการตรวจรางวัล',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    content: Container(
                      child: Text(
                        'ยินดีด้วย คุณถูกเลขท้าย3ตัว!!',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          icon: Icon(Icons.clear_outlined))
                    ],
                  );
                },
              );
            } else if (tile2.lotto.substring(4, 6) == '12') {
              showDialog(
                context: context,
                builder: (BuildContext Context) {
                  return AlertDialog(
                    title: Text(
                      'ผลการตรวจรางวัล',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    content: Container(
                      child: Text(
                        'ยินดีด้วย คุณถูกเลขท้าย2ตัว!!',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          icon: Icon(Icons.clear_outlined))
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext Context) {
                  return AlertDialog(
                    title: Text(
                      'ผลการตรวจรางวัล',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    content: Container(
                      child: Text(
                        'เสียใจด้วยจ้า',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          icon: Icon(Icons.clear_outlined))
                    ],
                  );
                },
              );
            }
          }));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ประวัติการซื้อ',
          style: TextStyle(fontSize: 28.0),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.history)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildListPanel(),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class Item {
  String headerValue;
  List<Item2> expandedValue;
  bool isExpanded;

  Item(
      {required this.headerValue,
      this.expandedValue = const [],
      this.isExpanded = false});
}

class Item2 {
  String lotto;
  String number;
  bool isExpanded;

  Item2({required this.lotto, required this.number, this.isExpanded = false});
}
