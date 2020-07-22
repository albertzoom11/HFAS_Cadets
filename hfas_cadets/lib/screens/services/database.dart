import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hfascadets/screens/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future getUser(String uid) async {
    try {
      var userData = await userCollection.document(uid).get();
      User user = User.fromData(userData.data);
      return user;
    } catch (e) {
      return e.message;
    }
  }

  Future updateUserInfo(User user) async {
    try {
      await userCollection.document(user.uid).setData(user.toJson());
      return 'success';
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  // update just the email field
  Future updateUserEmail(FirebaseUser user) async {
    await userCollection
        .document(user.uid)
        .updateData({"email": user.email}).whenComplete(() async {
      print("Completed");
    }).catchError((e) => print(e));
  }

  Future<bool> isRoleEmpty() async {
    bool isEmpty;
    await userCollection.document(uid).get().then((data) {
      isEmpty = data.exists ? false : true;
    });
    return isEmpty;
  }

  // NOT IN USE YET
  Future addShift(String title, String date, String timeIn, String timeOut, num hoursPassed, int numOfCalls, int numOfTasks) async {
    try {
      return await userCollection.document(uid).collection('shifts').add({
        'title': title,
        'date': date,
        'timeIn': timeIn,
        'timeOut': timeOut,
        'hoursPassed': hoursPassed,
        'numOfCalls': numOfCalls,
        'numOfTasks': numOfTasks,
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future addToUserTotals(User user, num hoursPassed, int numOfCalls, int numOfTasks) async {
    try {
      await userCollection.document(uid).updateData({
        'totalHours': FieldValue.increment(hoursPassed),
        'totalCalls': FieldValue.increment(numOfCalls),
        'totalTasks': FieldValue.increment(numOfTasks),
      });
      user.updateUserTotals(hoursPassed, numOfCalls, numOfTasks);
    } catch (e) {
      print(e.toString());
    }
  }
}
