import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:team_app/controllers/newsController.dart';
import 'package:team_app/main.dart';
import 'package:team_app/models/newsModel.dart';
import 'package:team_app/services/newsService.dart';

class NewsPage extends StatefulWidget {
  // final NewsController controller;
  // Newspage({required this.controller});

  @override
  _NewspageState createState() => _NewspageState();
}

class _NewspageState extends State<NewsPage> {
  List<NewsModel> news = List.empty();
  bool isLoading = false;

  var service = NewsService();
  var controller;
  _NewspageState() {
    controller = NewsController(service);
  }

  @override
  void initState() {
    super.initState();
    _getNews();

    controller.onSync
        .listen((bool synState) => setState(() => isLoading = synState));
  }

  void _getNews() async {
    var newNews = await controller.fectNews();

    setState(() {
      news = newNews;
    });
  }

  navigateToDetail(NewsModel news) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailNews(news)));
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: news.isEmpty ? 1 : news.length,
          itemBuilder: (context, index) {
            if (news.isEmpty) {
              return Text('Tap button to fetch Lotto News');
            }

            return Card(
              child: Container(
                height: 120,
                child: Column(
                  children: <Widget>[
                    Table(
                      children: [
                        TableRow(
                          children: [
                            Container(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 120,
                                  minHeight: 120,
                                  maxWidth: 120,
                                  maxHeight: 120,
                                ),
                                child: ListTile(
                                    leading: Image.asset(
                                        'assets/images/' + news[index].image,
                                        fit: BoxFit.cover),
                                    title: Text(news[index].header),
                                    onTap: () {
                                      navigateToDetail(news[index]);
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข่าวสารเลขเด็ด'),
      ),
      body: Center(
        child: body,
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class DetailNews extends StatefulWidget {
  final NewsModel news;
  DetailNews(this.news);

  @override
  _DetailNewsState createState() => _DetailNewsState(this.news);
}

class _DetailNewsState extends State<DetailNews> {
  final NewsModel news;
  bool isLoading = false;
  var service = NewsService();
  var controller;
  _DetailNewsState(this.news) {
    controller = NewsController(service);
  }

  @override
  void initState() {
    super.initState();

    _getNews();
    controller.onSync
        .listen((bool synState) => setState(() => isLoading = synState));
  }

  void _getNews() async {
    var newNews = await controller.fectNews();

    // setState(() {
    //   news = newNews;
    // });
  }

  Widget get body => Column(
        children: [
          Container(
            width: 400,
            margin: EdgeInsets.only(
                left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
            // padding: EdgeInsets.all(7.0),
            // decoration: BoxDecoration(
            //   color: Colors.purple[50],
            // borderRadius: BorderRadius.circular(10.0),
            // ),
            child: Text(
              news.header,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            // padding: EdgeInsets.all(7.0),
            // decoration: BoxDecoration(
            //   color: Colors.purple[50],
            //   borderRadius: BorderRadius.circular(10.0),
            // ),
            child: Text(
              news.newsDetail,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดข่าว'),
      ),
      body: Center(
        child: body,
      ),
    );
  }
}
