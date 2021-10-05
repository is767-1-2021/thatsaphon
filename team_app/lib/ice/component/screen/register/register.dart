import 'package:flutter/material.dart';
import 'package:team_app/ice/component/background.dart';
import 'package:team_app/ice/component/screen/account/account.dart';
import 'package:team_app/models/bottomBarIndex.dart';
import 'package:provider/provider.dart';
import 'package:team_app/ice/component/screen/login/login.dart';
// import 'package:team_apps/components/background.dart';
// import 'package:team_apps/components/screens/account/account.dart';
// import 'package:team_apps/screens/login/login.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 80, left: 40),
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7E57C2),
                      fontSize: 36,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              // SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'โปรดใส่ Username';
                    }
                  },
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Name",
                    icon: Icon(Icons.person),
                  ),
                ),
              ),
              // SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'โปรดใส่ Username';
                    }
                  },
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Email",
                    icon: Icon(Icons.email),
                  ),
                ),
              ),
              // SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'โปรดใส่ Username';
                    }
                  },
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Username",
                    icon: Icon(Icons.account_box),
                  ),
                ),
              ),
              // SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'โปรดใส่ Username';
                    }
                  },
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Password",
                    icon: Icon(Icons.vpn_key),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: () => {
                    if (_formKey.currentState!.validate())
                      {
                        _formKey.currentState!.save(),
                        context.read<BottomBarIndex>().bottomBarIndex = 4,
                        Navigator.pushNamed(context, "/profile"),
                      }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.5,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 40, left: 40, bottom: 130),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      ),
                    },
                    child: Text(
                      "Already have an Account? Sign in",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF673AB7),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// push(BuildContext context, MaterialPageRoute materialPageRoute) {}
