import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/month_carousel.dart';
import 'package:hfascadets/screens/models/shift.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/shared/globals.dart' as globals;
import 'package:hfascadets/screens/models/month_stat.dart';

import 'conversions.dart';

class DatabaseService {
  final uid;

  DatabaseService({this.uid});

  final Conversions _conversions = Conversions();

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

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
      print("Updated User Email");
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
    for (int i = globals.months.length - 1; i >= 0; i--) {
      await userCollection
          .document(globals.user.uid)
          .collection(year)
          .document(globals.months[i])
          .get()
          .then((data) {
        if (data.exists) {
          output.add(MonthStat(
            month: globals.months[i],
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

  Future<List<Widget>> monthCarousels(String year) async {
    List<Widget> output = [];
    for (int i = globals.months.length - 1; i >= 0; i--) {
      await userCollection
          .document(globals.user.uid)
          .collection(year)
          .document(globals.months[i])
          .get()
          .then((data) {
            if (data.exists) {
               userCollection
                  .document(globals.user.uid)
                  .collection(year)
                  .document(globals.months[i])
                  .collection('shifts')
                  .orderBy('date', descending: true)
                  .snapshots()
                  .listen((snapshot) {
                List<Shift> _shifts = [];
                snapshot.documents.forEach((doc) {
                  _shifts.add(Shift.fromData(doc.data));
                });
                if (_shifts.length != 0) {
                  output.add(MonthCarousel(
                    monthIndex: i,
                    color: _conversions.getMonthColor(i+1),
                    shifts: _shifts,
                  ));
                }
              });
            }
      });
    }
    return output;
  }

  // NOT IN USE YET
  Future addShift(Shift shift) async {
    try {
      await userCollection
          .document(globals.user.uid)
          .collection(shift.date.year.toString())
          .document(globals.months[shift.date.month - 1])
          .collection('shifts')
          .document(shift.date.toString())
          .setData(shift.toJson());
      return await addToMonthTotals(shift.date.year.toString(),
          globals.months[shift.date.month - 1], shift.hoursPassed, shift.numCalls, shift.numTasks);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future addOrSubtractUserTotals(num hoursPassed, int numOfCalls, int numOfTasks) async {
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

  Future addToMonthTotals(String year, String month, num hours, int calls, int tasks) async {
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

  Future deleteMonth(String year, String month) async {
    num hours = 0;
    int calls = 0;
    int tasks = 0;
    try {
      await userCollection.document(globals.user.uid).collection(year).document(month).collection('shifts').getDocuments().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.documents){
          ds.reference.delete();
        }
      });
      await userCollection.document(globals.user.uid).collection(year).document(month).get().then((doc) {
        hours = doc.data['hours'];
        calls = doc.data['calls'];
        tasks = doc.data['tasks'];
      });
      await userCollection.document(globals.user.uid).collection(year).document(month).delete();
      await addOrSubtractUserTotals(-1 * hours, -1 * calls, -1 * tasks);
      return 'deleted month';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future deleteMonthFiles(List<String> urls) async {
    for (int i = 0; i < urls.length; i++) {
      StorageReference storageReference = await FirebaseStorage.instance.getReferenceFromUrl(urls[i]);
      await storageReference.delete();
      print('deleted image ${i + 1}');
    }
  }

  Future deleteShift(Shift shift) async {
    try {
      StorageReference storageReference = await FirebaseStorage.instance.getReferenceFromUrl(shift.imageUrl);
      await storageReference.delete();
      print('deleted shift image');

      await deleteShiftFromDatabase(shift);
      return 'deleted shift';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future deleteShiftFromDatabase(Shift shift) async {
    await userCollection.document(globals.user.uid).collection(shift.date.year.toString()).document(globals.months[shift.date.month - 1]).collection('shifts').document(shift.date.toString()).delete();
    await addOrSubtractUserTotals(-1 * shift.hoursPassed, -1 * shift.numCalls, -1 * shift.numTasks);
    print('deleted shift from firestore');

    try {
      bool lastShift = false;
      await userCollection.document(globals.user.uid).collection(shift.date.year.toString()).document(globals.months[shift.date.month - 1]).get().then((doc) {
        if (doc.data['shifts'] == 1) {
          lastShift = true;
        }
      });
      if (lastShift) {
        await userCollection.document(globals.user.uid).collection(shift.date.year.toString()).document(globals.months[shift.date.month - 1]).delete();
      } else {
        await userCollection.document(globals.user.uid).collection(shift.date.year.toString()).document(globals.months[shift.date.month - 1]).updateData({
          'shifts': FieldValue.increment(-1),
          'points': FieldValue.increment(-1 * (shift.hoursPassed + shift.numCalls + shift.numTasks)),
          'hours': FieldValue.increment(-1 * shift.hoursPassed),
          'calls': FieldValue.increment(-1 * shift.numCalls),
          'tasks': FieldValue.increment(-1 * shift.numTasks),
        });
      }
      return 'success';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getShiftData(DateTime dateTime) async {
    Shift newShift;
    await userCollection.document(globals.user.uid).collection(dateTime.year.toString()).document(globals.months[dateTime.month - 1]).collection('shifts').document(dateTime.toString()).get().then((doc) {
      newShift = Shift.fromData(doc.data);
    });
    return newShift;
  }

  Future editShift(Shift oldShift, Shift newShift) async {
    try {
      if (oldShift.imageUrl != newShift.imageUrl) {
        StorageReference storageReference = await FirebaseStorage.instance.getReferenceFromUrl(oldShift.imageUrl);
        await storageReference.delete();
      }
      await deleteShiftFromDatabase(oldShift);
      await addShift(newShift);
      return 'success';
    } catch (e) {
     print(e.toString());
     return null;
    }
  }
}
