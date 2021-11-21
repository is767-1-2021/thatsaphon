import 'dart:async';

import 'package:team_app/models/inventories.dart';
import 'package:team_app/models/purchaseHistory.dart';
import 'package:team_app/services/checkLottoService.dart';
import 'package:team_app/services/inventoryService.dart';
import 'package:team_app/services/purchaseHistoryService.dart';

class InventoryController {
  final FetchInventoryService service;
  var purchaseHistoryService = PurchaseHistoryService();
  List<Inventory> inventories = [];

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  InventoryController(this.service);

  Future<List<Inventory>> fetchAllInventory() async {
    onSyncController.add(true);
    inventories = await service.fetchInventories();
    onSyncController.add(false);
    return inventories;
  }

  void addInventory(String lottoNum, int qty) async {
    await service.addInventory(lottoNum, qty);
  }

  void confirmPurchase(String lottoNum, int qty) async {
    String now = DateTime.now().toLocal().toString();
    await service.updateInventory(lottoNum, qty);
    await purchaseHistoryService.addInventory(
        now, lottoNum, qty * 80, qty, "username");
  }
}
