import 'package:flutter/material.dart';
import 'package:hfascadets/animation/fadeAnimation.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/services/conversions.dart';
import 'package:hfascadets/shared/globals.dart' as globals;

class MonthStat extends StatelessWidget {
  final String month;
  final num points;
  final num hours;
  final int calls;
  final int tasks;
  final int shifts;
  MonthStat({this.month, this.points, this.hours, this.calls, this.tasks, this.shifts});
  final Conversions _conversions = Conversions();

  @override
  Widget build(BuildContext context) {
      Color monthColor = _conversions.getMonthColor(month);

      return Container(
        width: 88 * SizeConfig.blockSizeHorizontal,
        height: 24 * SizeConfig.blockSizeVertical,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5 * SizeConfig.blockSizeHorizontal),
          boxShadow: [BoxShadow(
            color: monthColor,
            blurRadius: 5 * SizeConfig.blockSizeHorizontal,
            offset: Offset(0, 10),
          )],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3 * SizeConfig.blockSizeHorizontal, vertical: 1.5 * SizeConfig.blockSizeVertical),
          child: Column(
            children: <Widget>[
              FadeAnimation(.1, Text(month, style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 2.2 * SizeConfig.blockSizeVertical,
              ),),),
              SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
              FadeAnimation(.3, Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        points.toString(),
                        style: TextStyle(
                          color: points < globals.pointsRequired ? Colors.black : monthColor,
                          fontSize: 6 * SizeConfig.blockSizeVertical,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Points',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 2.5 * SizeConfig.blockSizeVertical,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(shifts.toString(), style: TextStyle(
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
                          Text(calls.toString(), style: TextStyle(
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
                          Text(hours.toString(), style: TextStyle(
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
                          Text(tasks.toString(), style: TextStyle(
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
              ),)
            ],
          ),
        ),
      );
    }
}


