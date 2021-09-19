import 'package:first_app/pages/second_page.dart';
import 'package:first_app/pages/third_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String? _formData = 'Press me';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.arrow_back)),
          IconButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondPage()),
                    )
                  },
              icon: Icon(Icons.account_tree)),
          IconButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ThirdPage()),
                    )
                  },
              icon: Icon(Icons.add)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text('$_formData'),
            ),
            ElevatedButton(
              onPressed: () async {
                var response = await Navigator.pushNamed(context, '/6');
                if (response != null && !response.toString().isEmpty) {
                  setState(() {
                    _formData = response.toString();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(response.toString())));
                }
              },
              child: Text('Press me!'),
            ),
          ],
        ),
      ),
    );
  }
}
