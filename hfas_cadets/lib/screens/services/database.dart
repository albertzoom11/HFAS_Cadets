import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hfascadets/screens/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future getUser(String uid) async {
    try {
      var userData = await userCollection.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      return e.message;
    }
  }

  Future updateUserData(User user) async {
    try {
      await userCollection.document(user.uid).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isRoleEmpty() async {
    bool isEmpty;
    await userCollection.document(uid).get().then((data) {
      isEmpty =  data.exists ? false : true;
    });
    return isEmpty;
  }

  // NOT IN USE YET
  Future addShift(String date, String timeIn, String timeOut, String totalHours, String numOfCalls, String numOfTasks) async {
    return await userCollection.document(uid).collection('shifts').add({
      'date' : date,
      'timeIn' : timeIn,
      'timeOut' : timeOut,
      'totalHours' : totalHours,
      'numOfCalls' : numOfCalls,
      'numOfTasks' : numOfTasks,
    });
  }
}