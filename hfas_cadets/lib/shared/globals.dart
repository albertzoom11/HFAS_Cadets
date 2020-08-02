library globals;

import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/user.dart';

User user;
List<Widget> profileMonths = [];
List<Widget> shifts = [];
List<String> weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December',];

Color getMonthColor(monthName) {
  if (monthName == 'January') {
    return Color.fromRGBO(13, 71, 161, 1);
  } else if (monthName == 'February') {
    return Color.fromRGBO(14, 67, 158, 1);
  } else if (monthName == 'March') {
    return Color.fromRGBO(15, 63, 155, 1);
  } else if (monthName == 'April') {
    return Color.fromRGBO(16, 59, 152, 1);
  } else if (monthName == 'May') {
    return Color.fromRGBO(17, 56, 149, 1);
  } else if (monthName == 'June') {
    return Color.fromRGBO(19, 53, 145, 1);
  } else if (monthName == 'July') {
    return Color.fromRGBO(20, 50, 142, 1);
  } else if (monthName == 'August') {
    return Color.fromRGBO(21, 47, 139, 1);
  } else if (monthName == 'September') {
    return Color.fromRGBO(22, 44, 136, 1);
  } else if (monthName == 'October') {
    return Color.fromRGBO(23, 41, 133, 1);
  } else if (monthName == 'November') {
    return Color.fromRGBO(25, 38, 130, 1);
  } else if (monthName == 'December') {
    return Color.fromRGBO(26, 35, 126, 1);
  } else {
    return Colors.black;
  }
}