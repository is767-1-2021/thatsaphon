import 'package:flutter/material.dart';

class FifthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid View'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
            6,
            (index) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/${index + 1}');
                    // ScaffoldMessenger.of(context)
                    //     .showSnackBar(SnackBar(content: Text("hi")));
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Text(
                        'Item ${index + 1}',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
