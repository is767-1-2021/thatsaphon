import 'package:flutter/material.dart';
import 'package:team_app/ice/component/background.dart';
import 'package:team_app/ice/component/screen/register/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 80, bottom: 30),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "LOGIN",
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
                  onSaved: (value) {
                    _email = value!;
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
                      return 'โปรดใส่ Password';
                    }
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Password",
                    icon: Icon(Icons.vpn_key),
                  ),
                  obscureText: true,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7E57C2),
                  ),
                ),
              ),
              // SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (!EmailValidator.validate(_email!)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please Input your Email'),
                          ),
                        );
                      }
                      try {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _email!, password: _password!)
                            .then((value) {
                          _formKey.currentState!.reset();
                          Navigator.pushNamed(context, '/');
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('ไม่มีจ้า'),
                          ));
                        } else if (e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('email and password incorrect'),
                          ));
                        }
                      }
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
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 30,
                child: Text(
                  "- OR -",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7E57C2),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 30.0,
                child: Text(
                  "Sign in with",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7E57C2),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => print('Login with Google'),
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEDE7F6),
                      image: DecorationImage(
                        image: AssetImage('assets/google.png'),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 40, left: 40, bottom: 10),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          ),
                        },
                        child: Text(
                          "Don't have an Account? Sign up",
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF673AB7),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
