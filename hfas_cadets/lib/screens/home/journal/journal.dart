import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/animation/fadeAnimation.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/screens/services/database.dart';
import 'package:hfascadets/shared/globals.dart' as globals;

class Journal extends StatefulWidget {
  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  DatabaseService _database = DatabaseService();
  int _year = DateTime.now().year;

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
              List<Widget> dbCarousel = await _database.monthCarousels(_year.toString());
              User dbUser = await _database.getUser(globals.user.uid);
              dynamic value = await _database.monthStats(_year.toString());
              setState(() {
                globals.user = dbUser;
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
                    padding:
                        EdgeInsets.only(top: 17 * SizeConfig.blockSizeVertical),
                    child: Container(
                      width: 100 * SizeConfig.blockSizeHorizontal,
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
                        child: FadeAnimation(0.5, Column(
                          children: <Widget>[
                            if (globals.monthCarousels.length == 0)
                              SizedBox(height: 29 * SizeConfig.blockSizeVertical,),
                            if (globals.monthCarousels.length == 0)
                              Text(
                                'No Shifts Yet',
                                style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 3 * SizeConfig.blockSizeVertical,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            if (globals.monthCarousels.length == 0)
                              SizedBox(height: 31.8 * SizeConfig.blockSizeVertical,),
                            if (globals.monthCarousels.length != 0)
                              for (Widget month in globals.monthCarousels)
                                month,
                            if (globals.monthCarousels.length == 1)
                              SizedBox(height: 21.8 * SizeConfig.blockSizeVertical,),
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
