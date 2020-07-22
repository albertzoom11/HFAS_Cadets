import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/screens/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  DatabaseService database = DatabaseService();
  User _currentUser;
  User get currentUser => _currentUser;

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      await database.updateUserEmail(user);
      _currentUser = await database.getUser(user.uid);
      return _currentUser;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      FirebaseUser user = result.user;
      await _populateCurrentUser(user);
      print(user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with google
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    //create a new document for the user using the uid
    bool isEmpty = await DatabaseService(uid: currentUser.uid).isRoleEmpty();
    if (isEmpty) {
      await DatabaseService(uid: currentUser.uid)
          .updateUserInfo(User(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        role: 'Cadet',
        totalHours: 0,
        totalCalls: 0,
        totalTasks: 0,
      ));
    }

    await _populateCurrentUser(user);
    return 'signInWithGoogle succeeded: $user';
  }

  // sign out with google
  Future signOutGoogle() async {
    try {
      await googleSignIn.signOut();
      await _auth.signOut();
      return 'success';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future signUpWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      FirebaseUser user = result.user;

      //create a new document for the user using the uid
      await DatabaseService(uid: user.uid).updateUserInfo(User(
        uid: user.uid,
        name: name,
        email: email,
        role: 'Cadet',
        totalHours: 0,
        totalCalls: 0,
        totalTasks: 0,
      ));

      try {
        await user.sendEmailVerification();
      } catch (e) {
        print('An error occured while trying to send email verification');
        print(e.toString());
      }
      return user != null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // reset password
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'success';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // update user email
  Future updateEmail(String value) async {
    // value is the email user inputs in a textfield and is validated
    FirebaseUser user = await _auth.currentUser();
    try {
      await user.updateEmail(value);
      try {
        await user.sendEmailVerification();
      } catch (e) {
        print('An error occured while trying to send email verification');
        print(e.toString());
      }
      return user;
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _auth.currentUser();
    await _populateCurrentUser(user); // Populate the user information
    return user != null;
  }
}
