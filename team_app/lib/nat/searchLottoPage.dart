import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_app/models/inventories.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'searchedNumberPage.dart';

class SearchLottoPage extends StatefulWidget {
  @override
  _SearchLottoPageState createState() => _SearchLottoPageState();
}

class _SearchLottoPageState extends State<SearchLottoPage> {
  final _formKey = GlobalKey<FormState>();
  final items = ['item1', 'item2'];
  final List<Inventory> inventories = [
    Inventory("949695", 5),
    Inventory("086165", 3),
    Inventory("236331", 8),
    Inventory("236011", 7),
    Inventory("365343", 6),
    Inventory("805238", 2),
    Inventory("320015", 9),
    Inventory("920521", 7),
    Inventory("243595", 5),
    Inventory("056678", 4),
    Inventory("193178", 6),
  ];
  String? searchBox;
  String? searchType = "เลขท้าย 2 ตัว";
  List<Inventory> searchedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหาเลข'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              color: Colors.purple,
              child: Row(
                children: [
                  Text(
                    "งวดวันที่ 16 กันยายน 2564",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 1)),
                padding: EdgeInsets.only(left: 5),
                child: DropdownButton(
                  value: searchType,
                  icon: Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  items: [
                    "เลขท้าย 2 ตัว",
                    "เลขท้าย 3 ตัว",
                    "เลขหน้า 2 ตัว",
                    "เลขหน้า 3 ตัว",
                    "ทั้งชุด"
                  ]
                      .map((value) => DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => this.searchType = value as String?),
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.only(top: 2),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: TextFormField(
                validator: (value) {
                  if (searchType == "เลขหน้า 2 ตัว" &&
                      searchType == "เลขท้าย 2 ตัว" &&
                      value!.length != 2) {
                    return "ต้องใส่ให้ครบ 2 หลัก";
                  }
                  if (searchType == "เลขหน้า 3 ตัว" &&
                      searchType == "เลขท้าย 3 ตัว" &&
                      value!.length != 3) {
                    return "ต้องใส่ให้ครบ 3 หลัก";
                  }
                  if (searchType == "ทั้งชุด" && value!.length != 6) {
                    return "ต้องใส่ให้ครบ 6 หลัก";
                  }

                  if (int.tryParse(value!.substring(0, 1)) == null) {
                    return "ทุกๆตำแหน่งต้องเป็นตัวเลข";
                  }
                  if (int.tryParse(value.substring(1, 2)) == null) {
                    return "ทุกๆตำแหน่งต้องเป็นตัวเลข";
                  }
                  if (searchType != "เลขท้าย 2 ตัว" &&
                      searchType != "เลขหน้า 2 ตัว" &&
                      int.tryParse(value.substring(2, 3)) == null) {
                    return "ทุกๆตำแหน่งต้องเป็นตัวเลข";
                  }
                  if (searchType != "เลขท้าย 2 ตัว" &&
                      searchType != "เลขท้าย 3 ตัว" &&
                      searchType != "เลขหน้า 2 ตัว" &&
                      searchType != "เลขหน้า 3 ตัว" &&
                      int.tryParse(value.substring(3, 4)) == null) {
                    return "ทุกๆตำแหน่งต้องเป็นตัวเลข";
                  }
                  if (searchType != "เลขท้าย 2 ตัว" &&
                      searchType != "เลขท้าย 3 ตัว" &&
                      searchType != "เลขหน้า 2 ตัว" &&
                      searchType != "เลขหน้า 3 ตัว" &&
                      int.tryParse(value.substring(4, 5)) == null) {
                    return "ทุกๆตำแหน่งต้องเป็นตัวเลข";
                  }
                  if (searchType != "เลขท้าย 2 ตัว" &&
                      searchType != "เลขท้าย 3 ตัว" &&
                      searchType != "เลขหน้า 2 ตัว" &&
                      searchType != "เลขหน้า 3 ตัว" &&
                      int.tryParse(value.substring(5)) == null) {
                    return "ทุกๆตำแหน่งต้องเป็นตัวเลข";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "ใส่เลขที่ต้องการค้นหา",
                  icon: Icon(Icons.search),
                ),
                onSaved: (value) {
                  searchBox = value;
                },
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text('ค้นหา'),
                onPressed: () {
                  searchedItems.clear();
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (searchType == "เลขท้าย 2 ตัว") {
                      searchedItems.addAll(inventories.where((inventory) =>
                          inventory.number.substring(4, 6) == searchBox));
                    }
                    if (searchType == "เลขท้าย 3 ตัว") {
                      searchedItems.addAll(inventories.where((inventory) =>
                          inventory.number.substring(3, 6) == searchBox));
                    }
                    if (searchType == "เลขหน้า 2 ตัว") {
                      searchedItems.addAll(inventories.where((inventory) =>
                          inventory.number.substring(0, 2) == searchBox));
                    }
                    if (searchType == "เลขหน้า 3 ตัว") {
                      searchedItems.addAll(inventories.where((inventory) =>
                          inventory.number.substring(0, 3) == searchBox));
                    }
                    if (searchType == "ทั้งชุด") {
                      searchedItems.addAll(inventories.where((inventory) =>
                          inventory.number.substring(0, 6) == searchBox));
                    }
                    context.read<Inventories>().searchedInventories =
                        searchedItems;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchedNumberPage()));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
