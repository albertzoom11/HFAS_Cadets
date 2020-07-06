import 'package:flutter/material.dart';
import 'package:hfascadets/screens/services/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    double sidebarSize = mediaQuery.width * 0.65;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.indigo[900],
                Colors.indigo[800],
                Colors.blue[900],
              ]),
            ),
          ),
        ],
      ),
    );
  }
}