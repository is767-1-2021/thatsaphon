import 'dart:async';

import 'package:team_app/models/inventories.dart';
import 'package:team_app/services/checkLottoService.dart';
import 'package:team_app/services/inventoryService.dart';

class InventoryController {
  final FetchInventoryService service;
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
}
