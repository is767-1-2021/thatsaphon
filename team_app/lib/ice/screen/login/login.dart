import 'package:flutter/material.dart';
import 'package:team_app/ice/component/background.dart';
import 'package:team_app/ice/component/screen/register/register.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
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
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Username",
                  icon: Icon(Icons.account_box),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
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
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () {},
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
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
    );
  }
}
