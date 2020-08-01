import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/shift.dart';
import 'package:hfascadets/screens/models/size_config.dart';

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
              Text(month, style: TextStyle(fontSize: 3 * SizeConfig.blockSizeVertical, fontWeight: FontWeight.bold),),
              GestureDetector(
                onTap: () {
                  print('See All');
                },
                child: Text('See All', style: TextStyle(color: Colors.indigo[900], fontSize: 2.1 * SizeConfig.blockSizeVertical, fontWeight: FontWeight.w600),)
              )
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
                child: Stack(children: <Widget>[
                  Container(
                    height: 22 * SizeConfig.blockSizeVertical,
                    width: 39 * SizeConfig.blockSizeHorizontal,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5 * SizeConfig.blockSizeHorizontal),
                      color: Colors.blue
                    ),
                    child: Column(children: <Widget>[
                      Text(shift.date, style: TextStyle(color: Colors.white, fontSize: 2 * SizeConfig.blockSizeVertical, fontWeight: FontWeight.bold),),
                    ],),
                  ),
                ],),
              );
            },
          ),
        ),
      ],
    );
  }
}
