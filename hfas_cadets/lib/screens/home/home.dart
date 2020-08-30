import 'package:flutter/material.dart';
import 'package:hfascadets/screens/home/journal/journal.dart';
import 'package:hfascadets/screens/home/profile/profile.dart';
import 'package:hfascadets/screens/models/size_config.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
