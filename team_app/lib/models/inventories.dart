import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Inventories extends ChangeNotifier {
  List<Inventory> _searchedInventories = [];
  List<Inventory> _inventories = [];

  Inventories(this._inventories);

  Cart _cart = Cart('test', <Inventory>[]);

  get searchedInventories => this._searchedInventories;

  set searchedInventories(value) =>
      {this._searchedInventories = value, notifyListeners()};

  get inventories => this._inventories;

  set inventories(value) => {this._inventories = value, notifyListeners()};

  get cart => this._cart;

  set cart(value) => {this._cart = value, notifyListeners()};

  factory Inventories.fromJson(List<dynamic> json) {
    List<Inventory> inventories;

    inventories = json.map((e) => Inventory.fromJson(e)).toList();
    return Inventories(inventories);
  }

  factory Inventories.fromSnapshot(QuerySnapshot s) {
    List<Inventory> invetories = s.docs
        .map((DocumentSnapshot ds) =>
            Inventory.fromJson(ds.data() as Map<String, dynamic>))
        .toList();

    return Inventories(invetories);
  }
}

// class Inventory {
//   final String number;
//   final int quantity;
//   get getQuantity => this.quantity;

//   const Inventory({
//     Key? key,
//     required this.number,
//     required this.quantity,
//   });
// }

class Inventory {
  String lottoNum;
  int qtyLotto;
  Inventory(this.lottoNum, this.qtyLotto);

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(json['lottoNum'] as String, json['qtyLotto'] as int);
  }
  Map<String, dynamic> toJson() {
    return {
      'lottoNum': lottoNum,
      'qtyLotto': qtyLotto,
    };
  }
}

class Cart {
  String user;
  List<Inventory> cartItems;
  Cart(this.user, this.cartItems);

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      json['user'] as String,
      json['cartItems'] as List<Inventory>,
    );
  }
}
