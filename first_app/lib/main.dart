import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blueGrey,
          accentColor: Colors.black12,
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.purple))),

      // home: MyHomePage(title: "Nat's Home Page"),
      initialRoute: '/5',
      routes: <String, WidgetBuilder>{
        '/1': (c) => FirstPage(),
        '/2': (c) => SecondPage(),
        '/3': (c) => ThirdPage(),
        '/4': (c) => FourthPage(),
        '/5': (c) => FifthPage(),
        '/6': (c) => SixthPage(),
        '/about': (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('About Route'),
            ),
          );
        },
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      cat = cat1;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      cat = cat2;
    });
  }

  var cat = Image.asset(
    'assets/cat2.png',
    width: 120,
    height: 120,
  );
  var cat1 = Image.asset(
    'assets/cat1.png',
    width: 120,
    height: 120,
  );
  var cat2 = Image.asset(
    'assets/cat2.png',
    width: 120,
    height: 120,
  );

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 100.0, right: 100.0, bottom: 20),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20.0)),
              child: cat,
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: _decrementCounter,
                      child: Text('Decrease')),
                  ElevatedButton(
                      onPressed: _incrementCounter,
                      child: Text('Increase'),
                      style: ElevatedButton.styleFrom(primary: Colors.green)),
                ])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.fingerprint),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SubmitButton extends StatelessWidget {
  final String buttonText;
  SubmitButton(this.buttonText);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(this.buttonText),
      onPressed: () {
        print('Pressing');
      },
    );
  }
}

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

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Third Page"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.cloud),
              ),
              Tab(
                icon: Icon(Icons.beach_access_outlined),
              ),
              Tab(
                icon: Icon(Icons.brightness_1_outlined),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Cloud')),
            Center(child: Text('Umbrella')),
            Center(child: Text('Sunny'))
          ],
        ),
      ),
    );
  }
}

class FourthPage extends StatelessWidget {
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M'
  ];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Example'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(8.0),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            color: Colors.amber[colorCodes[index % 3]],
            child: Center(
              child: Text('Entry ${entries[index]}'),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}

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

class SixthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   'Please Enter Name',
          //   style: Theme.of(context).textTheme.headline5,
          // ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter something.';
              }
              return null;
            },
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Enter your firstname"),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter something.';
              }
              return null;
            },
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Enter your lastname"),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your age.';
              }
              if (int.parse(value) < 1) {
                print(int.parse(value));
                return 'Age must be a number and more than 0';
              }
              print(int.parse(value));
              return null;
            },
            decoration: InputDecoration(
                border: UnderlineInputBorder(), labelText: "Enter your age"),
          ),
          ElevatedButton(
              onPressed: () {
                // ถ้า validate ผ่าน จะเข้าเงื่อนไขนี้
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Pass')));
                }
              },
              child: Text('Validate')),
        ],
      ),
    );
  }
}
