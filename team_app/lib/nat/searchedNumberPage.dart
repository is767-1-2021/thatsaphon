import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app/models/inventories.dart';

import '../main.dart';

class SearchedNumberPage extends StatefulWidget {
  @override
  String searchType = "";
  String searchNumber = "";
  SearchedNumberPage(this.searchType, this.searchNumber);
  _SearchedNumberPageState createState() =>
      _SearchedNumberPageState(searchType, searchNumber);
}

class _SearchedNumberPageState extends State<SearchedNumberPage> {
  String searchType = "";
  String searchNumber = "";
  _SearchedNumberPageState(this.searchType, this.searchNumber);
  List<int> addToCartNumbers = [];
  List<int> bgColor = [50, 100];
  List<int> cartItemQuantity = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$searchType: $searchNumber'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        child: Consumer<Inventories>(
          builder: (context, items, child) {
            if (addToCartNumbers.length == 0) {
              addToCartNumbers =
                  List.generate(items.searchedInventories.length, (index) => 0);
            }
            cartItemQuantity = List<int>.generate(
              addToCartNumbers.length,
              (index) {
                if (context.read<Inventories>().cart == null) {
                  return 0;
                }
                for (index;
                    index <
                        context.read<Inventories>().searchedInventories.length;
                    index++) {
                  for (var j = 0;
                      j < context.read<Inventories>().cart.cartItems.length;
                      j++) {
                    if (context.read<Inventories>().cart.cartItems[j].number ==
                        context
                            .read<Inventories>()
                            .searchedInventories[index]
                            .number) {
                      return context
                          .read<Inventories>()
                          .cart
                          .cartItems[j]
                          .quantity;
                    }
                  }
                  return 0;
                }
                return 0;
              },
            );
            return ListView.separated(
              itemBuilder: (context, index) {
                return Container(
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
                        "${items.searchedInventories[index].number}",
                        style: TextStyle(fontSize: 18),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "จำนวนในตะกร้า ${cartItemQuantity[index]}",
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (addToCartNumbers[index] != 0) {
                                      addToCartNumbers[index]--;
                                    }
                                  });
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Text("${addToCartNumbers[index]}",
                                    style: TextStyle(fontSize: 18)),
                              ),
                              InkWell(
                                onTap: () {
                                  if (addToCartNumbers[index] <
                                      items.searchedInventories[index]
                                          .quantity) {
                                    setState(() {
                                      addToCartNumbers[index]++;
                                    });
                                  }
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "จำนวนคงเหลือ ${items.searchedInventories[index].quantity}",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          if (context.read<Inventories>().cart != null) {
                            for (var i = 0;
                                i <
                                    context
                                        .read<Inventories>()
                                        .cart
                                        .cartItems
                                        .length;
                                i++) {
                              if (items.searchedInventories[index].number ==
                                  context
                                      .read<Inventories>()
                                      .cart
                                      .cartItems[i]
                                      .number) {
                                context
                                    .read<Inventories>()
                                    .cart
                                    .cartItems[i]
                                    .quantity = addToCartNumbers[index];
                                setState(() {});
                                break;
                              }
                              if (addToCartNumbers[index] > 0 &&
                                  i ==
                                      context
                                              .read<Inventories>()
                                              .cart
                                              .cartItems
                                              .length -
                                          1) {
                                context.read<Inventories>().cart.cartItems.add(
                                    Inventory(
                                        items.searchedInventories[index].number,
                                        addToCartNumbers[i]));
                              }
                            }
                            setState(() {});
                          }
                          if (context
                                  .read<Inventories>()
                                  .cart
                                  .cartItems
                                  .length ==
                              0) {
                            context.read<Inventories>().cart = new Cart(
                                "test", <Inventory>[
                              Inventory(items.searchedInventories[index].number,
                                  addToCartNumbers[index])
                            ]);
                            setState(() {});
                          }
                        },
                        child: Icon(
                          Icons.shopping_cart,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: items.searchedInventories.length,
            );
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
