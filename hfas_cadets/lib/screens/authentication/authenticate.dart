import 'package:flutter/material.dart';
import 'package:hfascadets/screens/authentication/sign_in.dart';
import 'package:hfascadets/screens/authentication/sign_up.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignUp(),
    );
  }
}
