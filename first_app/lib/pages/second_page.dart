import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.build_sharp),
        onPressed: () {},
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('test'),
          Table(
            children: [
              TableRow(children: [
                Container(
                  child: Center(child: Text('No')),
                  decoration: BoxDecoration(color: Colors.grey[300]),
                ),
                Container(
                  child: Center(child: Text('Name')),
                  decoration: BoxDecoration(color: Colors.grey[300]),
                ),
              ]),
              TableRow(children: [
                Container(
                  child: Center(child: Text('1')),
                  decoration: BoxDecoration(color: Colors.grey[300]),
                ),
                Container(
                  child: Center(child: Text('Thatsaphon')),
                  decoration: BoxDecoration(color: Colors.grey[300]),
                ),
              ]),
              TableRow(children: [
                Container(
                  child: Center(child: Text('2')),
                  decoration: BoxDecoration(color: Colors.grey[300]),
                ),
                Container(
                  child: Center(child: Text('Winai')),
                  decoration: BoxDecoration(color: Colors.grey[300]),
                ),
              ]),
            ],
          )
        ]),
      ),
    );
  }
}
