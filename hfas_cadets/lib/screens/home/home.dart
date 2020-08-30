import 'package:flutter/material.dart';
import 'package:hfascadets/screens/home/journal/journal.dart';
import 'package:hfascadets/screens/home/profile/profile.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hfascadets/shared/globals.dart' as globals;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  PageController controller = PageController(
    initialPage: 0,
  );

  // properties
  int currentTab = 0;
  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    final int page = ModalRoute.of(context).settings.arguments;
    if (firstTime) {
      setState(() {
        controller = PageController(initialPage: page);
        currentTab = page;
      });
      firstTime = false;
    }

    return Scaffold(
        body: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              currentTab = index;
            });
          },
          children: <Widget>[
            Journal(),
            Profile(),
          ],
        ),

      // FAB
      floatingActionButton: Container(
        height: 8 * SizeConfig.blockSizeVertical,
        width: 8 * SizeConfig.blockSizeVertical,
        child: FloatingActionButton(
          child: Icon(Icons.add, size: 4 * SizeConfig.blockSizeVertical,),
          backgroundColor: Colors.indigo[900],
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/add',
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      endDrawer: currentTab == 1
          ? Drawer(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          accountName: Text(globals.user.name),
                          accountEmail: Text(globals.user.email),
                          currentAccountPicture: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: globals.user.profilePic == null ? AssetImage('assets/images/blankProfile.jpg') : NetworkImage(globals.user.profilePic),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/editProfile',
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 1 * SizeConfig.blockSizeVertical),
                            child: ListTile(
                              title: Text(
                                "Edit Profile",
                                style: TextStyle(color: Colors.indigo[900]),
                              ),
                              leading: Icon(
                                Icons.person,
                                color: Colors.indigo[900],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 0,
                          color: Colors.indigo[900],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Divider(
                          height: 0,
                          color: Colors.indigo[900],
                        ),
                        GestureDetector(
                          onTap: () async {
                            dynamic result = await _auth.signOutGoogle();
                            if (result == null) {
                              print('sign out failed');
                            } else {
                              var prefs = await SharedPreferences
                                  .getInstance();
                              prefs.clear();
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/mainMenu', (route) => false);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.blockSizeVertical),
                            child: ListTile(
                              title: Text(
                                "Sign Out",
                                style: TextStyle(color: Colors.indigo[900]),
                              ),
                              leading: Icon(
                                Icons.exit_to_app,
                                color: Colors.indigo[900],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('delete all shifts from end drawer');
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 1 * SizeConfig.blockSizeVertical),
                            child: ListTile(
                              title: Text(
                                "Delete All Shifts",
                                style: TextStyle(color: Colors.indigo[900]),
                              ),
                              leading: Icon(
                                Icons.delete,
                                color: Colors.indigo[900],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                    minWidth: 40 * SizeConfig.blockSizeHorizontal,
                    onPressed: () {
                      controller.jumpToPage(0);
                      setState(
                            () {
                          currentTab = 0;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.indigo[900] : Colors.grey,
                        ),
                        Text(
                          'Journal',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.indigo[900] : Colors.grey,
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
                    minWidth: 40 * SizeConfig.blockSizeHorizontal,
                    onPressed: () {
                      controller.jumpToPage(1);
                      setState(
                        () {
                          currentTab = 1;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: currentTab == 1
                              ? Colors.indigo[900]
                              : Colors.grey,
                        ),
                        Text(
                          'Profile',
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
            ],
          ),
        ),
      ),
    );
  }
}
