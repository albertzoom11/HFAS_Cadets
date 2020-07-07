import 'package:flutter/material.dart';
import 'package:hfascadets/screens/authentication/sign_in.dart';
import 'package:hfascadets/screens/authentication/sign_up.dart';
import 'package:hfascadets/screens/services/auth.dart';
import 'package:hfascadets/animation/fadeAnimation.dart';

class MainMenu extends StatefulWidget {

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.indigo[900],
            Colors.indigo[800],
            Colors.blue[500],
          ]),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 220,),
              FadeAnimation(.5, Image(
                image: AssetImage('assets/images/hfasLogo.png'), height: 150,
              )),
              SizedBox(height: 30,),
              FadeAnimation(.7, Text(
                'HFAS Cadets',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              )),
              SizedBox(height: 30,),
              FadeAnimation(.9, GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.indigo[900],
                  ),
                  child: Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )),
              SizedBox(height: 30,),
              FadeAnimation(1.1, GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue[900],
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
