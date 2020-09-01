import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hfascadets/shared/globals.dart' as globals;
import 'package:simple_animations/simple_animations.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.indigo[900],
          Color.fromRGBO(20, 52, 143, 1),
        ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 1.5 * SizeConfig.blockSizeVertical,
                    horizontal: 2 * SizeConfig.blockSizeHorizontal),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      iconSize: 8 * SizeConfig.blockSizeHorizontal,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 3 * SizeConfig.blockSizeHorizontal,),
                    Text(
                      'SETTINGS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 2.5 * SizeConfig.blockSizeVertical,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 13 * SizeConfig.blockSizeVertical),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(3 * SizeConfig.blockSizeVertical),
                      topRight: Radius.circular(3 * SizeConfig.blockSizeVertical)),
                ),
                height: 87 * SizeConfig.blockSizeVertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 3 * SizeConfig.blockSizeVertical),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/editProfile');
                            },
                            child: Container(
                              height: 9 * SizeConfig.blockSizeVertical,
                              alignment: Alignment.center,
                              child: ListTile(
                                title: Text(
                                  "Edit Profile",
                                  style: TextStyle(color: Colors.indigo[900]),
                                ),
                                leading: Icon(
                                  Icons.person,
                                  color: Colors.indigo[900],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 0,
                          color: Colors.indigo[900],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Divider(
                          height: 0,
                          color: Colors.indigo[900],
                        ),
                        FlatButton(
                          onPressed: () async {
                            await _auth.signOutGoogle();
                            Navigator.pushNamedAndRemoveUntil(context, '/mainMenu', (route) => false);
                          },
                          child: Container(
                            height: 9 * SizeConfig.blockSizeVertical,
                            alignment: Alignment.center,
                            child: ListTile(
                              title: Text(
                                "Sign Out",
                                style: TextStyle(color: Colors.indigo[900]),
                              ),
                              leading: Icon(
                                Icons.exit_to_app,
                                color: Colors.indigo[900],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
