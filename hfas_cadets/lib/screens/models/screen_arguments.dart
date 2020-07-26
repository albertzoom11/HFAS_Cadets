import 'package:hfascadets/screens/models/user.dart';

class ScreenArguments {
  final int tabNumber;
  User user;

  ScreenArguments({this.tabNumber, this.user});

  changeUser(User newUser) {
    user = newUser;
  }
}