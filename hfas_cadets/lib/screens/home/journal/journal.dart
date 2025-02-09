import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/animation/fadeAnimation.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/screens/services/database.dart';
import 'package:hfascadets/shared/globals.dart' as globals;
import 'package:hfascadets/shared/loading.dart';

class Journal extends StatefulWidget {
  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  DatabaseService _database = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(20, 52, 143, 1),
            Colors.indigo[900],
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: CustomRefreshIndicator(
            onRefresh: () async {
              User dbUser = await _database.getUser(globals.user.uid);
              List<String> dbYears = await _database.getYears();
              dynamic value = await _database.monthStats(globals.displayYear.toString());
              List<Widget> dbCarousel = await _database.monthCarousels(globals.displayYear.toString());
              setState(() {
                globals.user = dbUser;
                globals.years = dbYears;
                globals.profileMonths = value;
                globals.monthCarousels = dbCarousel;
              });
            },
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
                          FadeAnimation(0.3, Text(
                            'Journal',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 4 * SizeConfig.blockSizeVertical,
                            ),
                          )),
                          SizedBox(height: SizeConfig.blockSizeVertical,),
                          FadeAnimation(0.4, Text(
                            'My Shifts',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 2 * SizeConfig.blockSizeVertical,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 17 * SizeConfig.blockSizeVertical),
                    child: Container(
                      width: 100 * SizeConfig.blockSizeHorizontal,
                      constraints: BoxConstraints(
                        minHeight: 72.8 * SizeConfig.blockSizeVertical,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7 * SizeConfig.blockSizeHorizontal),
                          topLeft: Radius.circular(7 * SizeConfig.blockSizeHorizontal),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 5 * SizeConfig.blockSizeVertical),
                        child: globals.yearLoading ? FadeAnimation(0.5, Loading()) : FadeAnimation(0.5, Column(
                          children: <Widget>[
                            if (globals.monthCarousels.length == 0)
                              Column(
                                children: [
                                  SizedBox(height: 30 * SizeConfig.blockSizeVertical,),
                                  Text(
                                    'No Shifts Yet',
                                    style: TextStyle(
                                      color: Colors.indigo[900],
                                      fontSize: 3 * SizeConfig.blockSizeVertical,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            if (globals.monthCarousels.length != 0)
                              for (Widget month in globals.monthCarousels)
                                month,
                            SizedBox(height: 3 * SizeConfig.blockSizeVertical,),
                          ],
                        )),
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
