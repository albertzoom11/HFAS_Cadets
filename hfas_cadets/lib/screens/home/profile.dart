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
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            onPressed: () async {
              dynamic result = await _auth.signOutGoogle();
              if (result == null) {
                print('sign out failed');
              } else {
                Navigator.pushNamedAndRemoveUntil(context, '/mainMenu', (route) => false);
              }
            },
            label: Text('Sign out'),
          ),
        ],
      ),
    );
  }
}