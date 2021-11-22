import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app/controllers/inventoryController.dart';
import 'package:team_app/controllers/notiController.dart';

import 'package:team_app/main.dart';
import 'package:team_app/models/inventories.dart';
import 'package:team_app/models/usernameForm.dart';
import 'package:team_app/services/inventoryService.dart';
import 'package:team_app/services/notiService.dart';

class ConfirmPaymentPage extends StatefulWidget {
  @override
  _ConfirmPaymentPageState createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  var service = FetchInventoryService();
  var service2 = NotisServices();
  var controller;
  var controller2;
  _ConfirmPaymentPageState() {
    controller = InventoryController(service);
    controller2 = NotisController(service2);
  }

  List<int> bgColor = [50, 100];
  List<int> remainingQuantity = [];
  @override
  Widget build(BuildContext context) {
    Cart cart = context.read<Inventories>().cart;
    remainingQuantity = List<int>.generate(
      cart.cartItems.length,
      (index) {
        for (index;
            index < context.read<Inventories>().cart.cartItems.length;
            index++) {
          for (var j = 0;
              j < context.read<Inventories>().inventories.length;
              j++) {
            if (context.read<Inventories>().cart.cartItems[index].number ==
                context.read<Inventories>().inventories[j].number) {
              return context.read<Inventories>().inventories[j].quantity;
            }
          }
          return 0;
        }
        return 0;
      },
    );
    int totalQuantity = 0;
    cart.cartItems.forEach((element) {
      totalQuantity = totalQuantity + element.qtyLotto;
    });

    _confirmPurchase(String lottoNum, int qtyLotto) async {
      await controller2.addNotis(
          context.read<UserSession>().email,
          "ทำรายการสำเร็จ",
          "คุณได้ซื้อล็อตเตอรี่เลข " +
              lottoNum +
              " จำนวน " +
              qtyLotto.toString() +
              " ใบ");
      await controller.confirmPurchase(
          lottoNum, qtyLotto, context.read<UserSession>().email);
      context.read<Inventories>().cart = new Cart("user", []);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ยืนยันการชำระเงิน'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: cart.cartItems.length + 1,
            itemBuilder: (context, index) {
              return index < cart.cartItems.length
                  ? Container(
                      height: 80,
                      // margin: EdgeInsets.symmetric(horizontal: 20),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.purple),
                        color: Colors.purple[bgColor[index % 2]],
                        // borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "${cart.cartItems[index].lottoNum}",
                              style: TextStyle(fontSize: 18),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "จำนวน",
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(2),
                                      // decoration:
                                      //     BoxDecoration(border: Border.all()),
                                      child: Text(
                                          "${cart.cartItems[index].qtyLotto}",
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                  ],
                                ),
                                // Text(
                                //   "จำนวนคงเหลือ ${remainingQuantity[index]}",
                                //   style: TextStyle(color: Colors.red),
                                // ),
                              ],
                            )
                          ]),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.orange,
                        ),
                        color: Colors.orange[100],
                        // borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("รวม $totalQuantity ใบ"),
                              Text("รวม ${totalQuantity * 80} บาท"),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              cart.cartItems.forEach((element) async {
                                _confirmPurchase(
                                    element.lottoNum, element.qtyLotto);
                                Navigator.pushNamed(context, '/');
                              });
                            },
                            child: Text("ยืนยัน"),
                          ),
                        ],
                      ),
                    );
            }),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
