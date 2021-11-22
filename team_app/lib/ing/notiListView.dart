import 'package:flutter/material.dart';
import 'package:team_app/controllers/notiController.dart';
import 'package:team_app/ing/notiInput.dart';
import 'package:team_app/main.dart';
import 'package:team_app/models/notiform.dart';
import 'package:team_app/models/usernameForm.dart';
import 'package:team_app/services/notiService.dart';
import 'package:provider/provider.dart';

class Listviewtest extends StatefulWidget {
  @override
  _ListviewtestState createState() => _ListviewtestState();
}

class _ListviewtestState extends State<Listviewtest> {
  List<Notis> notis = List.empty();
  bool isLoading = false;

  var service = NotisServices();
  var controller;

  _ListviewtestState() {
    controller = NotisController(service);
  }

  var children;

  @override
  void initState() {
    super.initState();
    _getnotis();

    controller.onSync
        .listen((bool synState) => setState(() => isLoading = synState));

    // service = NotisServices();
    // controller = NotisController(service!);
  }

  void _getnotis() async {
    var newNotis =
        await controller.fectNotis(context.read<UserSession>().email);

    setState(() {
      notis = newNotis;
    });
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: notis.isEmpty ? 1 : notis.length,
          itemBuilder: (context, index) {
            if (notis.isEmpty) {
              return Text('Notifications');
            }

            return Card(
              child: Container(
                height: 120,
                child: Column(
                  children: <Widget>[
                    Table(
                      children: [
                        TableRow(
                          children: [
                            Container(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 120,
                                  minHeight: 110,
                                  maxWidth: 120,
                                  maxHeight: 110,
                                ),
                                child: ListTile(
                                  title: Text(
                                    notis[index].notificationTitle,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    notis[index].notificationDetail,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading:
                                      Icon(Icons.notification_add_outlined),
                                  // leading:
                                  //     IconButton(notis[index].icon),
                                  //     onPressed(){},

                                  // leading: Image.asset(
                                  //     'assets/' + notis[index].image,
                                  //     fit: BoxFit.cover),
                                  // leading: Icon(Icons.brightness_low),
                                  tileColor: Colors.deepPurple[50],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('การแจ้งเตือนของคุณ'),
        actions: [
          InkWell(
            child: Icon(Icons.add),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Notiinput()));
            },
          ),
        ],
      ),
      body: Center(
        child: body,
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
