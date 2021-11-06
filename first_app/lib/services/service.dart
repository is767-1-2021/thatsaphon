import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:first_app/models/todo.dart';
import 'package:http/http.dart';

abstract class Services {
  Future<List<Todo>> getTodos();
  void updateTodo(int userId);
}

class FirebaseService extends Services {
  @override
  Future<List<Todo>> getTodos() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('todos').get();

    AllTodos todos = AllTodos.fromSnapshot(snapshot);
    return todos.todos;
  }

  void updateTodo(int id) async {
    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection('todos')
        .where('id', isEqualTo: id)
        .get();

    AllTodos todos = AllTodos.fromSnapshot(querySnap);
    print(todos.todos[0].id);

    QueryDocumentSnapshot doc = querySnap.docs[0];
    DocumentReference docRef = doc.reference;

    print(querySnap.docs[0]);
    print(docRef);

    await docRef.update({'completed': !todos.todos[0].completed});

    // CollectionReference todos = FirebaseFirestore.instance.collection('todos');
    // todos.doc(docRef).

    // .where("userId", isEqualTo: 1)
    // CollectionReference todos = FirebaseFirestore.instance.doc('todos/$userId');

    // AllTodos todos = AllTodos.fromSnapshot(querySnap);
    // print(todos.todos.length);
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
