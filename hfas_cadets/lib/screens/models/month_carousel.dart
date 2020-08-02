import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/shift.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/shared/globals.dart' as globals;

class MonthCarousel extends StatelessWidget {
  final String month;
  final Color color;
  final List<Shift> shifts;

  MonthCarousel({this.month, this.color, this.shifts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8 * SizeConfig.blockSizeHorizontal),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                month,
                style: TextStyle(
                    color: color,
                    fontSize: 3 * SizeConfig.blockSizeVertical,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                  onTap: () {
                    print('See All');
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 2.1 * SizeConfig.blockSizeVertical,
                        fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        ),
        SizedBox(height: 1.5 * SizeConfig.blockSizeVertical,),
        Container(
          height: 35 * SizeConfig.blockSizeVertical,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: shifts.length,
            itemBuilder: (BuildContext context, int index) {
              Shift shift = shifts[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 2 * SizeConfig.blockSizeHorizontal, vertical: 1 * SizeConfig.blockSizeVertical),
                width: 38 * SizeConfig.blockSizeHorizontal,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        height: 15 * SizeConfig.blockSizeVertical,
                        width: 36 * SizeConfig.blockSizeHorizontal,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3 * SizeConfig.blockSizeHorizontal),
                            color: color,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4 * SizeConfig.blockSizeHorizontal, vertical: 1.5 * SizeConfig.blockSizeVertical),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${shift.hoursPassed} Hours',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 2.7 * SizeConfig.blockSizeVertical,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 1 * SizeConfig.blockSizeVertical,),
                              Text(
                                '${shift.numCalls} Calls',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 2.7 * SizeConfig.blockSizeVertical,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      bottom: 0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3 * SizeConfig.blockSizeHorizontal),
                        boxShadow: [
                          BoxShadow(
                            color: color,
                            offset: Offset(0, 2),
                            blurRadius: 1 * SizeConfig.blockSizeHorizontal,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            child: Image(
                              height: 22 * SizeConfig.blockSizeVertical,
                              width: 34 * SizeConfig.blockSizeHorizontal,
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/form.png'),
                            ),
                            borderRadius: BorderRadius.circular(5 * SizeConfig.blockSizeHorizontal),
                          ),
                          Positioned(
                            left: 3 * SizeConfig.blockSizeHorizontal,
                            bottom: 1 * SizeConfig.blockSizeVertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  shift.date.day.toString(),
                                  style: TextStyle(
                                      color: color,
                                      fontSize: 5 * SizeConfig.blockSizeVertical,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  globals.weekdays[shift.date.weekday - 1],
                                  style: TextStyle(
                                      color: color,
                                      fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
      ],
    );
  }
}
