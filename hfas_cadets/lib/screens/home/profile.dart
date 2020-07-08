import 'package:flutter/material.dart';
import 'package:hfascadets/animation/fadeAnimation.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/shared/month_stat.dart';

class Profile extends StatefulWidget {
  final User user;
  Profile({this.user});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
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
                    left: 30.0,
                    right: 30.0,
                    top: 7 * SizeConfig.blockSizeVertical),
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
                                    image: AssetImage(
                                        'assets/images/hfasLogo.png'),
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
                                      widget.user.name,
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
                                      widget.user.role,
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
                                    size: 40,
                                  ),
                                  color: Colors.white,
                                )),
                            SizedBox(height: 5 * SizeConfig.blockSizeVertical,),
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
                                    widget.user.totalHours,
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
                                    widget.user.totalCalls,
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
                                    widget.user.totalTasks,
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
                    FadeAnimation(.5, GestureDetector(
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
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'EDIT PROFILE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/edit_profile');
                      },
                    )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40 * SizeConfig.blockSizeVertical),
              child: Container(
                width: 100 * SizeConfig.blockSizeHorizontal,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 6 * SizeConfig.blockSizeHorizontal,
                      right: 6 * SizeConfig.blockSizeHorizontal,
                      top: 3 * SizeConfig.blockSizeVertical),
                  child: FadeAnimation(.6, Column(
                    children: <Widget>[
                      MonthStat(month: 'December'),
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
    );
  }
}
