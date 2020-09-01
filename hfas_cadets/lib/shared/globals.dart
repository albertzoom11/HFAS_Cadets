library globals;

import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/user.dart';

User user;
List<String> years = [];
bool yearLoading = false;
List<Widget> profileMonths = [];
int pointsRequired = 15;
List<Widget> monthCarousels = [];
int displayYear = DateTime.now().year;
List<String> weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December',];