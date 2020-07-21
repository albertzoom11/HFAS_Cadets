import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  TimeOfDay _startTime;
  TimeOfDay _endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 20 * SizeConfig.blockSizeVertical,
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                  Colors.indigo[900],
                  Colors.indigo[800],
                  Colors.blue[500],
                ]),
              ),
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: Padding(
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
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 10 * SizeConfig.blockSizeVertical),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(7 * SizeConfig.blockSizeVertical),
                            topRight:
                                Radius.circular(7 * SizeConfig.blockSizeVertical)),
                      ),
                      height: 140 * SizeConfig.blockSizeVertical,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 7 * SizeConfig.blockSizeHorizontal),
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
                                      image:
                                          AssetImage('assets/images/hfasLogo.png'),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: _dateTime == null
                                              ? DateTime.now()
                                              : _dateTime,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                        ).then((date) {
                                          if (date != null) {
                                            setState(() {
                                              _dateTime = date;
                                              _dateOutput =
                                                  conversions.toDateString(date);
                                            });
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 43 * SizeConfig.blockSizeHorizontal,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: _dateTime == null ? Colors.grey : Colors.indigo[900]),
                                          borderRadius: BorderRadius.circular(
                                              8 * SizeConfig.blockSizeHorizontal),
                                        ),
                                        child: Padding(
                                          padding: _dateTime == null
                                              ? EdgeInsets.symmetric(
                                                  vertical: 1 *
                                                      SizeConfig.blockSizeVertical,
                                                  horizontal: 11.2 *
                                                      SizeConfig
                                                          .blockSizeHorizontal)
                                              : EdgeInsets.symmetric(
                                                  vertical: 1 *
                                                      SizeConfig.blockSizeVertical,
                                                  horizontal: 2 *
                                                      SizeConfig
                                                          .blockSizeHorizontal),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.date_range,
                                                size: 4 *
                                                    SizeConfig.blockSizeVertical,
                                                color: _dateTime == null
                                                    ? Colors.grey
                                                    : Colors.indigo[900],
                                              ),
                                              SizedBox(
                                                width: 1 *
                                                    SizeConfig.blockSizeHorizontal,
                                              ),
                                              Text(
                                                _dateTime == null
                                                    ? 'Date'
                                                    : _dateOutput,
                                                style: TextStyle(
                                                  fontSize: 2 *
                                                      SizeConfig.blockSizeVertical,
                                                  color: _dateTime == null
                                                      ? Colors.grey
                                                      : Colors.indigo[900],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: 2 * SizeConfig.blockSizeVertical),
                                    FlatButton(
                                      onPressed: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: _startTime == null
                                              ? TimeOfDay.now()
                                              : _startTime,
                                        ).then((time) {
                                          if (time != null) {
                                            setState(() {
                                              _startTime = time;
                                            });
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 43 * SizeConfig.blockSizeHorizontal,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: _startTime == null ? Colors.grey : Colors.indigo[900]),
                                          borderRadius: BorderRadius.circular(
                                              8 * SizeConfig.blockSizeHorizontal),
                                        ),
                                        child: Padding(
                                          padding: _startTime == null
                                              ? EdgeInsets.symmetric(
                                                  vertical: 1 *
                                                      SizeConfig.blockSizeVertical,
                                                  horizontal: 5.5 *
                                                      SizeConfig
                                                          .blockSizeHorizontal)
                                              : EdgeInsets.symmetric(
                                                  vertical: 1 *
                                                      SizeConfig.blockSizeVertical,
                                                  horizontal: 6.5 *
                                                      SizeConfig
                                                          .blockSizeHorizontal),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.access_time,
                                                size: 4 *
                                                    SizeConfig.blockSizeVertical,
                                                color: _startTime == null
                                                    ? Colors.grey
                                                    : Colors.indigo[900],
                                              ),
                                              SizedBox(
                                                width: 1 *
                                                    SizeConfig.blockSizeHorizontal,
                                              ),
                                              Text(
                                                _startTime == null
                                                    ? 'Start Time'
                                                    : _startTime
                                                        .format(context)
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize: 2 *
                                                      SizeConfig.blockSizeVertical,
                                                  color: _startTime == null
                                                      ? Colors.grey
                                                      : Colors.indigo[900],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: 2 * SizeConfig.blockSizeVertical),
                                    FlatButton(
                                      onPressed: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: _endTime == null
                                              ? TimeOfDay.now()
                                              : _endTime,
                                        ).then((time) {
                                          if (time != null) {
                                            setState(() {
                                              _endTime = time;
                                            });
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 43 * SizeConfig.blockSizeHorizontal,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: _endTime == null ? Colors.grey : Colors.indigo[900]),
                                          borderRadius: BorderRadius.circular(
                                              8 * SizeConfig.blockSizeHorizontal),
                                        ),
                                        child: Padding(
                                          padding: _endTime == null
                                              ? EdgeInsets.symmetric(
                                                  vertical: 1 *
                                                      SizeConfig.blockSizeVertical,
                                                  horizontal: 6.5 *
                                                      SizeConfig
                                                          .blockSizeHorizontal)
                                              : EdgeInsets.symmetric(
                                                  vertical: 1 *
                                                      SizeConfig.blockSizeVertical,
                                                  horizontal: 6.5 *
                                                      SizeConfig
                                                          .blockSizeHorizontal),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.access_time,
                                                size: 4 *
                                                    SizeConfig.blockSizeVertical,
                                                color: _endTime == null
                                                    ? Colors.grey
                                                    : Colors.indigo[900],
                                              ),
                                              SizedBox(
                                                width: 1 *
                                                    SizeConfig.blockSizeHorizontal,
                                              ),
                                              Text(
                                                _endTime == null
                                                    ? 'End Time'
                                                    : _endTime
                                                        .format(context)
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize: 2 *
                                                      SizeConfig.blockSizeVertical,
                                                  color: _endTime == null
                                                      ? Colors.grey
                                                      : Colors.indigo[900],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3 * SizeConfig.blockSizeVertical,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.title),
                                      hintText: 'Title',
                                    ),
                                    validator: (val) => val.isEmpty
                                        ? 'Please enter a title.'
                                        : null,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                      height: 2 * SizeConfig.blockSizeVertical),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.call),
                                      hintText: 'Number of Calls',
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (val) => val.isEmpty
                                        ? 'Please enter a number.'
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
            ),
          ],
        ),
      ),
    );
  }
}
