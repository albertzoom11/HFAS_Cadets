import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/screen_arguments.dart';
import 'package:hfascadets/screens/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hfascadets/screens/authentication/sign_in.dart';
import 'package:hfascadets/screens/authentication/sign_up.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/shared/globals.dart' as globals;

class MainMenu extends StatefulWidget {

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  DatabaseService _database = DatabaseService();

  @override
  initState() {
    super.initState();
      initPlatformState();
  }

  initPlatformState() async {
    var prefs = await SharedPreferences.getInstance();
    String _uid = prefs.getString('uid');
    if (_uid != null) {
      print('globals.profileMonths: ${globals.profileMonths}');
      globals.user = await _database.getUser(_uid);
      globals.profileMonths = await _database.monthStats(DateTime.now().year.toString());
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: ScreenArguments(tabNumber: 0));
    }
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.indigo[900],
            Colors.indigo[800],
            Colors.blue[500],
          ]),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 220,),
              Image(
                image: AssetImage('assets/images/hfasLogo.png'), height: 150,
              ),
              SizedBox(height: 30,),
              Text(
                'HFAS Cadets',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.indigo[900],
                  ),
                  child: Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue[900],
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
