import 'package:flutter/material.dart';
import 'package:hfascadets/screens/home/calendar/calendar.dart';
import 'package:hfascadets/screens/home/dashboard/dashboard.dart';
import 'package:hfascadets/screens/home/journal/journal.dart';
import 'package:hfascadets/screens/home/profile/profile.dart';
import 'package:hfascadets/screens/models/screen_arguments.dart';
import 'package:hfascadets/screens/models/size_config.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // properties
  int currentTab = 0;

  // active page ( Tab )
  Widget currentScreen = Dashboard(); // initial screen in viewport
  bool firstTime = true;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final ScreenArguments data = ModalRoute.of(context).settings.arguments;
    if (firstTime) {
      currentTab = data.tabNumber;
      if (currentTab == 0) {
        currentScreen = Dashboard();
      } else if (currentTab == 1) {
        currentScreen = Calendar();
      } else if (currentTab == 2) {
        currentScreen = Journal();
      } else if (currentTab == 3) {
        currentScreen = Profile(user: data.user,);
      }
      firstTime = false;
    }

    SizeConfig().init(context);

    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo[900],
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      endDrawer: currentTab == 3
          ? Drawer(
              elevation: 16.0,
              child: Container(
                decoration: BoxDecoration(
//            gradient: LinearGradient(colors: [
//              Color.fromRGBO(22, 44, 136, 1),
//              Colors.blue[900],
//            ]),
                    color: Colors.white),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: new Text(
                              "All Inboxes",
                              style: TextStyle(color: Colors.indigo[900]),
                            ),
                            leading: new Icon(
                              Icons.mail,
                              color: Colors.indigo[900],
                            ),
                          ),
                          Divider(
                            height: 0.1,
                            color: Colors.blue[900],
                          ),
                          ListTile(
                            title: new Text(
                              "Primary",
                              style: TextStyle(color: Colors.indigo[900]),
                            ),
                            leading: new Icon(
                              Icons.inbox,
                              color: Colors.indigo[900],
                            ),
                          ),
                          ListTile(
                            title: new Text(
                              "Social",
                              style: TextStyle(color: Colors.indigo[900]),
                            ),
                            leading: new Icon(
                              Icons.people,
                              color: Colors.indigo[900],
                            ),
                          ),
                          ListTile(
                            title: new Text(
                              "Promotions",
                              style: TextStyle(color: Colors.indigo[900]),
                            ),
                            leading: new Icon(
                              Icons.local_offer,
                              color: Colors.indigo[900],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Divider(
                            height: 0.1,
                            color: Colors.blue[900],
                          ),
                          ListTile(
                            title: new Text(
                              "Settings",
                              style: TextStyle(color: Colors.indigo[900]),
                            ),
                            leading: new Icon(
                              Icons.settings,
                              color: Colors.indigo[900],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,

      // Bottom Nav Bar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 2 * SizeConfig.blockSizeHorizontal,
        child: Container(
          height: 7.3 * SizeConfig.blockSizeVertical,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 20 * SizeConfig.blockSizeHorizontal,
                    onPressed: () {
                      setState(
                        () {
                          currentScreen = Dashboard();
                          currentTab = 0;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: currentTab == 0
                              ? Colors.indigo[900]
                              : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0
                                ? Colors.indigo[900]
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 23 * SizeConfig.blockSizeHorizontal,
                    onPressed: () {
                      setState(
                        () {
                          currentScreen = Calendar();
                          currentTab = 1;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          color: currentTab == 1
                              ? Colors.indigo[900]
                              : Colors.grey,
                        ),
                        Text(
                          'Calendar',
                          style: TextStyle(
                            color: currentTab == 1
                                ? Colors.indigo[900]
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 23 * SizeConfig.blockSizeHorizontal,
                    onPressed: () {
                      setState(
                        () {
                          currentScreen = Journal();
                          currentTab = 2;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.view_list,
                          color: currentTab == 2
                              ? Colors.indigo[900]
                              : Colors.grey,
                        ),
                        Text(
                          'Journal',
                          style: TextStyle(
                            color: currentTab == 2
                                ? Colors.indigo[900]
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 20 * SizeConfig.blockSizeHorizontal,
                    onPressed: () {
                      setState(
                        () {
                          currentScreen = Profile(user: data.user);
                          currentTab = 3;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: currentTab == 3
                              ? Colors.indigo[900]
                              : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 3
                                ? Colors.indigo[900]
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
