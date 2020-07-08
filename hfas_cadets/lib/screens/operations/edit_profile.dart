import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/screens/services/auth.dart';
import 'package:hfascadets/buttons/googleSignIn.dart';
import 'package:hfascadets/animation/fadeAnimation.dart';
import 'package:hfascadets/screens/authentication/forgot_password.dart';
import 'package:hfascadets/screens/services/database.dart';
import 'package:hfascadets/shared/loading.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String name = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    final DatabaseService _databaseService = DatabaseService(uid: user.uid);
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                  Colors.indigo[900],
                  Colors.indigo[800],
                  Colors.blue[500],
                ]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 4 * SizeConfig.blockSizeVertical,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6 * SizeConfig.blockSizeHorizontal,
                            vertical: 3 * SizeConfig.blockSizeVertical),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FadeAnimation(
                                .5,
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 5 * SizeConfig.blockSizeVertical,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1 * SizeConfig.blockSizeVertical,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          FadeAnimation(
                            .6,
                            Container(
                              height: 13 * SizeConfig.blockSizeVertical,
                              width: 26 * SizeConfig.blockSizeHorizontal,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/images/hfasLogo.png'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.blockSizeVertical,
                          ),
                          FadeAnimation(
                              .7,
                              Text(
                                'Change Profile Photo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5 * SizeConfig.blockSizeVertical,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8 * SizeConfig.blockSizeHorizontal),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 2 * SizeConfig.blockSizeVertical,
                            ),
                            FadeAnimation(
                                .8,
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 20.0),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.person),
                                          labelText: 'Name',
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? 'Please enter a name.'
                                            : null,
                                        onChanged: (val) {
                                          setState(() {
                                            name = val;
                                          });
                                        },
                                      ),
                                      SizedBox(height: 2 * SizeConfig.blockSizeVertical),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.email),
                                          labelText: 'Email',
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? 'Please enter an email.'
                                            : null,
                                        onChanged: (val) {
                                          setState(() {
                                            email = val;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 1 * SizeConfig.blockSizeVertical,
                                      ),
                                      Text(
                                        error,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14.0,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            SizedBox(height: 3 * SizeConfig.blockSizeVertical),
                            FadeAnimation(.9, Text('Change Role', style: TextStyle(
                              color: Colors.blue,
                              fontSize: 2 * SizeConfig.blockSizeVertical,
                            ),),),
                            SizedBox(height: 5 * SizeConfig.blockSizeVertical),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: FadeAnimation(
                                      1,
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: OutlineButton(
                                          splashColor: Colors.black,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                          highlightElevation: 0,
                                          disabledBorderColor: Colors.black,
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(4 * SizeConfig.blockSizeHorizontal),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: 5 * SizeConfig.blockSizeHorizontal,
                                ),
                                Expanded(
                                  child: FadeAnimation(
                                      1.1,
                                      GestureDetector(
                                        onTap: () async {
                                          if (_formKey.currentState.validate()) {
                                            setState(() {
                                              loading = true;
                                            });
                                            User newUser = User(
                                                uid: user.uid,
                                                name: name,
                                                email: user.email,
                                                role: user.role,
                                                totalHours: user.totalHours,
                                                totalCalls: user.totalCalls,
                                                totalTasks: user.totalTasks,
                                            );
                                            dynamic result = await _databaseService.updateUserData(newUser);
                                            if (result == null) {
                                              setState(() {
                                                error = 'Please enter a valid email.';
                                                loading = false;
                                              });
                                            } else {
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/home', (route) => false,
                                                arguments: newUser,
                                              );
                                            }
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.blue[900],
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(4 * SizeConfig.blockSizeHorizontal),
                                              child: Text(
                                                'Save Changes',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
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
