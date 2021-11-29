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
  List<HistoryModel> histories = [];
  bool isLoading = false;

  HistoryController controller = HistoryController();

  // getHistories() async {
  //   var tempHistories = await controller.fetchHistories();

  //   setState(() {
  //     histories = tempHistories;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   controller.onSync.listen((event) => setState(() => isLoading = event));
  //   getHistories();
  // }

  @override
  Widget build(BuildContext context) {
    histories = context.read<HistoriesModel>().histories;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("History"),
        actions: [
          // Container(
          //   child: Icon(Icons.calculate),
          //   margin: EdgeInsets.only(right: 15),
          // )
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 20),
        itemCount: histories.length,
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
                    histories[index].calculation,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Text(
                  histories[index].result,
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
