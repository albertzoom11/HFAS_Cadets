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
