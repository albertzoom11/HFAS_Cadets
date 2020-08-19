class User {
  final String uid;
  String profilePic;
  String name;
  String email;
  String role;
  num totalHours;
  num totalCalls;
  num totalTasks;

  User({this.uid, this.name, this.profilePic, this.email, this.role, this.totalHours, this.totalCalls, this.totalTasks});

  User.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        profilePic = data['profilePic'],
        name = data['name'],
        email = data['email'],
        role = data['role'],
        totalHours = data['totalHours'],
        totalCalls = data['totalCalls'],
        totalTasks = data['totalTasks'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'profilePic': profilePic,
      'name': name,
      'email': email,
      'role': role,
      'totalHours': totalHours,
      'totalCalls': totalCalls,
      'totalTasks': totalTasks,
    };
  }

  incrementUserTotals(num hoursPassed, int numOfCalls, int numOfTasks) {
    totalHours += hoursPassed;
    totalCalls += numOfCalls;
    totalTasks += numOfTasks;
  }

  updateProfilePic(String picUrl) {
    profilePic = picUrl;
  }
}