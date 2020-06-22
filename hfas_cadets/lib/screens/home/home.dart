import 'package:flutter/material.dart';
import 'package:hfascadets/screens/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('HFAS Cadets'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            onPressed: () async {
              await _auth.signOut();
            },
            label: Text('log out'),
          ),
          FlatButton.icon(
            icon: Icon(Icons.person),
            onPressed: () async {
              await _auth.signOutGoogle();
            },
            label: Text('google sign out'),
          ),
        ],
      ),
    );
  }
}
