import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_app/main.dart';
import 'package:team_app/models/inventories.dart';
import 'package:provider/provider.dart';

import 'searchedNumberPage.dart';

class SearchLottoPage extends StatefulWidget {
  @override
  _SearchLottoPageState createState() => _SearchLottoPageState();
}

class _SearchLottoPageState extends State<SearchLottoPage> {
  final _formKey = GlobalKey<FormState>();
  final items = ['item1', 'item2'];
  String searchBox = "";
  String searchType = "เลขท้าย 2 ตัว";
  List<Inventory> searchedItems = [];

  @override
  Widget build(BuildContext context) {
    final List<Inventory> inventories = context.read<Inventories>().inventories;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('ค้นหาเลข'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
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
                    "รางวัลที่ 1",
                    "แสดงทั้งหมด"
                  ]
                      .map((value) => DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => this.searchType = (value as String?)!),
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.only(top: 2),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: TextFormField(
                validator: (value) {
                  if (searchType == "แสดงทั้งหมด") {
                    return null;
                  }
                  if ((searchType == "เลขหน้า 2 ตัว" ||
                          searchType == "เลขท้าย 2 ตัว") &&
                      value!.length != 2) {
                    return "ต้องใส่ให้ครบ 2 หลัก";
                  }
                  if ((searchType == "เลขหน้า 3 ตัว" ||
                          searchType == "เลขท้าย 3 ตัว") &&
                      value!.length != 3) {
                    return "ต้องใส่ให้ครบ 3 หลัก";
                  }
                  if (searchType == "รางวัลที่ 1" && value!.length != 6) {
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
                  searchBox = value!;
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
                    if (searchType == "รางวัลที่ 1") {
                      searchedItems.addAll(inventories.where((inventory) =>
                          inventory.number.substring(0, 6) == searchBox));
                    }
                    if (searchType == "แสดงทั้งหมด") {
                      searchedItems.addAll(inventories);
                    }
                    context.read<Inventories>().searchedInventories =
                        searchedItems;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchedNumberPage(searchType, searchBox)));
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
