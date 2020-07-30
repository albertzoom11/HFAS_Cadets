class Shift {
  String imageUrl;
  String title;
  String date;
  String timeIn;
  String timeOut;
  num hoursPassed;
  int numCalls;
  int numTasks;

  Shift({this.imageUrl, this.title, this.date, this.timeIn, this.timeOut, this.hoursPassed, this.numCalls, this.numTasks});

  Shift.fromData(Map<String, dynamic> data)
      : imageUrl = data['imageUrl'],
        title = data['title'],
        date = data['date'],
        timeIn = data['timeIn'],
        timeOut = data['timeOut'],
        hoursPassed = data['hoursPassed'],
        numCalls = data['numOfCalls'],
        numTasks = data['numOfTasks'];

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
    };
  }
}