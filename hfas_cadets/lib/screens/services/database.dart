import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/shared/globals.dart' as globals;
import 'package:hfascadets/shared/month_stat.dart';

class DatabaseService {
  final uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

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
      await userCollection.document(globals.user.uid).setData(user.toJson());
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

  Future<bool> userIsEmpty() async {
    bool isEmpty;
    await userCollection.document(uid).get().then((data) {
      isEmpty = data.exists ? false : true;
    });
    return isEmpty;
  }

  Future<bool> monthIsEmpty(String year, String month) async {
    bool isEmpty;
    await userCollection
        .document(globals.user.uid)
        .collection(year)
        .document(month)
        .get()
        .then((data) {
      isEmpty = data.exists ? false : true;
    });
    return isEmpty;
  }

  Future monthStats(String year) async {
    List<Widget> output = [];
    for (int i = months.length - 1; i >= 0; i--) {
      await userCollection
          .document(globals.user.uid)
          .collection(year)
          .document(months[i])
          .get()
          .then((data) {
        if (data.exists) {
          output.add(MonthStat(
            month: months[i],
            points: data['points'] % 1 == 0 ? data['points'].toInt() : data['points'],
            hours: data['hours'] % 1 == 0 ? data['hours'].toInt() : data['hours'],
            calls: data['calls'],
            tasks: data['tasks'],
            shifts: data['shifts'],
          ));
        }
      });
    }
    return output;
  }

  // NOT IN USE YET
  Future addShift(String title, DateTime date, String timeIn, String timeOut,
      num hoursPassed, int numOfCalls, int numOfTasks) async {
    try {
      await userCollection
          .document(globals.user.uid)
          .collection(date.year.toString())
          .document(months[date.month - 1])
          .collection('shifts')
          .add({
        'title': title,
        'date': date.toString().substring(0, 10),
        'timeIn': timeIn,
        'timeOut': timeOut,
        'hoursPassed': hoursPassed,
        'numOfCalls': numOfCalls,
        'numOfTasks': numOfTasks,
      });
      return await addToMonthTotals(date.year.toString(),
          months[date.month - 1], hoursPassed, numOfCalls, numOfTasks);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future addToUserTotals(
      num hoursPassed, int numOfCalls, int numOfTasks) async {
    try {
      await userCollection.document(globals.user.uid).updateData({
        'totalHours': FieldValue.increment(hoursPassed),
        'totalCalls': FieldValue.increment(numOfCalls),
        'totalTasks': FieldValue.increment(numOfTasks),
      });
      globals.user.updateUserTotals(hoursPassed, numOfCalls, numOfTasks);
    } catch (e) {
      print(e.toString());
    }
  }

  Future addToMonthTotals(
      String year, String month, num hours, int calls, int tasks) async {
    num points = hours + calls + tasks;

    try {
      bool isEmpty = await monthIsEmpty(year, month);
      if (isEmpty) {
        await userCollection
            .document(globals.user.uid)
            .collection(year)
            .document(month)
            .setData({
          'points': points,
          'hours': hours,
          'calls': calls,
          'tasks': tasks,
          'shifts': 1,
        });
        return 'created';
      }
      await userCollection
          .document(globals.user.uid)
          .collection(year)
          .document(month)
          .updateData({
        'points': FieldValue.increment(points),
        'hours': FieldValue.increment(hours),
        'calls': FieldValue.increment(calls),
        'tasks': FieldValue.increment(tasks),
        'shifts': FieldValue.increment(1),
      });
      return 'added';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
