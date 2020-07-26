import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/animation/fadeAnimation.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/screens/services/conversions.dart';
import 'package:hfascadets/screens/services/database.dart';
import 'package:hfascadets/shared/month_stat.dart';

class Profile extends StatefulWidget {
  final User user;

  Profile({this.user});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Conversions _conversions = Conversions();
  DatabaseService _database = DatabaseService();
  User _user;

  @override
  Widget build(BuildContext context) {
    _user = _user == null ? widget.user : _user;
    String _hours = _conversions.bigToSmall(_user.totalHours);
    String _calls = _conversions.bigToSmall(_user.totalCalls);
    String _tasks = _conversions.bigToSmall(_user.totalTasks);

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
            onRefresh: () async {
              User dbUser = await _database.getUser(_user.uid);
              setState(() {
                _user = dbUser;
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.indigo[900],
                        Colors.indigo[800],
                        Colors.blue[900],
                      ]),
                    ),
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
                                          image: NetworkImage(_user.profilePic),
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
                                          Text(
                                            _user.name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  3 * SizeConfig.blockSizeVertical,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1 * SizeConfig.blockSizeVertical,
                                          ),
                                          Text(
                                            _user.role,
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
                                    borderRadius: BorderRadius.circular(20.0),
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
                                    arguments: _user,
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
                                MonthStat(month: 'December'),
//                          SizedBox(height: 26.7 * SizeConfig.blockSizeVertical),
                                SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                                MonthStat(month: 'November'),
                                SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                                MonthStat(month: 'October'),
                                SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                                MonthStat(month: 'September'),
                                SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                                MonthStat(month: 'August'),
                                SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                                MonthStat(month: 'July'),
                                SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                                MonthStat(month: 'June'),
                                SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                                MonthStat(month: 'May'),
                                SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                                MonthStat(month: 'April'),
                                SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                                MonthStat(month: 'March'),
                                SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                                MonthStat(month: 'February'),
                                SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                                MonthStat(month: 'January'),
                                SizedBox(height: 6 * SizeConfig.blockSizeVertical),
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
