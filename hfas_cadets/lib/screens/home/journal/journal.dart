import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/month_carousel.dart';
import 'package:hfascadets/screens/models/shift.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/shared/globals.dart' as globals;

class Journal extends StatefulWidget {
  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo[900],
            Colors.indigo[800],
            Colors.blue[900],
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: CustomRefreshIndicator(
            onRefresh: () async {},
            builder: (BuildContext context, Widget child,
                IndicatorController controller) {
              return AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, _) {
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      if (!controller.isIdle)
                        Positioned(
                          top: 4 *
                              SizeConfig.blockSizeVertical *
                              controller.value,
                          child: SizedBox(
                            height: 4 * SizeConfig.blockSizeVertical,
                            width: 4 * SizeConfig.blockSizeVertical,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              value: !controller.isLoading
                                  ? controller.value.clamp(0.0, 1.0)
                                  : null,
                            ),
                          ),
                        ),
                      Transform.translate(
                        offset: Offset(0, 100.0 * controller.value),
                        child: child,
                      ),
                    ],
                  );
                },
              );
            },
            child: SingleChildScrollView(
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    height: 22 * SizeConfig.blockSizeVertical,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 7 * SizeConfig.blockSizeHorizontal,
                          right: 7 * SizeConfig.blockSizeHorizontal,
                          top: 4 * SizeConfig.blockSizeVertical),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Journal',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 4 * SizeConfig.blockSizeVertical,
                            ),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical,),
                          Text(
                            'My Shifts',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 2 * SizeConfig.blockSizeVertical,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 17 * SizeConfig.blockSizeVertical),
                    child: Container(
                      width: 100 * SizeConfig.blockSizeHorizontal,
//                      height: 100 * SizeConfig.blockSizeVertical,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                              7 * SizeConfig.blockSizeHorizontal),
                          topLeft: Radius.circular(
                              7 * SizeConfig.blockSizeHorizontal),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 5 * SizeConfig.blockSizeVertical),
                        child: Column(
                          children: <Widget>[
                            MonthCarousel(month: 'August', color: globals.getMonthColor('August'), shifts: [
                              Shift(date: DateTime(2020, 8, 24), hoursPassed: 4, numCalls: 0),
                              Shift(date: DateTime(2020, 8, 21), hoursPassed: 4, numCalls: 1),
                              Shift(date: DateTime(2020, 8, 4), hoursPassed: 4, numCalls: 1),
                              Shift(date: DateTime(2020, 8, 1), hoursPassed: 4, numCalls: 0)],),
                            MonthCarousel(month: 'March', color: globals.getMonthColor('March'), shifts: [
                              Shift(date: DateTime(2020, 3, 24), hoursPassed: 4, numCalls: 0),
                              Shift(date: DateTime(2020, 3, 21), hoursPassed: 4, numCalls: 1),
                              Shift(date: DateTime(2020, 3, 4), hoursPassed: 4, numCalls: 1),
                              Shift(date: DateTime(2020, 3, 1), hoursPassed: 4, numCalls: 0)],),
                            MonthCarousel(month: 'January', color: globals.getMonthColor('January'), shifts: [
                              Shift(date: DateTime(2020, 1, 24), hoursPassed: 4, numCalls: 0),
                              Shift(date: DateTime(2020, 1, 21), hoursPassed: 4, numCalls: 1),
                              Shift(date: DateTime(2020, 1, 4), hoursPassed: 4, numCalls: 1),
                              Shift(date: DateTime(2020, 1, 1), hoursPassed: 4, numCalls: 0)],),
                            SizedBox(height: 3 * SizeConfig.blockSizeVertical,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
