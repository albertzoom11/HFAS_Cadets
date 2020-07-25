import 'package:flutter/material.dart';
import 'package:hfascadets/screens/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Journal extends StatefulWidget {
  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Journal'),
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
                var prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/mainMenu', (route) => false);
              }
            },
            label: Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
