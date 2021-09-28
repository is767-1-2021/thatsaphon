import 'package:flutter/cupertino.dart';

class Inventories extends ChangeNotifier {
  List<Inventory>? _searchedInventories;
  List<Inventory>? _inventories;
  Cart? _cart;

  get searchedInventories => this._searchedInventories;

  set searchedInventories(value) =>
      {this._searchedInventories = value, notifyListeners()};

  get inventories => this._inventories;

  set inventories(value) => {this._inventories = value, notifyListeners()};

  get cart => this._cart;

  set cart(value) => {this._cart = value, notifyListeners()};
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
  String number;
  int quantity;
  Inventory(this.number, this.quantity);
}

// class Cart {
//   final String user;
//   final List<Inventory> cartItems;

//   const Cart({Key? key, required this.user, required this.cartItems});
// }

class Cart {
  String user;
  List<Inventory> cartItems;
  Cart(this.user, this.cartItems);
}
