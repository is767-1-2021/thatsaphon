import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/todo.dart';
import 'package:first_app/services/service.dart';

class TodoController {
  final Services service;
  List<Todo> todos = [];

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  TodoController(this.service);

  Future<List<Todo>> fetchTodos() async {
    onSyncController.add(true);
    todos = await service.getTodos();
    onSyncController.add(false);
    return todos;
  }

  Future<List<Todo>> updateTodos(int id) async {
    onSyncController.add(true);
    service.updateTodo(id);
    todos = await service.getTodos();
    return todos;
  }
}
