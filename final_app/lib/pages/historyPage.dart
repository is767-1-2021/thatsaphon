import 'package:final_app/controllers/historyController.dart';
import 'package:final_app/models/historyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("History"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 20),
        itemCount: context.read<HistoriesModel>().histories.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(15),
            // height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    context.read<HistoriesModel>().histories[index].calculation,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Text(
                  context.read<HistoriesModel>().histories[index].result,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                ),
                Divider(
                  thickness: 3,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
