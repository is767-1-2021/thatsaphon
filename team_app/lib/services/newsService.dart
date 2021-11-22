import 'dart:convert';
//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:team_app/models/newsModel.dart';

abstract class Services {
  Future<List<NewsModel>> getNews();
}

class NewsService extends Services {
  @override
  Future<List<NewsModel>> getNews() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('million_news').get();

    AllNews news = AllNews.fromSnapshot(snapshot);
    return news.news;
  }
}

// class HttpServices extends Services {
//   Client client = Client();

//   @override
//   Future<List<Todo>> getNews() async {
//     final response = await client.get(
//       Uri.parse('https://jsonplaceholder.typicode.com/todos'),
//     );

//     if (response.statusCode == 200) {
//       var all = AllTodos.fromJson(
//         json.decode(response.body),
//       );

//       return all.todos;
//     }

//     throw Exception('Failed to load todos');
//   }
// }