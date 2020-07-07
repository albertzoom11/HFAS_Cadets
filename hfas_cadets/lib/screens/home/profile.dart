import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/services/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

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
                padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 7 * SizeConfig.blockSizeVertical),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 11 * SizeConfig.blockSizeVertical,
                          width: 22 * SizeConfig.blockSizeHorizontal,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/hfasLogo.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 5 * SizeConfig.blockSizeHorizontal,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Dom Cobb', style: TextStyle(
                              color: Colors.white,
                              fontSize: 3 * SizeConfig.blockSizeVertical,
                              fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(height: 1 * SizeConfig.blockSizeVertical,),
                            Text('Cadet', style: TextStyle(
                              color: Colors.white60,
                              fontSize: 2 * SizeConfig.blockSizeVertical,
                            ),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 3 * SizeConfig.blockSizeVertical,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5 * SizeConfig.blockSizeHorizontal),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('420', style: TextStyle(
                                color: Colors.white,
                                fontSize: 3 * SizeConfig.blockSizeVertical,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text('Hours', style: TextStyle(
                                color: Colors.white70,
                                fontSize: 1.9 * SizeConfig.blockSizeVertical,
                              ),),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('321', style: TextStyle(
                                color: Colors.white,
                                fontSize: 3 * SizeConfig.blockSizeVertical,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text('Calls', style: TextStyle(
                                color: Colors.white70,
                                fontSize: 1.9 * SizeConfig.blockSizeVertical,
                              ),),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('111', style: TextStyle(
                                color: Colors.white,
                                fontSize: 3 * SizeConfig.blockSizeVertical,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text('Tasks', style: TextStyle(
                                color: Colors.white70,
                                fontSize: 1.9 * SizeConfig.blockSizeVertical,
                              ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3 * SizeConfig.blockSizeVertical,),
                    Container(
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
                            child: Text('EDIT PROFILE', style: TextStyle(
                              color: Colors.white,
                              fontSize: 1.8 * SizeConfig.blockSizeVertical,
                            ),),
                          ),
                        ],
                      ),
                    ),
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
                  padding: EdgeInsets.only(left: 6 * SizeConfig.blockSizeHorizontal, right: 6 * SizeConfig.blockSizeHorizontal, top: 3 * SizeConfig.blockSizeVertical),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 88 * SizeConfig.blockSizeHorizontal,
                        height: 23 * SizeConfig.blockSizeVertical,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Colors.indigo[900],
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10 * SizeConfig.blockSizeHorizontal, vertical: 1.5 * SizeConfig.blockSizeVertical),
                          child: Column(
                            children: <Widget>[
                              Text('This Month', style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 2.2 * SizeConfig.blockSizeVertical,
                              ),),
                              SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('23', style: TextStyle(
                                        color: Colors.indigo[900],
                                        fontSize: 8 * SizeConfig.blockSizeVertical,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      Text('Points', style: TextStyle(
                                        color: Colors.indigo[900],
                                        fontSize: 3 * SizeConfig.blockSizeVertical,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width: 5 * SizeConfig.blockSizeHorizontal,),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('4', style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Shifts', style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('4', style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Calls', style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                      SizedBox(width: 8 * SizeConfig.blockSizeHorizontal,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('16', style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Hours', style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('3', style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Tasks', style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                      Container(
                        width: 88 * SizeConfig.blockSizeHorizontal,
                        height: 23 * SizeConfig.blockSizeVertical,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Color.fromRGBO(25, 38, 129, 1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10 * SizeConfig.blockSizeHorizontal, vertical: 1.5 * SizeConfig.blockSizeVertical),
                          child: Column(
                            children: <Widget>[
                              Text('Previous Month', style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 2 * SizeConfig.blockSizeVertical,
                              ),),
                              SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('15', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 6 * SizeConfig.blockSizeVertical,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      SizedBox(height: 1 * SizeConfig.blockSizeVertical,),
                                      Text('Points', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 2 * SizeConfig.blockSizeVertical,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width: 5 * SizeConfig.blockSizeHorizontal,),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Shifts', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('0', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Calls', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                      SizedBox(width: 8 * SizeConfig.blockSizeHorizontal,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('12', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Hours', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Tasks', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                      Container(
                        width: 88 * SizeConfig.blockSizeHorizontal,
                        height: 23 * SizeConfig.blockSizeVertical,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Color.fromRGBO(25, 38, 129, 1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10 * SizeConfig.blockSizeHorizontal, vertical: 1.5 * SizeConfig.blockSizeVertical),
                          child: Column(
                            children: <Widget>[
                              Text('Previous Month', style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 2 * SizeConfig.blockSizeVertical,
                              ),),
                              SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('15', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 6 * SizeConfig.blockSizeVertical,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      SizedBox(height: 1 * SizeConfig.blockSizeVertical,),
                                      Text('Points', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 2 * SizeConfig.blockSizeVertical,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width: 5 * SizeConfig.blockSizeHorizontal,),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Shifts', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('0', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Calls', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                      SizedBox(width: 8 * SizeConfig.blockSizeHorizontal,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('12', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Hours', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Tasks', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                      Container(
                        width: 88 * SizeConfig.blockSizeHorizontal,
                        height: 23 * SizeConfig.blockSizeVertical,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Color.fromRGBO(25, 38, 129, 1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10 * SizeConfig.blockSizeHorizontal, vertical: 1.5 * SizeConfig.blockSizeVertical),
                          child: Column(
                            children: <Widget>[
                              Text('Previous Month', style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 2 * SizeConfig.blockSizeVertical,
                              ),),
                              SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('15', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 6 * SizeConfig.blockSizeVertical,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      SizedBox(height: 1 * SizeConfig.blockSizeVertical,),
                                      Text('Points', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 2 * SizeConfig.blockSizeVertical,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width: 5 * SizeConfig.blockSizeHorizontal,),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Shifts', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('0', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Calls', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                      SizedBox(width: 8 * SizeConfig.blockSizeHorizontal,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('12', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Hours', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Tasks', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                      Container(
                        width: 88 * SizeConfig.blockSizeHorizontal,
                        height: 23 * SizeConfig.blockSizeVertical,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Color.fromRGBO(25, 38, 129, 1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10 * SizeConfig.blockSizeHorizontal, vertical: 1.5 * SizeConfig.blockSizeVertical),
                          child: Column(
                            children: <Widget>[
                              Text('Previous Month', style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 2 * SizeConfig.blockSizeVertical,
                              ),),
                              SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('15', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 6 * SizeConfig.blockSizeVertical,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      SizedBox(height: 1 * SizeConfig.blockSizeVertical,),
                                      Text('Points', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 2 * SizeConfig.blockSizeVertical,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width: 5 * SizeConfig.blockSizeHorizontal,),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Shifts', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('0', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Calls', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                      SizedBox(width: 8 * SizeConfig.blockSizeHorizontal,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('12', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Hours', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Tasks', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                      Container(
                        width: 88 * SizeConfig.blockSizeHorizontal,
                        height: 23 * SizeConfig.blockSizeVertical,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Color.fromRGBO(25, 38, 129, 1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10 * SizeConfig.blockSizeHorizontal, vertical: 1.5 * SizeConfig.blockSizeVertical),
                          child: Column(
                            children: <Widget>[
                              Text('Previous Month', style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 2 * SizeConfig.blockSizeVertical,
                              ),),
                              SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('15', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 6 * SizeConfig.blockSizeVertical,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      SizedBox(height: 1 * SizeConfig.blockSizeVertical,),
                                      Text('Points', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 2 * SizeConfig.blockSizeVertical,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width: 5 * SizeConfig.blockSizeHorizontal,),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Shifts', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('0', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Calls', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                      SizedBox(width: 8 * SizeConfig.blockSizeHorizontal,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('12', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Hours', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Tasks', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                      Container(
                        width: 88 * SizeConfig.blockSizeHorizontal,
                        height: 23 * SizeConfig.blockSizeVertical,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Color.fromRGBO(25, 38, 129, 1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10 * SizeConfig.blockSizeHorizontal, vertical: 1.5 * SizeConfig.blockSizeVertical),
                          child: Column(
                            children: <Widget>[
                              Text('Previous Month', style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 2 * SizeConfig.blockSizeVertical,
                              ),),
                              SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('15', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 6 * SizeConfig.blockSizeVertical,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      SizedBox(height: 1 * SizeConfig.blockSizeVertical,),
                                      Text('Points', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 2 * SizeConfig.blockSizeVertical,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width: 5 * SizeConfig.blockSizeHorizontal,),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Shifts', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('0', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Calls', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                      SizedBox(width: 8 * SizeConfig.blockSizeHorizontal,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('12', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Hours', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Tasks', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                      Container(
                        width: 88 * SizeConfig.blockSizeHorizontal,
                        height: 23 * SizeConfig.blockSizeVertical,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Color.fromRGBO(25, 38, 129, 1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10 * SizeConfig.blockSizeHorizontal, vertical: 1.5 * SizeConfig.blockSizeVertical),
                          child: Column(
                            children: <Widget>[
                              Text('Previous Month', style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 2 * SizeConfig.blockSizeVertical,
                              ),),
                              SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('15', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 6 * SizeConfig.blockSizeVertical,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      SizedBox(height: 1 * SizeConfig.blockSizeVertical,),
                                      Text('Points', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 2 * SizeConfig.blockSizeVertical,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width: 5 * SizeConfig.blockSizeHorizontal,),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Shifts', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('0', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Calls', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                      SizedBox(width: 8 * SizeConfig.blockSizeHorizontal,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('12', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Hours', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Tasks', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                      Container(
                        width: 88 * SizeConfig.blockSizeHorizontal,
                        height: 23 * SizeConfig.blockSizeVertical,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Color.fromRGBO(25, 38, 129, 1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10 * SizeConfig.blockSizeHorizontal, vertical: 1.5 * SizeConfig.blockSizeVertical),
                          child: Column(
                            children: <Widget>[
                              Text('Previous Month', style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 2 * SizeConfig.blockSizeVertical,
                              ),),
                              SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('15', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 6 * SizeConfig.blockSizeVertical,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      SizedBox(height: 1 * SizeConfig.blockSizeVertical,),
                                      Text('Points', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 2 * SizeConfig.blockSizeVertical,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width: 5 * SizeConfig.blockSizeHorizontal,),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Shifts', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('0', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Calls', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                      SizedBox(width: 8 * SizeConfig.blockSizeHorizontal,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('12', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Hours', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Tasks', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                      Container(
                        width: 88 * SizeConfig.blockSizeHorizontal,
                        height: 23 * SizeConfig.blockSizeVertical,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Colors.blue[900],
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10 * SizeConfig.blockSizeHorizontal, vertical: 1.5 * SizeConfig.blockSizeVertical),
                          child: Column(
                            children: <Widget>[
                              Text('Two Months Ago', style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 2 * SizeConfig.blockSizeVertical,
                              ),),
                              SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('15', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 6 * SizeConfig.blockSizeVertical,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      SizedBox(height: 1 * SizeConfig.blockSizeVertical,),
                                      Text('Points', style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 2 * SizeConfig.blockSizeVertical,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width: 5 * SizeConfig.blockSizeHorizontal,),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Shifts', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('0', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Calls', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                      SizedBox(width: 8 * SizeConfig.blockSizeHorizontal,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('12', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Hours', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                          SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                                          Text('3', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 0.6 * SizeConfig.blockSizeVertical,),
                                          Text('Tasks', style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 6 * SizeConfig.blockSizeVertical),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}