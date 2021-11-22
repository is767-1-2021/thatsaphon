import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/models/notiform.dart';
import 'package:team_app/services/notiService.dart';

class NotisController {
  final Services service;
  List<Notis> notis = List.empty();
  // List<Todo> todos = [];

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  NotisController(this.service);

  Future<List<Notis>> fectNotis(String email) async {
    onSyncController.add(true);
    notis = await service.getNotis(email);
    onSyncController.add(false);
    return notis;
  }

  addNotis(
    String email,
    String notificationTitle,
    String notificationDetail,
  ) async {
    await service.addNotis(email, notificationTitle, notificationDetail);
  }

  // Future<void> updateTodo(int id, bool completed) async {
  //   await service.updateTodos(id, completed);
  // }
}
