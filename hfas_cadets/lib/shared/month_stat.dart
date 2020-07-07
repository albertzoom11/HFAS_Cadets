import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/size_config.dart';

class MonthStat extends StatefulWidget {
  final month;
  MonthStat({this.month});

  @override
  _MonthStatState createState() => _MonthStatState();
}

class _MonthStatState extends State<MonthStat> {
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

  @override
  Widget build(BuildContext context) {
    Color monthColor = getMonthColor(widget.month);

    return Container(
      width: 88 * SizeConfig.blockSizeHorizontal,
      height: 23 * SizeConfig.blockSizeVertical,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(
          color: monthColor,
          blurRadius: 20,
          offset: Offset(0, 10),
        )],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10 * SizeConfig.blockSizeHorizontal, vertical: 1.5 * SizeConfig.blockSizeVertical),
        child: Column(
          children: <Widget>[
            Text(widget.month, style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 2.2 * SizeConfig.blockSizeVertical,
            ),),
            SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('23', style: TextStyle(
                      color: monthColor,
                      fontSize: 8 * SizeConfig.blockSizeVertical,
                      fontWeight: FontWeight.bold,
                    ),),
                    Text('Points', style: TextStyle(
                      color: monthColor,
                      fontSize: 3 * SizeConfig.blockSizeVertical,
                    ),),
                  ],
                ),
                SizedBox(width: 5 * SizeConfig.blockSizeHorizontal,),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('4', style: TextStyle(
                          color: Colors.black,
                          fontSize: 2.5 * SizeConfig.blockSizeVertical,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                        Text('Shifts', style: TextStyle(
                          color: Colors.black,
                          fontSize: 1.8 * SizeConfig.blockSizeVertical,
                        ),),
                        SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                        Text('4', style: TextStyle(
                          color: Colors.black,
                          fontSize: 2.5 * SizeConfig.blockSizeVertical,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                        Text('Calls', style: TextStyle(
                          color: Colors.black,
                          fontSize: 1.8 * SizeConfig.blockSizeVertical,
                        ),),
                      ],
                    ),
                    SizedBox(width: 8 * SizeConfig.blockSizeHorizontal,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('16', style: TextStyle(
                          color: Colors.black,
                          fontSize: 2.5 * SizeConfig.blockSizeVertical,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                        Text('Hours', style: TextStyle(
                          color: Colors.black,
                          fontSize: 1.8 * SizeConfig.blockSizeVertical,
                        ),),
                        SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                        Text('3', style: TextStyle(
                          color: Colors.black,
                          fontSize: 2.5 * SizeConfig.blockSizeVertical,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                        Text('Tasks', style: TextStyle(
                          color: Colors.black,
                          fontSize: 1.8 * SizeConfig.blockSizeVertical,
                        ),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
