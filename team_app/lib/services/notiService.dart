import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:team_app/models/notiform.dart';

// V.1
// abstract class Services {
//   Future<List<Todo>> getTodos();
//   // Future<void> updateTodos(String notificationDetail, String notificationTitle);
// }

// class FirebaseServices extends Services {
//   @override
//   Future<List<Todo>> getTodos() async {
//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('million_notification')
//         .get();
//     AllTodos todos = AllTodos.fromSnapshot(snapshot);
//     return todos.todos;
//   }

// V.2
abstract class Services {
  Future<List<Notis>> getNotis(String email);
  Future<void> addNotis(
    String email,
    String notificationTitle,
    String notificationDetail,
  );
  // Future<void> updateTodos(String notificationDetail, String notificationTitle);
}

class NotisServices extends Services {
  @override
  Future<List<Notis>> getNotis(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('million_notification')
        .where('email', isEqualTo: email)
        .get();
    AllNotis notis = AllNotis.fromSnapshot(snapshot);
    return notis.notis;
  }

  @override
  Future<void> addNotis(
    String email,
    String notificationTitle,
    String notificationDetail,
  ) async {
    final notisRef = FirebaseFirestore.instance
        .collection('million_notification')
        .withConverter<Notis>(
            fromFirestore: (snapshot, _) => Notis.fromJson(snapshot.data()!),
            toFirestore: (notis, _) => notis.toJson());

    await notisRef.add(
      Notis(
        email,
        notificationTitle,
        notificationDetail,
      ),
    );
  }

//   @override
//   Future<void> updateTodos(
//       String notificationDetail, String notificationTitle) async {
//     CollectionReference _ref =
//         await FirebaseFirestore.instance.collection('million_notification');
//     FirebaseFirestore.instance
//         .collection('million_notification')
//         // .where('id', isEqualTo: _id)
//         .get();
//     //     .then((QuerySnapshot querySnapshot) {
//     //   querySnapshot.docs.forEach((doc) {
//     //     _ref
//     //         .doc(doc.id)
//     //         .update({'completed': completed})
//     //         .then((value) => print("Todos Updated"))
//     //         .catchError((error) => print("Failed to update Todos : $error"));
//     //   });
//     // });
//   }
// }

// class HttpServices extends Services {
//   Client client = Client();

// // สำหรับไปดึงข้อมูลจาก webserver แล้วโยนข้อมูลเข้า todo เพื่อมาเรียกใช้
// // สร้าง class ไว้เพื่อเวลาอยากไปเรียกใช้จากที่อื่นเช่น db จะได้แก้ได้ง่าย

//   Future<List<Todo>> getTodos() async {
//     final response = await client.get(Uri.parse(
//       'https://jsonplaceholder.typicode.com/todos',
//     ));

//     // เอา response ไปแปลงค่เปน Todo โดยต้อง check conditional statement ก่อน 200 คือ ok
//     if (response.statusCode == 200) {
//       var all = AllTodos.fromJson(
//         json.decode(response.body),
//       );

//       return all.todos;
//     }
//     throw Exception('Failed to load todos');
//   }

//   @override
//   Future<void> updateTodos(
//       String notificationDetail, String notificationTitle) {
//     // TODO: implement updateTodos
//     throw UnimplementedError();
//   }
}
