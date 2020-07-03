import 'package:flutter/material.dart';
import 'package:hfascadets/screens/home/calendar.dart';
import 'package:hfascadets/screens/home/dashboard.dart';
import 'package:hfascadets/screens/home/journal.dart';
import 'package:hfascadets/screens/home/profile.dart';
import 'package:hfascadets/screens/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  // properties
  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    Calendar(),
    Journal(),
    Profile(),
  ]; // to store tab views

  // active page ( Tab )
  Widget currentScreen = Dashboard(); // initial screen in viewport

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[900],
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      endDrawer: currentTab == 3 ? Drawer(
        elevation: 16.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                     Colors.indigo[900],
                     Colors.indigo[800],
                     Colors.blue[900],
                    ]),
                  ),
                  accountName: Text("Dom Cobb"),
                  accountEmail: Text("dream@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/hfasLogo.png'),
                  ),
                ),
                ListTile(
                  title: new Text("All Inboxes"),
                  leading: new Icon(Icons.mail),
                ),
                Divider(
                  height: 0.1,
                ),
                ListTile(
                  title: new Text("Primary"),
                  leading: new Icon(Icons.inbox),
                ),
                ListTile(
                  title: new Text("Social"),
                  leading: new Icon(Icons.people),
                ),
                ListTile(
                  title: new Text("Promotions"),
                  leading: new Icon(Icons.local_offer),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Divider(
                  height: 0.1,
                ),
                ListTile(
                  title: new Text("Settings"),
                  leading: new Icon(Icons.settings),
                ),
              ],
            ),
          ],
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
                              currentTab == 0 ? Colors.blue[900] : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0
                                ? Colors.blue[900]
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
                              currentTab == 1 ? Colors.blue[900] : Colors.grey,
                        ),
                        Text(
                          'Calendar',
                          style: TextStyle(
                            color: currentTab == 1
                                ? Colors.blue[900]
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
                          currentTab == 2 ? Colors.blue[900] : Colors.grey,
                        ),
                        Text(
                          'Journal',
                          style: TextStyle(
                            color: currentTab == 2
                                ? Colors.blue[900]
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
                          currentTab == 3 ? Colors.blue[900] : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 3
                                ? Colors.blue[900]
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
