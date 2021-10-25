import 'dart:async';
import 'dart:io';

import 'package:first_app/models/todo.dart';
import 'package:first_app/services/service.dart';

class TodoController {
  final HttpServices services;
  List<Todo> todos = [];

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  TodoController(this.services);

  Future<List<Todo>> fetchTodos() async {
    onSyncController.add(true);
    todos = await services.getTodos();
    onSyncController.add(false);
    return todos;
  }
}
