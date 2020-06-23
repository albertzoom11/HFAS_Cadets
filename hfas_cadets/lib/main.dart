import 'package:flutter/material.dart';
import 'package:hfascadets/screens/authentication/forgot_password.dart';
import 'package:hfascadets/screens/authentication/main_menu.dart';
import 'package:hfascadets/screens/authentication/sign_in.dart';
import 'package:hfascadets/screens/authentication/sign_up.dart';
import 'package:hfascadets/screens/authentication/verification.dart';
import 'package:hfascadets/screens/home/home.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/screens/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
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

        },
        home: MainMenu(),
      ),
    );
  }
}
