import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/services/conversions.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();
  final Conversions conversions = Conversions();
  String _dateOutput = '';
  DateTime _dateTime;
  DateTime _initialDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.indigo[900],
                Colors.indigo[800],
                Colors.blue[500],
              ]),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 1 * SizeConfig.blockSizeVertical,
                      horizontal: 2 * SizeConfig.blockSizeHorizontal),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        iconSize: 8 * SizeConfig.blockSizeHorizontal,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'CREATE ENTRY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 2.2 * SizeConfig.blockSizeVertical,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        iconSize: 8 * SizeConfig.blockSizeHorizontal,
                        onPressed: () {
                          print('post!!!');
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7 * SizeConfig.blockSizeVertical),
                        topRight: Radius.circular(7 * SizeConfig.blockSizeVertical)),
                  ),
                  height: 85 * SizeConfig.blockSizeVertical,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8 * SizeConfig.blockSizeHorizontal),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 6 * SizeConfig.blockSizeVertical,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 24 * SizeConfig.blockSizeVertical,
                              width: 34 * SizeConfig.blockSizeHorizontal,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/hfasLogo.png'),
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    ).then((date) {
                                      setState(() {
                                        _dateTime = date;
                                        _dateOutput = conversions.toDateString(date);
                                      });
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.date_range,
                                        size: 4 * SizeConfig.blockSizeVertical,
                                        color: _dateTime == null ? Colors.grey : Colors.indigo[900],
                                      ),
                                      SizedBox(width: 1 * SizeConfig.blockSizeHorizontal,),
                                      Text(
                                        _dateTime == null ? 'Pick a Date' : _dateOutput,
                                        style: TextStyle(
                                          fontSize: 2 * SizeConfig.blockSizeVertical,
                                          color: _dateTime == null ? Colors.grey : Colors.indigo[900],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 3 * SizeConfig.blockSizeVertical,),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  icon: Icon(Icons.call),
                                  hintText: 'Number of Calls',
                                ),
                                validator: (val) => val.isEmpty
                                    ? 'Please enter a number.'
                                    : null,
                                onChanged: (val) {},
                              ),
                              SizedBox(
                                  height: 2 * SizeConfig.blockSizeVertical),
                              TextFormField(
                                decoration: InputDecoration(
                                  icon: Icon(Icons.email),
                                  hintText: 'Email',
                                ),
                                validator: (val) => val.isEmpty
                                    ? 'Please enter an email.'
                                    : null,
                                onChanged: (val) {},
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.blockSizeVertical,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
