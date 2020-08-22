import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/animation/fadeAnimation.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/screens/services/conversions.dart';
import 'package:hfascadets/screens/services/database.dart';
import 'package:hfascadets/shared/globals.dart' as globals;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Conversions _conversions = Conversions();
  DatabaseService _database = DatabaseService();
  int _year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    String _hours = _conversions.bigToSmall(globals.user.totalHours);
    String _calls = _conversions.bigToSmall(globals.user.totalCalls);
    String _tasks = _conversions.bigToSmall(globals.user.totalTasks);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo[900],
            Color.fromRGBO(20, 52, 143, 1),
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
              return dbUser;
            },
            builder: (BuildContext context, Widget child, IndicatorController controller) {
              return AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, _) {
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      if (!controller.isIdle)
                        Positioned(
                          top: 4 * SizeConfig.blockSizeVertical * controller.value,
                          child: SizedBox(
                            height: 4 * SizeConfig.blockSizeVertical,
                            width: 4 * SizeConfig.blockSizeVertical,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
                    height: 45 * SizeConfig.blockSizeVertical,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 7 * SizeConfig.blockSizeHorizontal,
                          right: 7 * SizeConfig.blockSizeHorizontal,
                          top: 4 * SizeConfig.blockSizeVertical),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  FadeAnimation(
                                    .2,
                                    Container(
                                      height: 11 * SizeConfig.blockSizeVertical,
                                      width: 22 * SizeConfig.blockSizeHorizontal,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: globals.user.profilePic == null ? AssetImage('assets/images/blankProfile.jpg') : NetworkImage(globals.user.profilePic),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5 * SizeConfig.blockSizeHorizontal,
                                  ),
                                  FadeAnimation(
                                      .25,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 47 * SizeConfig.blockSizeHorizontal,
                                            child: Text(
                                              globals.user.name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 3 * SizeConfig.blockSizeVertical,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1 * SizeConfig.blockSizeVertical,
                                          ),
                                          Text(
                                            globals.user.role,
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize:
                                                  2 * SizeConfig.blockSizeVertical,
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  FadeAnimation(
                                      .3,
                                      IconButton(
                                        onPressed: () {
                                          Scaffold.of(context).openEndDrawer();
                                        },
                                        icon: Icon(
                                          Icons.menu,
                                          size: 5 * SizeConfig.blockSizeVertical,
                                        ),
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    height: 5 * SizeConfig.blockSizeVertical,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3 * SizeConfig.blockSizeVertical,
                          ),
                          FadeAnimation(
                              .4,
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5 * SizeConfig.blockSizeHorizontal),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          _hours,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                3 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Hours',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize:
                                                1.9 * SizeConfig.blockSizeVertical,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          _calls,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                3 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Calls',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize:
                                                1.9 * SizeConfig.blockSizeVertical,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          _tasks,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                3 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Tasks',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize:
                                                1.9 * SizeConfig.blockSizeVertical,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 3 * SizeConfig.blockSizeVertical,
                          ),
                          FadeAnimation(
                              .5,
                              GestureDetector(
                                child: Container(
                                  width: 90 * SizeConfig.blockSizeHorizontal,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(6 * SizeConfig.blockSizeHorizontal),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(1 * SizeConfig.blockSizeVertical),
                                        child: Text(
                                          'EDIT PROFILE',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                1.8 * SizeConfig.blockSizeVertical,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/editProfile',
                                  );
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 37 * SizeConfig.blockSizeVertical),
                    child: Container(
                      width: 100 * SizeConfig.blockSizeHorizontal,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7 * SizeConfig.blockSizeHorizontal),
                          topLeft: Radius.circular(7 * SizeConfig.blockSizeHorizontal),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 6 * SizeConfig.blockSizeHorizontal,
                            right: 6 * SizeConfig.blockSizeHorizontal,
                            top: 3 * SizeConfig.blockSizeVertical),
                        child: FadeAnimation(
                            .6,
                            Column(
                              children: <Widget>[
                                if (globals.profileMonths.length == 0)
                                  SizedBox(height: 20 * SizeConfig.blockSizeVertical,),
                                if (globals.profileMonths.length == 0)
                                  Text(
                                    'No Shifts Yet',
                                    style: TextStyle(
                                      color: Colors.indigo[900],
                                      fontSize: 3 * SizeConfig.blockSizeVertical,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                if (globals.profileMonths.length == 0)
                                  SizedBox(height: 25.8 * SizeConfig.blockSizeVertical,),
                                if (globals.profileMonths.length != 0)
                                  for (Widget month in globals.profileMonths)
                                    Column(children: <Widget>[month, SizedBox(height: 4 * SizeConfig.blockSizeVertical),],),
                                  if (globals.profileMonths.length == 1)
                                    SizedBox(height: 19.8 * SizeConfig.blockSizeVertical,),
                                if (globals.profileMonths.length != 0)
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
