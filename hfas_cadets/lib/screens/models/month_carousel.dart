import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/shift.dart';
import 'package:hfascadets/screens/models/shift_arguments.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/shared/globals.dart' as globals;

class MonthCarousel extends StatelessWidget {
  final int monthIndex;
  final Color color;
  final List<Shift> shifts;

  MonthCarousel({this.monthIndex, this.color, this.shifts});

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
                globals.months[monthIndex],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 3 * SizeConfig.blockSizeVertical,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/seeAll', arguments: shifts);
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
        SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
        Container(
          height: 35 * SizeConfig.blockSizeVertical,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: shifts.length,
            itemBuilder: (BuildContext context, int index) {
              Shift shift = shifts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/shiftPage', arguments: ShiftArguments(shift: shift, editMode: false));
                },
                child: Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 5 * SizeConfig.blockSizeVertical,),
                                Text(
                                  '${shift.hoursPassed} Hours',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 2.2 * SizeConfig.blockSizeVertical,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${shift.numCalls} Calls',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 2.2 * SizeConfig.blockSizeVertical,
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
                                height: 24 * SizeConfig.blockSizeVertical,
                                width: 34 * SizeConfig.blockSizeHorizontal,
                                fit: BoxFit.cover,
                                image: NetworkImage(shift.imageUrl),
                              ),
                              borderRadius: BorderRadius.circular(3 * SizeConfig.blockSizeHorizontal),
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
                                      fontWeight: FontWeight.bold,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0, 0.1),
                                          blurRadius: 0.5 * SizeConfig.blockSizeHorizontal,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    globals.weekdays[shift.date.weekday - 1],
                                    style: TextStyle(
                                      color: color,
                                      fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                      fontWeight: FontWeight.bold,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0, 0.1),
                                          blurRadius: 0.5 * SizeConfig.blockSizeHorizontal,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 3 * SizeConfig.blockSizeVertical,),
      ],
    );
  }
}
