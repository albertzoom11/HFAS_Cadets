class User {
  final String uid;
  String name;
  String email;
  String role;
  int roundedTotalHours;
  num totalHours;
  num totalCalls;
  num totalTasks;

  User({this.uid, this.name, this.email, this.role, this.totalHours, this.totalCalls, this.totalTasks});

  User.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        name = data['name'],
        email = data['email'],
        role = data['role'],
        totalHours = data['totalHours'],
        roundedTotalHours = data['totalHours'].round(),
        totalCalls = data['totalCalls'],
        totalTasks = data['totalTasks'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'totalHours': totalHours,
      'totalCalls': totalCalls,
      'totalTasks': totalTasks,
    };
  }

  updateUserTotals(num hoursPassed, int numOfCalls, int numOfTasks) {
    totalHours += hoursPassed;
    roundedTotalHours = totalHours.round();
    totalCalls += numOfCalls;
    totalTasks += numOfTasks;
  }
}