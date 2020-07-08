class User {
  final String uid;
  String name;
  String email;
  String role;
  String totalHours;
  String totalCalls;
  String totalTasks;

  User({this.uid, this.name, this.email, this.role, this.totalHours, this.totalCalls, this.totalTasks});

  User.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        name = data['name'],
        email = data['email'],
        role = data['role'],
        totalHours = data['totalHours'],
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
}