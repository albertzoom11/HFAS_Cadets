import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/screen_arguments.dart';
import 'package:hfascadets/screens/models/size_config.dart';
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
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.indigo[900],
                Colors.indigo[800],
                Colors.blue[500],
              ]),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.blockSizeVertical, horizontal: 1 * SizeConfig.blockSizeVertical),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    iconSize: 8 * SizeConfig.blockSizeHorizontal,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'CREATE ENTRY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 2.2 * SizeConfig.blockSizeVertical,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    iconSize: 8 * SizeConfig.blockSizeHorizontal,
                    onPressed: () {
                      print('post!!!');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
