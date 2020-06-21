import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/screens/services/auth.dart';
import 'package:hfascadets/screens/wrapper.dart';
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
        home: Wrapper(),
      ),
    );
  }
}
