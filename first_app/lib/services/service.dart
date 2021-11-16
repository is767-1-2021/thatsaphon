import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:first_app/models/todo.dart';
import 'package:http/http.dart';

abstract class Services {
  Future<List<Todo>> getTodos(int id);
  Future<List<Todo>> updateTodo(int userId);
}

class FirebaseService extends Services {
  @override
  Future<List<Todo>> getTodos(int id) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('todos')
        .where('id', isEqualTo: id)
        .get();

    AllTodos todos = AllTodos.fromSnapshot(snapshot);
    return todos.todos;
  }

  Future<List<Todo>> updateTodo(int id) async {
    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection('todos')
        .where('id', isEqualTo: id)
        .get();

    AllTodos todo = AllTodos.fromSnapshot(querySnap);

    QueryDocumentSnapshot doc = querySnap.docs[0];
    DocumentReference docRef = doc.reference;

    await docRef.update({'completed': !todo.todos[0].completed});

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('todos').get();

    AllTodos todos = AllTodos.fromSnapshot(snapshot);
    return todos.todos;
  }
}

class HttpServices {
  Client client = Client();

  Future<List<Todo>> getTodos() async {
    final response = await client.get(Uri.parse(
      'https://jsonplaceholder.typicode.com/todos',
    ));

    if (response.statusCode == 200) {
      var all = AllTodos.fromJson(
        json.decode(response.body),
      );
      return all.todos;
    }

    throw Exception('Failed to load todos');
  }
}



// class FirebaseServices {
//   Future<List<Todo>> getTodos() async {
//     QuerySnapshot snapshot =
//         await FirebaseFirestore.instance.collection('todos').get();

//     AllTodos todos = AllTodos.fromSnapshot(snapshot);
//     return todos.todos;
//   }
// }
