import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hfascadets/screens/authentication/forgot_password.dart';
import 'package:hfascadets/screens/authentication/main_menu.dart';
import 'package:hfascadets/screens/authentication/sign_in.dart';
import 'package:hfascadets/screens/authentication/sign_up.dart';
import 'package:hfascadets/screens/authentication/verification.dart';
import 'package:hfascadets/screens/home/add.dart';
import 'package:hfascadets/screens/home/calendar.dart';
import 'package:hfascadets/screens/home/home.dart';
import 'package:hfascadets/screens/home/journal.dart';
import 'package:hfascadets/screens/home/profile.dart';
import 'package:hfascadets/screens/operations/edit_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue[900],
        ),
        routes: {
          "/mainMenu": (_) => MainMenu(),
          "/signIn": (_) => SignIn(),
          "/signUp": (_) => SignUp(),
          "/verification": (_) => Verification(),
          "/forgotPassword": (_) => ForgotPassword(),
          "/home": (_) => Home(),
          "/calendar": (_) => Calendar(),
          "/journal": (_) => Journal(),
          "/profile": (_) => Profile(),
          "/add": (_) => Add(),
          "/edit_profile": (_) => EditProfile(),
        },
        home: MainMenu(),
    );
  }
}
