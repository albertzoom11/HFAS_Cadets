import 'package:flutter/material.dart';
import 'package:hfascadets/screens/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int _selectedItemIndex = 0;

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
        bottomNavigationBar: Material(
          elevation: 40,
          child: Container(
            child: Row(
              children: <Widget>[
                buildNavBarItem(Icons.home, 0),
                buildNavBarItem(Icons.date_range, 1),
                buildNavBarItem(Icons.add_circle, 2),
                buildNavBarItem(Icons.view_list, 3),
                buildNavBarItem(Icons.person, 4),
              ],
            ),
          ),
        )
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width/5,
        decoration: index == _selectedItemIndex ? BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 4, color: Colors.blue[900])
          ),
          gradient: LinearGradient(colors: [
            Colors.blue.withOpacity(0.3),
            Colors.blue.withOpacity(0.015),
          ],
          begin: Alignment.bottomCenter, end: Alignment.topCenter,
          )
//          color: index == _selectedItemIndex ? Colors.blue[900] : Colors.white,
        ) : BoxDecoration(),
        child: Icon(icon, color: index == _selectedItemIndex ? Colors.blue[900] : Colors.grey,),
      ),
    );
  }
}