import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_app/controllers/userController.dart';
import 'package:team_app/ice/component/screen/login/login.dart';
import 'package:team_app/main.dart';
import 'package:team_app/models/bottomBarIndex.dart';
import 'package:team_app/models/user_models.dart';
import 'package:team_app/models/usernameForm.dart';
import 'package:provider/provider.dart';
import 'package:team_app/services/user_service.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  CollectionReference million_user_profile =
      FirebaseFirestore.instance.collection('million_user_profile');
  final _formKey = GlobalKey<FormState>();
  AccnameServices? services;
  AccnameController? controller;
  List<Accname> accname = [Accname('', '', '', '', '', '')];
  bool isLoading = false;
  String? username;

  void initState() {
    super.initState();

    controller = AccnameController();
    getname();
    controller!.onSync
        .listen((bool synState) => setState(() => isLoading = synState));
  }

  void getname() async {
    var newaccname =
        await controller!.fectname(context.read<UserSession>().email);

    if (newaccname.length != 0) {
      setState(() {
        accname = newaccname;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'บัญชีของฉัน',
            style: TextStyle(
              fontSize: 26.0,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.account_circle_rounded)),
          ],
        ),
        body: isLoading
            ? CircularProgressIndicator()
            : Column(children: [
                Container(
                  height: 150.0,
                  padding: EdgeInsets.all(8.0),
                  color: Colors.deepPurple[100],
                  child: Row(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(1000.0)),
                        child: accname[0].image == ''
                            ? Image.asset("assets/Avartar.png")
                            : Image.asset('assets/' + accname[0].image)),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 10.0, top: 30.0),
                              child: accname.length == 0
                                  ? Text("")
                                  : Text(accname[0].username,
                                      style: TextStyle(fontSize: 25.0))),
                          Container(
                              padding: EdgeInsets.only(left: 20.0),
                              child: ElevatedButton(
                                child: const Text(
                                  'แก้ไข Profile Name',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext Context) {
                                      return AlertDialog(
                                        content: Container(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                              Form(
                                                key: _formKey,
                                                child: TextFormField(
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border:
                                                        UnderlineInputBorder(),
                                                    labelText:
                                                        'แก้ไข Profile Name',
                                                    icon: Icon(Icons.edit),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'กรุณาแก้ไข Profile Name';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) =>
                                                      username = value,
                                                  initialValue:
                                                      accname[0].username,
                                                  // context
                                                  //     .read<UsernameFormModel>()
                                                  //     .Username,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: 20.0,
                                                ),
                                                child: ElevatedButton(
                                                    child: Text(
                                                      'บันทึก',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          _formKey.currentState!
                                                              .save();
                                                        }
                                                        million_user_profile
                                                            .where('email',
                                                                isEqualTo: context
                                                                    .read<
                                                                        UserSession>()
                                                                    .email)
                                                            .get()
                                                            .then((QuerySnapshot
                                                                querySnapshot) {
                                                          querySnapshot.docs
                                                              .forEach((doc) {
                                                            million_user_profile
                                                                .doc(doc.id)
                                                                .update({
                                                              'username':
                                                                  username
                                                            });
                                                          });
                                                          // updateUser(accname[0].id,
                                                          //     accname[index].user);
                                                          //   context
                                                          //       .read<UsernameFormModel>()
                                                          //       .username = _username;
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Account()));

                                                          // }
                                                        });
                                                      });
                                                    }),
                                              )
                                            ])),
                                      );
                                    },
                                  );
                                },
                              ))
                        ])
                  ]),
                ),
                Expanded(
                  child: ListView(shrinkWrap: true, children: [
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      tileColor: Colors.purple[50],
                      title: Text(
                        'แก้ไขข้อมูลส่วนตัว',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                      leading: Icon(Icons.mode_edit),
                    ),
                    ListTile(
                      tileColor: Colors.purple[50],
                      title: Text(
                        'กระเป๋าเงิน',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                      leading: Icon(Icons.local_atm),
                    ),
                    ListTile(
                        tileColor: Colors.purple[50],
                        title: Text(
                          'ประวัติการซื้อ',
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                        leading: Icon(Icons.history),
                        onTap: () {
                          Navigator.pushNamed(context, '/his');
                        }),
                    ListTile(
                      tileColor: Colors.purple[50],
                      title: Text(
                        'ตั้งค่า',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                      leading: Icon(Icons.settings),
                    ),
                    ListTile(
                        tileColor: Colors.purple[50],
                        title: Text(
                          'ช่องทางการติดต่อ',
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                        leading: Icon(
                          Icons.place,
                        )),
                    ListTile(
                        onTap: () {
                          context.read<UserSession>().email = "";
                          context.read<BottomBarIndex>().bottomBarIndex = 0;
                          Navigator.popUntil(
                              context, ModalRoute.withName('/login'));
                        },
                        tileColor: Colors.purple[50],
                        title: Text(
                          'ออกจากระบบ',
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                        leading: Icon(
                          Icons.logout,
                        ))
                  ]),
                )
              ]),
        bottomNavigationBar: BottomBar());
  }
}
