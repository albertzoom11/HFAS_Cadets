

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
}