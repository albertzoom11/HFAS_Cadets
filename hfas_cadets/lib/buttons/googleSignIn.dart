import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/screen_arguments.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/screens/services/auth.dart';


final AuthService _auth = AuthService();

Widget googleSignInButton(BuildContext context) {
  return OutlineButton(
    splashColor: Colors.grey,
    onPressed: () async {
      dynamic result = await _auth.signInWithGoogle();
      if (result == null) {
        print('google sign in failed');
      } else {
        User user = _auth.currentUser;
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: ScreenArguments(user: user, tabNumber: 0),);
      }
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
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    ),
  );
}