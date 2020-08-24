import 'package:cloud_firestore/cloud_firestore.dart';

class Shift {
  String imageUrl;
  String title;
  DateTime date;
  String timeIn;
  String timeOut;
  num hoursPassed;
  int numCalls;
  int numTasks;
  List<String> listOfTasks;

  Shift({this.imageUrl, this.title, this.date, this.timeIn, this.timeOut, this.hoursPassed, this.numCalls, this.numTasks, this.listOfTasks});

  Shift.fromData(Map<String, dynamic> data)
      : imageUrl = data['imageUrl'],
        title = data['title'],
        date = (data['date'] as Timestamp).toDate(),
        timeIn = data['timeIn'],
        timeOut = data['timeOut'],
        hoursPassed = data['hoursPassed'] % 1 == 0 ? data['hoursPassed'].toInt() : data['hoursPassed'],
        numCalls = data['numOfCalls'],
        numTasks = data['numOfTasks'],
        listOfTasks = (data['listOfTasks']).split('\$~\$');

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'date': date,
      'timeIn': timeIn,
      'timeOut': timeOut,
      'hoursPassed': hoursPassed,
      'numOfCalls': numCalls,
      'numOfTasks': numTasks,
      'listOfTasks': listOfTasks.join('\$~\$'),
    };
  }
}