import 'package:hfascadets/shared/globals.dart' as globals;
import 'package:flutter/material.dart';

class Conversions {

  String toDateString(DateTime dateTime, {bool shortened = false}) {
    String date = dateTime.toString();

    // get date info
    String year = date.substring(0, 4);
    String month = date.substring(5, 7);
    String day = date.substring(8, 10);

    // create word variables
    String wordMonth = globals.months[int.parse(month) - 1];
    String wordDay = day;

    if (shortened) {
      wordMonth = wordMonth.substring(0, 3);
    }

    // find word form of the day
    if (day.substring(0, 1) == '1') {
      wordDay += 'th';
    } else {
      if (day.substring(1, 2) == '1') {
        wordDay += 'st';
      } else if (day.substring(1, 2) == '2') {
        wordDay += 'nd';
      } else if (day.substring(1, 2) == '3') {
        wordDay += 'rd';
      } else {
        wordDay += 'th';
      }
    }

    // check for leading zero
    if (day.substring(0, 1) == '0') {
      wordDay = wordDay.substring(1, 4);
    }

    // return word form of date
    return wordMonth + ' ' + wordDay + ', ' + year;
  }

  // returns true if time are INVALID
  String timesAreInvalid(int startHour, int startMin, int endHour, int endMin) {
    if (startHour > endHour) {
      return 'invalid';
    } else if (startHour < endHour) {
      return 'valid';
    } else if (startMin > endMin) {
      return 'invalid';
    } else if (startMin < endMin) {
      return 'valid';
    }
    return 'same';
  }

  num calculateHoursPassed(int startHour, int startMin, int endHour, int endMin) {
    int hours = endHour - startHour;
    int minutes = endMin - startMin;

    if (minutes < 0) {
      hours -= 1;
      minutes += 60;
    }
    if (minutes <= 7) {
      minutes = 0;
    } else if (minutes <= 22) {
      minutes = 15;
    } else if (minutes <= 37) {
      minutes = 30;
    } else if (minutes <= 52) {
      minutes = 45;
    } else {
      hours += 1;
      minutes = 0;
    }
    return hours + minutes/60;
  }

  String bigToSmall(num inputNum) {
    if (inputNum >= 1000000) {
      return (inputNum/1000000).toStringAsFixed(1) + 'M';
    } else if (inputNum >= 10000) {
      return (inputNum/1000).toStringAsFixed(1) + 'K';
    }
    num output = inputNum % 1 == 0 ? inputNum.toInt() : inputNum;
    return output.toString();
  }

  Color getMonthColor(dynamic month) {
    if (month == 'January' || month == 1) {
      return Color.fromRGBO(13, 71, 161, 1);
    } else if (month == 'February' || month == 2) {
      return Color.fromRGBO(14, 67, 158, 1);
    } else if (month == 'March' || month == 3) {
      return Color.fromRGBO(15, 63, 155, 1);
    } else if (month == 'April' || month == 4) {
      return Color.fromRGBO(16, 59, 152, 1);
    } else if (month == 'May' || month == 5) {
      return Color.fromRGBO(17, 56, 149, 1);
    } else if (month == 'June' || month == 6) {
      return Color.fromRGBO(19, 53, 145, 1);
    } else if (month == 'July' || month == 7) {
      return Color.fromRGBO(20, 50, 142, 1);
    } else if (month == 'August' || month == 8) {
      return Color.fromRGBO(21, 47, 139, 1);
    } else if (month == 'September' || month == 9) {
      return Color.fromRGBO(22, 44, 136, 1);
    } else if (month == 'October' || month == 10) {
      return Color.fromRGBO(23, 41, 133, 1);
    } else if (month == 'November' || month == 11) {
      return Color.fromRGBO(25, 38, 130, 1);
    } else if (month == 'December' || month == 12) {
      return Color.fromRGBO(26, 35, 126, 1);
    } else {
      return Colors.black;
    }
  }

  bool isDay(String time) {
    bool isAM = time.substring(time.length - 2) == 'AM';
    String hour = time[2] == ':' ? time.substring(0, 2) : time.substring(0, 1);

    if ((isAM && int.parse(hour) < 6) || (!isAM && int.parse(hour) > 7)) {
      return false;
    }
    return true;
  }

  TimeOfDay stringToTime(String time) {
    bool isPM = time.substring(5) == ' PM' || time.substring(5) == 'PM';
    List<String> hoursMinutes = time.substring(0, 5).split(":");

    int hour = isPM ? int.parse(hoursMinutes[0]) + 12 : int.parse(hoursMinutes[0]);
    int minutes = int.parse(hoursMinutes[1]);
    return TimeOfDay(hour: hour, minute: minutes);
  }
}