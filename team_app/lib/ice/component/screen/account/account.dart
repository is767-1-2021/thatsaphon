import 'package:flutter/material.dart';
import 'package:team_app/controllers/userController.dart';
import 'package:team_app/ice/component/background.dart';
import 'package:team_app/main.dart';
import 'package:team_app/models/user_models.dart';
import 'package:team_app/models/usernameForm.dart';
import 'package:team_app/services/user_service.dart';
import 'package:provider/provider.dart';

class EditUser extends StatefulWidget {
  static String routeName = '/profile';

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  List<Accname> users = [Accname('', '', '', '', '', '')];
  bool isLoading = false;
  var service = AccnameServices();
  var controller;
  _EditUserState() {
    controller = AccnameController();
  }

  String editedBirthDate = "";
  String editedEmail = "";
  String editedFullName = "";
  String editedPhone = "";
  String editedUsername = "";
  String editedImage = "";

  @override
  void initState() {
    super.initState();

    _getUsers();
    controller.onSync
        .listen((bool synState) => setState(() => isLoading = synState));
  }

  void addProfile() async {
    await controller.addProfile(
      "",
      context.read<UserSession>().email,
      "",
      "",
      "",
      "",
    );
  }

  void updateProfile() async {
    await controller.updateProfile(
      editedBirthDate,
      editedEmail,
      editedFullName,
      editedPhone,
      editedUsername,
      editedImage,
    );
  }

  void _getUsers() async {
    var newUsers = await controller.fectname(context.read<UserSession>().email);
    if (newUsers.length == 0) {
      addProfile();
    }
    if (newUsers.length != 0) {
      setState(() {
        users = newUsers;
      });
    }
    editedBirthDate = newUsers[0].birthDate;
    editedEmail = newUsers[0].email;
    editedFullName = newUsers[0].fullName;
    editedPhone = newUsers[0].phone;
    editedUsername = newUsers[0].username;
    editedImage = newUsers[0].image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: users[0].email == ''
            ? Center(
                child: Text("Error: Cannot find user."),
              )
            : ListView(
                children: [
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            users[0].image == ""
                                ? CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/Avartar.png'),
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/" + users[0].image),
                                  ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          onChanged: (value) {
                            editedFullName = value;
                          },
                          initialValue: users[0].fullName,
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
                        child: TextFormField(
                          onChanged: (value) {
                            editedUsername = value;
                          },
                          initialValue: users[0].username,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Profile Name",
                            icon: Icon(Icons.person_pin),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          onChanged: (value) {
                            editedBirthDate = value;
                          },
                          initialValue: users[0].birthDate,
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
                        child: TextFormField(
                          onChanged: (value) {
                            editedPhone = value;
                          },
                          initialValue: users[0].phone,
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
                        child: TextFormField(
                          initialValue: users[0].email,
                          decoration: InputDecoration(
                            enabled: false,
                            border: UnderlineInputBorder(),
                            labelText: "Email",
                            icon: Icon(Icons.email),
                          ),
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.center,
                      //   margin: EdgeInsets.symmetric(horizontal: 40),
                      //   child: TextFormField(
                      //     decoration: InputDecoration(
                      //       border: UnderlineInputBorder(),
                      //       labelText: "Password",
                      //       icon: Icon(Icons.vpn_key),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: ElevatedButton(
                          onPressed: () {
                            updateProfile();
                            Navigator.pushNamed(context, '/acc');
                          },
                          child: Text("Save"),
                        ),
                      )
                    ],
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

// class EditUser extends StatefulWidget {
//   @override
//   _EditUserState createState() => _EditUserState();
// }

// class _EditUserState extends State<EditUser> {
//   var users;
//   bool isLoading = false;
//   var service = UserServices();
//   var controller;
//   _EditUserState() {
//     controller = UserController(service);
//   }

//   @override
//   void initState() {
//     super.initState();

//     _getUsers();
//     controller.onSync
//         .listen((bool synState) => setState(() => isLoading = synState));
//   }

//   void _getUsers() async {
//     var newUsers = await controller.fectUsers();

//     setState(() {
//       users = newUsers;
//     });
//   }

//   Widget get body => Column(
//         children: [Text("users.fullname"), Text("users.phone")],
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
