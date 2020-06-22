import 'package:flutter/material.dart';
import 'package:hfascadets/screens/services/auth.dart';

final AuthService _auth = AuthService();

Widget googleSignInButton() {
  return OutlineButton(
    splashColor: Colors.grey,
    onPressed: () {
      _auth.signInWithGoogle();
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage("assets/images/google_logo.png"), height: 30.0),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    ),
  );
}