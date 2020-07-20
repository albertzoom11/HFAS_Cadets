import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/screen_arguments.dart';
import 'package:hfascadets/screens/models/size_config.dart';
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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5 * SizeConfig.blockSizeVertical)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: EdgeInsets.fromLTRB(0, 1 * SizeConfig.blockSizeVertical, 0, 1 * SizeConfig.blockSizeVertical),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage("assets/images/google_logo.png"), height: 4.15 * SizeConfig.blockSizeVertical),
          Padding(
            padding: EdgeInsets.only(left: 2.3 * SizeConfig.blockSizeHorizontal),
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 2.3 * SizeConfig.blockSizeHorizontal,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    ),
  );
}