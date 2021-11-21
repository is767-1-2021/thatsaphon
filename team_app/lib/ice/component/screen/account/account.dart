import 'package:flutter/material.dart';
import 'package:team_app/ice/component/background.dart';
import 'package:team_app/main.dart';

// import 'package:team_apps/components/background.dart';
class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(""),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Name",
                  icon: Icon(Icons.person),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Username",
                  icon: Icon(Icons.person_pin),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "BirthDate",
                  icon: Icon(Icons.cake),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Mobile Number",
                  icon: Icon(Icons.phone),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Email",
                  icon: Icon(Icons.email),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Password",
                  icon: Icon(Icons.vpn_key),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Center(
          child: Text(
            "Profile",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.purple[500], fontSize: 24),
          ),
        ),
        backgroundColor: Colors.purple[50],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

// class Users extends StatefulWidget {
//   final UserData users;
//   Users(this.users);

//   @override
//   _UsersState createState() => _UsersState(this.users);
// }

// class _UsersState extends State<Users> {
//   final UserData users;
//   bool isLoading = false;
//   var service = UserServices();
//   var controller;
//   _UsersState(this.users) {
//     controller = UserController(service);
//   }

//   @override
//   void initState() {
//     super.initState();

//     controller.onSync
//         .listen((bool synState) => setState(() => isLoading = synState));
//   }

//   void _getUsers() async {
//     var newNews = await controller.fectUsers();

//     // setState(() {
//     //   news = newNews;
//     // });
//   }

//   Widget get body => Column(
//         children: [Text(users.fullname), Text(users.phone)],
//       );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('News Detail'),
//       ),
//       body: Center(
//         child: body,
//       ),
//     );
//   }
// }