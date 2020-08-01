import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/shift.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/shared/globals.dart' as globals;

class MonthCarousel extends StatelessWidget {
  final String month;
  final List<Shift> shifts;

  MonthCarousel({this.month, this.shifts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 8 * SizeConfig.blockSizeHorizontal),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                month,
                style: TextStyle(
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
                        color: Colors.indigo[900],
                        fontSize: 2.1 * SizeConfig.blockSizeVertical,
                        fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        ),
        Container(
          height: 35 * SizeConfig.blockSizeVertical,
          color: Colors.red,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: shifts.length,
            itemBuilder: (BuildContext context, int index) {
              Shift shift = shifts[index];
              return Container(
                margin: EdgeInsets.all(1 * SizeConfig.blockSizeVertical),
                width: 40 * SizeConfig.blockSizeHorizontal,
                color: Colors.pink,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 22 * SizeConfig.blockSizeVertical,
                      width: 39 * SizeConfig.blockSizeHorizontal,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              3 * SizeConfig.blockSizeHorizontal),
                          color: Colors.blue),
                      child: Padding(
                        padding: EdgeInsets.only(left: 3 * SizeConfig.blockSizeHorizontal, bottom: 1 * SizeConfig.blockSizeVertical),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              shift.date.day.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 4 * SizeConfig.blockSizeVertical,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              globals.weekdays[shift.date.weekday - 1],
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
