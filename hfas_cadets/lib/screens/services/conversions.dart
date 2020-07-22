

import 'package:flutter/material.dart';

class Conversions {

  String toDateString(DateTime dateTime) {
    String date = dateTime.toString();

    // get date info
    String year = date.substring(0, 4);
    String month = date.substring(5, 7);
    String day = date.substring(8, 10);

    // create word variables
    String wordMonth;
    String wordDay = day;

    // find word form of the month
    if (month.substring(0, 1) == '0') {
      if (month == '01') {
        wordMonth = 'Jan';
      } else if (month == '02') {
        wordMonth = 'Feb';
      } else if (month == '03') {
        wordMonth = 'Mar';
      } else if (month == '04') {
        wordMonth = 'Apr';
      } else if (month == '05') {
        wordMonth = 'May';
      } else if (month == '06') {
        wordMonth = 'Jun';
      } else if (month == '07') {
        wordMonth = 'Jul';
      } else if (month == '08') {
        wordMonth = 'Aug';
      } else if (month == '09') {
        wordMonth = 'Sep';
      }
    } else if (month == '10') {
      wordMonth = 'Oct';
    } else if (month == '11') {
      wordMonth = 'Nov';
    } else if (month == '12') {
      wordMonth = 'Dec';
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
  String timesAreInvalid(String start, String end) {
    int startLen = start.length;
    int endLen = end.length;
    String startHour = startLen == 8 ? start.substring(0, 2) : start.substring(0, 1);
    String endHour = endLen == 8 ? end.substring(0, 2) : end.substring(0, 1);
    String startMin = startLen == 8 ? start.substring(3, 5) : start.substring(2, 4);
    String endMin = endLen == 8 ? end.substring(3, 5) : end.substring(2, 4);

    if (start.substring(startLen - 2) != end.substring(endLen - 2)) {
      print('1');
      if (end.substring(endLen - 2) == 'PM') {
        return 'valid';
      } else {
        return 'invalid';
      }
    } else if (int.parse(startHour) > int.parse(endHour)) {
      return 'invalid';
    } else if (int.parse(startHour) < int.parse(endHour)) {
      return 'valid';
    } else if (int.parse(startMin) > int.parse(endMin)) {
      return 'invalid';
    } else if (int.parse(startMin) < int.parse(endMin)) {
      return 'valid';
    }
    return 'same';
  }

  String calculateTotalHours() {

  }
}