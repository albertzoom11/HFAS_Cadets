import 'package:flutter/material.dart';
import 'package:hfascadets/screens/authentication/authenticate.dart';
import 'package:hfascadets/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hfascadets/screens/authentication/verification.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.providerData.length == 2) { // logged in using email and password
            return snapshot.data.isEmailVerified
                ? Home()
                : Verification();
          } else { // logged in using other providers
            return Home();
          }
        } else {
          return Authenticate();
        }
      },
    );
  }
}
