import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsModel {
  final String header;
  final String image;
  final String newsDetail;

  NewsModel(this.header, this.image, this.newsDetail);

  factory NewsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return NewsModel(
      json['header'] as String,
      json['image'] as String,
      json['newsDetail'] as String,
    );
  }
}

class AllNews {
  final List<NewsModel> news;
  AllNews(this.news);

  factory AllNews.fromJson(List<dynamic> json) {
    List<NewsModel> news;

    news = json.map((index) => NewsModel.fromJson(index)).toList();

    return AllNews(news);
  }

  factory AllNews.fromSnapshot(QuerySnapshot s) {
    List<NewsModel> news = s.docs.map((DocumentSnapshot ds) {
      return NewsModel.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();

    return AllNews(news);
  }
}


// class Todo {
//   final int userId;
//   final int id;
//   final String title;
//   bool completed;

//   Todo(this.userId, this.id, this.title, this.completed);

//   factory Todo.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     return Todo(
//       json['userId'] as int,
//       json['id'] as int,
//       json['title'] as String,
//       json['completed'] as bool,
//     );
//   }
// }

// class AllTodos {
//   final List<Todo> todos;
//   AllTodos(this.todos);

//   factory AllTodos.fromJson(List<dynamic> json) {
//     List<Todo> todos;

//     todos = json.map((index) => Todo.fromJson(index)).toList();

//     return AllTodos(todos);
//   }

//   factory AllTodos.fromSnapshot(QuerySnapshot s) {
//     List<Todo> todos = s.docs.map((DocumentSnapshot ds) {
//       return Todo.fromJson(ds.data() as Map<String, dynamic>);
//     }).toList();

//     return AllTodos(todos);
//   }
// }