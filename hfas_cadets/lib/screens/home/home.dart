import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue[900],
        backgroundColor: Colors.blue[50],
        buttonBackgroundColor: Colors.blue[800],
        height: 50,
        items: <Widget>[
          Icon(Icons.home, size: 25, color: Colors.black,),
          Icon(Icons.chat_bubble, size: 25, color: Colors.black,),
          Icon(Icons.add_circle, size: 25, color: Colors.black,),
          Icon(Icons.view_list, size: 25, color: Colors.black,),
          Icon(Icons.person, size: 25, color: Colors.black,),
        ],
        index: 0,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          print('Current Index is $index');
        },
      ),
    );
  }
}
