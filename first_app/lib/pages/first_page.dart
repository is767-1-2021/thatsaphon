import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.arrow_back)),
          IconButton(onPressed: () => {}, icon: Icon(Icons.account_tree))
        ],
      ),
      body: Center(
        child: Text('test'),
      ),
    );
  }
}
