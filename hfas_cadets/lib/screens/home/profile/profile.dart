import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/animation/fadeAnimation.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/screens/services/conversions.dart';
import 'package:hfascadets/screens/services/database.dart';
import 'package:hfascadets/shared/globals.dart' as globals;
import 'package:hfascadets/shared/loading.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Conversions _conversions = Conversions();
  DatabaseService _database = DatabaseService();

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
                                            width: 45 * SizeConfig.blockSizeHorizontal,
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
                                          Navigator.pushNamed(context, '/settings');
                                        },
                                        icon: Icon(
                                          Icons.settings,
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
                          FadeAnimation(.5, Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: Container(
                                  width: 60 * SizeConfig.blockSizeHorizontal,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        6 * SizeConfig.blockSizeHorizontal),
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        1 * SizeConfig.blockSizeVertical),
                                    child: Text(
                                      'EDIT PROFILE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            1.8 * SizeConfig.blockSizeVertical,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/editProfile',
                                  );
                                },
                              ),
                              if (globals.years.length == 1)
                                Padding(
                                  padding: EdgeInsets.only(right: 5 * SizeConfig.blockSizeHorizontal),
                                  child: Text(
                                    globals.displayYear.toString(),
                                    style: TextStyle(
                                      color: globals.displayYear == DateTime.now().year ? Colors.white : Colors.white70,
                                      fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                      fontWeight: globals.displayYear == DateTime.now().year ? FontWeight.bold : FontWeight.w400,
                                    ),
                                  ),
                                ),
                              if (globals.years.length > 1)
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Center(
                                              child: Text(
                                                'Select Year',
                                                style: TextStyle(
                                                  color: Colors.indigo[900],
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            content: Container(
                                              constraints: BoxConstraints(
                                                maxHeight: 40 * SizeConfig.blockSizeVertical,
                                              ),
                                              width: 50 * SizeConfig.blockSizeHorizontal,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: globals.years.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return FlatButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        globals.yearLoading = true;
                                                        globals.displayYear = int.parse(globals.years[index]);
                                                        Navigator.pop(context);
                                                      });
                                                      dynamic value = await _database.monthStats(globals.displayYear.toString());
                                                      List<Widget> dbCarousel = await _database.monthCarousels(globals.displayYear.toString());
                                                      if (value != null) {
                                                        setState(() {
                                                          globals.monthCarousels = dbCarousel;
                                                          globals.profileMonths = value;
                                                          globals.yearLoading = false;
                                                        });
                                                      }
                                                    },
                                                    child: ListTile(
                                                      title: Padding(
                                                        padding: EdgeInsets.symmetric(vertical: 0.5 * SizeConfig.blockSizeVertical, horizontal: 2 * SizeConfig.blockSizeHorizontal),
                                                        child: Center(
                                                          child: globals.years[index] == DateTime.now().year.toString()
                                                                  ? Container(
                                                                      decoration: BoxDecoration(
                                                                        border: Border.all(color: Colors.blue[900]),
                                                                        borderRadius: BorderRadius.circular(6 * SizeConfig.blockSizeHorizontal),
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.symmetric(vertical: 0.5 * SizeConfig.blockSizeVertical, horizontal: 3 * SizeConfig.blockSizeHorizontal),
                                                                        child: Text(
                                                                          globals.years[index],
                                                                          style: TextStyle(
                                                                            color: globals.years[index] == globals.displayYear.toString() ? Colors.blue[900] : Colors.black,
                                                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Padding(
                                                                      padding: EdgeInsets.symmetric(vertical: 0.5 * SizeConfig.blockSizeVertical, horizontal: 3 * SizeConfig.blockSizeHorizontal),
                                                                      child: Text(globals.years[index],
                                                                        style: TextStyle(
                                                                          color: globals.years[index] == globals.displayYear.toString() ? Colors.blue[900] : Colors.black,
                                                                          fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        globals.displayYear.toString(),
                                        style: TextStyle(
                                          color: globals.displayYear == DateTime.now().year ? Colors.white : Colors.white70,
                                          fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                          fontWeight: globals.displayYear == DateTime.now().year ? FontWeight.bold : FontWeight.w400,
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down, color: globals.displayYear == DateTime.now().year ? Colors.white : Colors.white70, size: 3  * SizeConfig.blockSizeVertical,),
                                    ],
                                  ),
                                ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 37 * SizeConfig.blockSizeVertical),
                    child: Container(
                      width: 100 * SizeConfig.blockSizeHorizontal,
                      constraints: BoxConstraints(
                        minHeight: 53 * SizeConfig.blockSizeVertical,
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
                            left: 6 * SizeConfig.blockSizeHorizontal,
                            right: 6 * SizeConfig.blockSizeHorizontal,
                            top: 3 * SizeConfig.blockSizeVertical),
                        child: globals.yearLoading ? FadeAnimation(0.6, Loading()) : FadeAnimation(
                            .6,
                            Column(
                              children: <Widget>[
                                if (globals.profileMonths.length == 0)
                                  Column(
                                    children: [
                                      SizedBox(height: 21 * SizeConfig.blockSizeVertical,),
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
                                if (globals.profileMonths.length != 0)
                                  for (Widget month in globals.profileMonths)
                                    Column(children: <Widget>[month, SizedBox(height: 4 * SizeConfig.blockSizeVertical),],),
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
