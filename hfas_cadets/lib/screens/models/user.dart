class User {
  final String uid;
  final String name;
  final String email;
  final String role;

  User({this.uid, this.name, this.email, this.role});

  User.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        name = data['name'],
        email = data['email'],
        role = data['role'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
    };
  }
}