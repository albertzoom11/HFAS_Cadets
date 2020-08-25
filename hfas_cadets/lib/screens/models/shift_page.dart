import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/shift.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/models/task_display.dart';
import 'package:hfascadets/screens/services/conversions.dart';
import 'package:hfascadets/screens/services/database.dart';
import 'package:hfascadets/shared/globals.dart' as globals;
import 'package:numberpicker/numberpicker.dart';

class ShiftPage extends StatefulWidget {
  @override
  _ShiftPageState createState() => _ShiftPageState();
}

class _ShiftPageState extends State<ShiftPage> {
  final Conversions _conversions = Conversions();
  final DatabaseService _database = DatabaseService();
  Shift _shift;
  String _title;
  String _imageUrl;
  DateTime _date;
  TimeOfDay _startTime;
  TimeOfDay _endTime;
  String _timeIn;
  String _timeOut;
  num _hoursPassed;
  int _numCalls;
  int _numTasks;
  List<String> _listOfTasks;
  bool firstTime = true;
  bool editMode = false;
  bool edited = false;

  Future<String> createDeleteDialog(BuildContext context, Shift shift) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Delete Shift',
              style: TextStyle(color: Colors.indigo[900]),
            ),
            content: Text(
              'Delete ${shift.title}?',
              style: TextStyle(color: Colors.indigo[900]),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5,
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.indigo[900]),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                elevation: 5,
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.indigo[900]),
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, '/loading');
                  dynamic result = await _database.deleteShift(shift);
                  globals.monthCarousels = await _database
                      .monthCarousels(shift.date.year.toString());
                  globals.profileMonths =
                      await _database.monthStats(shift.date.year.toString());
                  if (result != null) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false,
                        arguments: 0);
                  }
                },
              ),
            ],
          );
        });
  }

  Future<String> createTaskDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Add Task',
              style: TextStyle(color: Colors.indigo[900]),
            ),
            content: TextField(
              controller: customController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Task Name',
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.indigo[900]),
                ),
                onPressed: () {
                  Navigator.pop(context, customController.text.toString());
                },
              ),
            ],
          );
        });
  }

  void _showNumberPicker(int initial) {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            initialIntegerValue: initial,
            minValue: 0,
            maxValue: 10,
          );
        }).then((value) {
          setState(() {
            _numCalls = value;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    Shift argShift = ModalRoute.of(context).settings.arguments;
    if (firstTime) {
      setState(() {
        _shift = argShift;
        _title = _shift.title;
        _imageUrl = _shift.imageUrl;
        _date = _shift.date;
        _timeIn = _shift.timeIn;
        _timeOut = _shift.timeOut;
        _hoursPassed = _shift.hoursPassed;
        _numCalls = _shift.numCalls;
        _numTasks = _shift.numTasks;
        _listOfTasks = _shift.listOfTasks.sublist(0);
      });
      firstTime = false;
    }

    return editMode
        ? Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(20, 52, 143, 1),
                        Colors.indigo[900],
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 75 * SizeConfig.blockSizeVertical,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                  18 * SizeConfig.blockSizeHorizontal)),
                          color: Colors.white,
                        ),
                        child: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 3 * SizeConfig.blockSizeVertical,
                                left: 7 * SizeConfig.blockSizeHorizontal),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 7 *
                                              SizeConfig.blockSizeHorizontal),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editMode = false;
                                                _title = _shift.title;
                                                _imageUrl = _shift.imageUrl;
                                                _date = _shift.date;
                                                _timeIn = _shift.timeIn;
                                                _timeOut = _shift.timeOut;
                                                _hoursPassed = _shift.hoursPassed;
                                                _numCalls = _shift.numCalls;
                                                _numTasks = _shift.numTasks;
                                                _listOfTasks = _shift.listOfTasks.sublist(0);
                                                _startTime = null;
                                                _endTime = null;
                                              });
                                            },
                                            child: Icon(
                                              Icons.clear,
                                              color: Colors.black,
                                              size: 4.5 *
                                                  SizeConfig
                                                      .blockSizeVertical,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              print('check tapped');
                                              setState(() {
                                                edited = true;
                                                editMode = false;
                                              });
                                            },
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.black,
                                              size: 4 *
                                                  SizeConfig
                                                      .blockSizeVertical,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          3 * SizeConfig.blockSizeVertical,
                                    ),
                                    Container(
                                      width:
                                          86 * SizeConfig.blockSizeHorizontal,
                                      child: Text(
                                        _title,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 4 *
                                              SizeConfig.blockSizeVertical,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          2.5 * SizeConfig.blockSizeVertical,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: _date == null
                                              ? DateTime.now()
                                              : _date,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                        ).then((date) {
                                          if (date != null) {
                                            _date = DateTime(date.year, date.month, date.day, _date.hour, _date.minute);
                                          }
                                        });
                                      },
                                      child: Text(
                                        _conversions.toDateString(_date),
                                        style: TextStyle(
                                          fontSize: 2.5 *
                                              SizeConfig.blockSizeVertical,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue[900],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          2 * SizeConfig.blockSizeVertical,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            showTimePicker(
                                              context: context,
                                              initialTime: _startTime == null
                                                  ? _conversions.stringToTime(_timeIn)
                                                  : _startTime,
                                            ).then((time) {
                                              if (time != null) {
                                                setState(() {
                                                  _startTime = time;
                                                  _date = DateTime(_date.year, _date.month, _date.day, time.hour, time.minute);
                                                });
                                              }
                                            });
                                          },
                                          child: Text(
                                            _startTime == null ? _timeIn : _startTime.format(context),
                                            style: TextStyle(
                                              fontSize: 2.2 *
                                                  SizeConfig.blockSizeVertical,
                                              fontWeight: FontWeight.w600,
                                              color: _conversions
                                                      .isDay(_startTime == null ? _timeIn : _startTime.format(context))
                                                  ? Colors.blue[700]
                                                  : Colors.indigo[900],
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '  -  ',
                                          style: TextStyle(
                                            fontSize: 2.2 *
                                                SizeConfig.blockSizeVertical,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showTimePicker(
                                              context: context,
                                              initialTime: _endTime == null
                                                  ? _conversions.stringToTime(_timeOut)
                                                  : _endTime,
                                            ).then((time) {
                                              if (time != null) {
                                                setState(() {
                                                  _endTime = time;
                                                });
                                              }
                                            });
                                          },
                                          child: Text(
                                            _endTime == null ? _timeOut : _endTime.format(context),
                                            style: TextStyle(
                                              fontSize: 2.2 *
                                                  SizeConfig.blockSizeVertical,
                                              fontWeight: FontWeight.w600,
                                              color: _conversions
                                                      .isDay(_endTime == null ? _timeOut : _endTime.format(context))
                                                  ? Colors.blue[700]
                                                  : Colors.indigo[900],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          44 * SizeConfig.blockSizeHorizontal,
                                      height:
                                          20 * SizeConfig.blockSizeVertical,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.hourglass_empty,
                                                    size: 3.5 *
                                                        SizeConfig
                                                            .blockSizeVertical,
                                                  ),
                                                  SizedBox(
                                                    width: 3 *
                                                        SizeConfig
                                                            .blockSizeHorizontal,
                                                  ),
                                                  Text(
                                                    'Hours',
                                                    style: TextStyle(
                                                      fontSize: 2.8 *
                                                          SizeConfig
                                                              .blockSizeVertical,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                _hoursPassed.toString(),
                                                style: TextStyle(
                                                  fontSize: 2.5 *
                                                      SizeConfig
                                                          .blockSizeVertical,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      _hoursPassed == 0
                                                          ? Colors.black54
                                                          : Colors.blue[900],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    size: 3.5 *
                                                        SizeConfig
                                                            .blockSizeVertical,
                                                  ),
                                                  SizedBox(
                                                    width: 3 *
                                                        SizeConfig
                                                            .blockSizeHorizontal,
                                                  ),
                                                  Text(
                                                    'Calls',
                                                    style: TextStyle(
                                                      fontSize: 2.8 *
                                                          SizeConfig
                                                              .blockSizeVertical,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  _showNumberPicker(_numCalls);
                                                },
                                                child: Text(
                                                  _numCalls.toString(),
                                                  style: TextStyle(
                                                    fontSize: 2.5 *
                                                        SizeConfig
                                                            .blockSizeVertical,
                                                    fontWeight: FontWeight.w600,
                                                    color: _numCalls == 0
                                                        ? Colors.black54
                                                        : Colors.blue[900],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.list,
                                                    size: 3.5 *
                                                        SizeConfig
                                                            .blockSizeVertical,
                                                  ),
                                                  SizedBox(
                                                    width: 3 *
                                                        SizeConfig
                                                            .blockSizeHorizontal,
                                                  ),
                                                  Text(
                                                    'Tasks',
                                                    style: TextStyle(
                                                      fontSize: 2.8 *
                                                          SizeConfig
                                                              .blockSizeVertical,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                _numTasks.toString(),
                                                style: TextStyle(
                                                  fontSize: 2.5 *
                                                      SizeConfig
                                                          .blockSizeVertical,
                                                  fontWeight: FontWeight.w600,
                                                  color: _shift.numTasks == 0
                                                      ? Colors.black54
                                                      : Colors.blue[900],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4 *
                                            SizeConfig.blockSizeHorizontal),
                                        bottomLeft: Radius.circular(8 *
                                            SizeConfig.blockSizeHorizontal),
                                      ),
                                      child: Container(
                                        height:
                                            30 * SizeConfig.blockSizeVertical,
                                        width: 41 *
                                            SizeConfig.blockSizeHorizontal,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4 *
                                                SizeConfig
                                                    .blockSizeHorizontal),
                                            bottomLeft: Radius.circular(8 *
                                                SizeConfig
                                                    .blockSizeHorizontal),
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                NetworkImage(_imageUrl),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1 * SizeConfig.blockSizeVertical,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          minHeight: 23 * SizeConfig.blockSizeVertical,
                        ),
                        child: _numTasks == 0
                            ? Center(
                                child: Text(
                                  'No Tasks Completed',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w700,
                                    fontSize:
                                        2.5 * SizeConfig.blockSizeVertical,
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 4 * SizeConfig.blockSizeVertical,
                                  ),
                                  for (int i = 0; i < _listOfTasks.length; i++)
                                    Stack(
                                      children: [
                                        TaskDisplay(task: _listOfTasks[i], taskNum: i + 1, editable: true,),
                                        Positioned(
                                          top: 1 * SizeConfig.blockSizeVertical,
                                          right: 1 * SizeConfig.blockSizeHorizontal,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _listOfTasks.removeAt(i);
                                                _numTasks -= 1;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              size: 4 * SizeConfig.blockSizeVertical,
                                              color: Colors.indigo[900],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  SizedBox(
                                    height: 8 * SizeConfig.blockSizeVertical,
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: Container(
              height: 7.5 * SizeConfig.blockSizeVertical,
              width: 7.5 * SizeConfig.blockSizeVertical,
              child: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  size: 4.5 * SizeConfig.blockSizeVertical,
                  color: Colors.indigo[900],
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  createTaskDialog(context)
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        _listOfTasks.add(value);
                        _numTasks += 1;
                      });
                    }
                  });
                },
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: CustomRefreshIndicator(
                onRefresh: () async {
                  List<Widget> dbCarousel = await _database
                      .monthCarousels(_shift.date.year.toString());
                  dynamic result = await _database.getShiftData(_shift.date);
                  if (result != null) {
                    setState(() {
                      _shift = result;
                      globals.monthCarousels = dbCarousel;
                      edited = true;
                    });
                  }
                },
                builder: (BuildContext context, Widget child,
                    IndicatorController controller) {
                  return AnimatedBuilder(
                    animation: controller,
                    builder: (BuildContext context, _) {
                      return Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          if (!controller.isIdle)
                            Positioned(
                              top: 4 *
                                  SizeConfig.blockSizeVertical *
                                  controller.value,
                              child: SizedBox(
                                height: 4 * SizeConfig.blockSizeVertical,
                                width: 4 * SizeConfig.blockSizeVertical,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.indigo[900]),
                                  value: !controller.isLoading
                                      ? controller.value.clamp(0.0, 1.0)
                                      : null,
                                ),
                              ),
                            ),
                          Transform.translate(
                            offset: Offset(0, 100.0 * controller.value),
                            child: child,
                          ),
                        ],
                      );
                    },
                  );
                },
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(20, 52, 143, 1),
                          Colors.indigo[900],
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 75 * SizeConfig.blockSizeVertical,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    18 * SizeConfig.blockSizeHorizontal)),
                            color: Colors.white,
                          ),
                          child: SafeArea(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 3 * SizeConfig.blockSizeVertical,
                                  left: 7 * SizeConfig.blockSizeHorizontal),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 7 *
                                                SizeConfig.blockSizeHorizontal),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (edited) {
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          '/home',
                                                          (route) => false,
                                                          arguments: 0);
                                                } else {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Icon(
                                                Icons.arrow_back,
                                                color: Colors.black,
                                                size: 4.5 *
                                                    SizeConfig
                                                        .blockSizeVertical,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  editMode = true;
                                                });
                                              },
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                                size: 4 *
                                                    SizeConfig
                                                        .blockSizeVertical,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            3 * SizeConfig.blockSizeVertical,
                                      ),
                                      Container(
                                        width:
                                            86 * SizeConfig.blockSizeHorizontal,
                                        child: Text(
                                          _shift.title,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 4 *
                                                SizeConfig.blockSizeVertical,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            2.5 * SizeConfig.blockSizeVertical,
                                      ),
                                      Text(
                                        _conversions.toDateString(_shift.date),
                                        style: TextStyle(
                                          fontSize: 2.5 *
                                              SizeConfig.blockSizeVertical,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue[900],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            2 * SizeConfig.blockSizeVertical,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            _shift.timeIn,
                                            style: TextStyle(
                                              fontSize: 2.2 *
                                                  SizeConfig.blockSizeVertical,
                                              fontWeight: FontWeight.w600,
                                              color: _conversions
                                                      .isDay(_shift.timeIn)
                                                  ? Colors.blue[700]
                                                  : Colors.indigo[900],
                                            ),
                                          ),
                                          Text(
                                            '  -  ',
                                            style: TextStyle(
                                              fontSize: 2.2 *
                                                  SizeConfig.blockSizeVertical,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            _shift.timeOut,
                                            style: TextStyle(
                                              fontSize: 2.2 *
                                                  SizeConfig.blockSizeVertical,
                                              fontWeight: FontWeight.w600,
                                              color: _conversions
                                                      .isDay(_shift.timeOut)
                                                  ? Colors.blue[700]
                                                  : Colors.indigo[900],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            44 * SizeConfig.blockSizeHorizontal,
                                        height:
                                            20 * SizeConfig.blockSizeVertical,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.hourglass_empty,
                                                      size: 3.5 *
                                                          SizeConfig
                                                              .blockSizeVertical,
                                                    ),
                                                    SizedBox(
                                                      width: 3 *
                                                          SizeConfig
                                                              .blockSizeHorizontal,
                                                    ),
                                                    Text(
                                                      'Hours',
                                                      style: TextStyle(
                                                        fontSize: 2.8 *
                                                            SizeConfig
                                                                .blockSizeVertical,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  _shift.hoursPassed.toString(),
                                                  style: TextStyle(
                                                    fontSize: 2.5 *
                                                        SizeConfig
                                                            .blockSizeVertical,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        _shift.hoursPassed == 0
                                                            ? Colors.black54
                                                            : Colors.blue[900],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.phone,
                                                      size: 3.5 *
                                                          SizeConfig
                                                              .blockSizeVertical,
                                                    ),
                                                    SizedBox(
                                                      width: 3 *
                                                          SizeConfig
                                                              .blockSizeHorizontal,
                                                    ),
                                                    Text(
                                                      'Calls',
                                                      style: TextStyle(
                                                        fontSize: 2.8 *
                                                            SizeConfig
                                                                .blockSizeVertical,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  _shift.numCalls.toString(),
                                                  style: TextStyle(
                                                    fontSize: 2.5 *
                                                        SizeConfig
                                                            .blockSizeVertical,
                                                    fontWeight: FontWeight.w600,
                                                    color: _shift.numCalls == 0
                                                        ? Colors.black54
                                                        : Colors.blue[900],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.list,
                                                      size: 3.5 *
                                                          SizeConfig
                                                              .blockSizeVertical,
                                                    ),
                                                    SizedBox(
                                                      width: 3 *
                                                          SizeConfig
                                                              .blockSizeHorizontal,
                                                    ),
                                                    Text(
                                                      'Tasks',
                                                      style: TextStyle(
                                                        fontSize: 2.8 *
                                                            SizeConfig
                                                                .blockSizeVertical,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  _shift.numTasks.toString(),
                                                  style: TextStyle(
                                                    fontSize: 2.5 *
                                                        SizeConfig
                                                            .blockSizeVertical,
                                                    fontWeight: FontWeight.w600,
                                                    color: _shift.numTasks == 0
                                                        ? Colors.black54
                                                        : Colors.blue[900],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4 *
                                              SizeConfig.blockSizeHorizontal),
                                          bottomLeft: Radius.circular(8 *
                                              SizeConfig.blockSizeHorizontal),
                                        ),
                                        child: Container(
                                          height:
                                              30 * SizeConfig.blockSizeVertical,
                                          width: 41 *
                                              SizeConfig.blockSizeHorizontal,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4 *
                                                  SizeConfig
                                                      .blockSizeHorizontal),
                                              bottomLeft: Radius.circular(8 *
                                                  SizeConfig
                                                      .blockSizeHorizontal),
                                            ),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  NetworkImage(_shift.imageUrl),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1 * SizeConfig.blockSizeVertical,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            minHeight: 23 * SizeConfig.blockSizeVertical,
                          ),
                          child: _shift.numTasks == 0
                              ? Center(
                                  child: Text(
                                    'No Tasks Completed',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          2.5 * SizeConfig.blockSizeVertical,
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: 4 * SizeConfig.blockSizeVertical,
                                    ),
                                    for (int i = 0;
                                        i < _shift.listOfTasks.length;
                                        i++)
                                      TaskDisplay(
                                        task: _shift.listOfTasks[i],
                                        taskNum: i + 1,
                                        editable: false,
                                      ),
                                    SizedBox(
                                      height: 8 * SizeConfig.blockSizeVertical,
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: Container(
              height: 7.5 * SizeConfig.blockSizeVertical,
              width: 7.5 * SizeConfig.blockSizeVertical,
              child: FloatingActionButton(
                child: Icon(
                  Icons.delete,
                  size: 4.5 * SizeConfig.blockSizeVertical,
                  color: Colors.indigo[900],
                ),
                backgroundColor: Colors.white,
                onPressed: () async {
                  createDeleteDialog(context, _shift);
                },
              ),
            ),
          );
  }
}
