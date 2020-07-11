import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/screen_arguments.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/screens/services/auth.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Add'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            onPressed: () async {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false,
                  arguments: ScreenArguments(
                      user: User(
                        uid: 'aaaa',
                        name: 'albert',
                        email: 'albert@albert.com',
                        role: 'Cadet',
                        totalHours: '0',
                        totalCalls: '0',
                        totalTasks: '0',
                      ),
                      tabNumber: 2),
              );
            },
            label: Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
