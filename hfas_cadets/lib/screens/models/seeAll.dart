import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/shift.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/shared/globals.dart' as globals;

class MonthSeeAll extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final List<Shift> shifts = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 100 * SizeConfig.blockSizeHorizontal,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4 * SizeConfig.blockSizeHorizontal),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.indigo[900],
                        offset: Offset(0.0, 0.2),
                        blurRadius: 1 * SizeConfig.blockSizeVertical, // change to sizeconfig
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4 * SizeConfig.blockSizeHorizontal),
                  child: Image(
                    image: AssetImage('assets/images/months/${globals.months[shifts[0].date.month-1].toLowerCase()}.jpg'),
                    fit: BoxFit.cover,
                )),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2 * SizeConfig.blockSizeHorizontal, vertical: 1 * SizeConfig.blockSizeVertical),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white,),
                        iconSize: 5 * SizeConfig.blockSizeVertical,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
