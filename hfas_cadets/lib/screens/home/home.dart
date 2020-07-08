import 'package:flutter/material.dart';
import 'package:hfascadets/screens/home/calendar.dart';
import 'package:hfascadets/screens/home/dashboard.dart';
import 'package:hfascadets/screens/home/journal.dart';
import 'package:hfascadets/screens/home/profile.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  // properties
  int currentTab = 0;
  // active page ( Tab )
  Widget currentScreen = Dashboard(); // initial screen in viewport

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
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

      endDrawer: currentTab == 3 ? Drawer(
        elevation: 16.0,
        child: Container(
          decoration: BoxDecoration(
//            gradient: LinearGradient(colors: [
//              Color.fromRGBO(22, 44, 136, 1),
//              Colors.blue[900],
//            ]),
            color: Colors.white
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ListTile(
                      title: new Text("All Inboxes", style: TextStyle(color: Colors.indigo[900]),),
                      leading: new Icon(Icons.mail, color: Colors.indigo[900],),
                    ),
                    Divider(
                      height: 0.1,
                      color: Colors.indigo[900],
                    ),
                    ListTile(
                      title: new Text("Primary", style: TextStyle(color: Colors.indigo[900]),),
                      leading: new Icon(Icons.inbox, color: Colors.indigo[900],),
                    ),
                    ListTile(
                      title: new Text("Social", style: TextStyle(color: Colors.indigo[900]),),
                      leading: new Icon(Icons.people, color: Colors.indigo[900],),
                    ),
                    ListTile(
                      title: new Text("Promotions", style: TextStyle(color: Colors.indigo[900]),),
                      leading: new Icon(Icons.local_offer, color: Colors.indigo[900],),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Divider(
                      height: 0.1,
                      color: Colors.indigo[900],
                    ),
                    ListTile(
                      title: new Text("Settings", style: TextStyle(color: Colors.indigo[900]),),
                      leading: new Icon(Icons.settings, color: Colors.indigo[900],),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ) : null,

      // Bottom Nav Bar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 90,
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
                          color:
                              currentTab == 0 ? Colors.indigo[900] : Colors.grey,
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
                    minWidth: 97,
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
                          color:
                              currentTab == 1 ? Colors.indigo[900] : Colors.grey,
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
                    minWidth: 97,
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
                          color:
                          currentTab == 2 ? Colors.indigo[900] : Colors.grey,
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
                    minWidth: 90,
                    onPressed: () {
                      setState(
                            () {
                          currentScreen = Profile();
                          currentTab = 3;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color:
                          currentTab == 3 ? Colors.indigo[900] : Colors.grey,
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
