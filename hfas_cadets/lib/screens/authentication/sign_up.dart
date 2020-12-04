import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/services/auth.dart';
import 'package:hfascadets/animation/fadeAnimation.dart';
import 'package:hfascadets/buttons/googleSignIn.dart';
import 'package:hfascadets/shared/loading.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String name = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FadeAnimation(
                              .5,
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          FadeAnimation(
                              .7,
                              Text(
                                'Create an Account',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 13 * SizeConfig.blockSizeHorizontal,),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20.0, 0),
                  child: FadeAnimation(.9, Image(
                    image: AssetImage('assets/images/hfasLogo.png'), height: 150,
                  )),
                ),
              ],
            ),
            SizedBox(
              height: 30,
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
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      FadeAnimation(
                          1,
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.person),
                                    hintText: 'Name',
                                  ),
                                  validator: (val) => val.isEmpty ? 'Please enter your name' : null,
                                  onChanged: (val) {
                                    setState(() {
                                      name = val;
                                    });
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.email),
                                    hintText: 'Email',
                                  ),
                                  validator: (val) => val.isEmpty ? 'Please enter an email or sign in with Google.' : null,
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.lock),
                                    hintText: 'Password',
                                  ),
                                  obscureText: true,
                                  validator: (val) => val.length < 6 ? 'Please enter a password with at least 6 characters.' : null,
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                ),
                                SizedBox(height: 8,),
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
                      SizedBox(
                        height: 18,
                      ),
                      FadeAnimation(
                          1.2,
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _auth.signUpWithEmailAndPassword(name, email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Please enter a valid email';
                                    loading = false;
                                  });
                                } else {
                                  Navigator.pushReplacementNamed(context, '/verification');
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.indigo[900],
                              ),
                              child: Center(
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          1.3,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FadeAnimation(1.8, googleSignInButton(context)),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: FadeAnimation(
                                1.5,
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, '/signIn');
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.blue[900],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Log In',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
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
