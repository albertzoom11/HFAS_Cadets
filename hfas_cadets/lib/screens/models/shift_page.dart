import 'dart:io';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/animation/fadeAnimation.dart';
import 'package:hfascadets/screens/models/shift.dart';
import 'package:hfascadets/screens/models/shift_arguments.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/models/task_display.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/screens/services/conversions.dart';
import 'package:hfascadets/screens/services/database.dart';
import 'package:hfascadets/shared/globals.dart' as globals;
import 'package:hfascadets/shared/loading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';

class ShiftPage extends StatefulWidget {
  @override
  _ShiftPageState createState() => _ShiftPageState();
}

class _ShiftPageState extends State<ShiftPage> {
  final Conversions _conversions = Conversions();
  final DatabaseService _database = DatabaseService();
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://hfas-cadets.appspot.com');
  Shift _shift;
  String _title;
  String _imageUrl;
  File _imageFile;
  DateTime _date;
  String _timeIn;
  String _timeOut;
  num _hoursPassed;
  int _numCalls;
  int _numTasks;
  List<String> _listOfTasks;
  bool firstTime = true;
  bool editMode = false;
  bool edited = false;
  bool loading = false;

  Future<String> createDeleteDialog(BuildContext context, Shift shift) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Delete Shift',
              style: TextStyle(color: Colors.blue[900]),
            ),
            content: Text(
              'Delete ${shift.title}?',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5,
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                elevation: 5,
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.blueAccent),
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
              style: TextStyle(color: Colors.blue[900]),
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
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onPressed: () {
                  Navigator.pop(context, customController.text.toString());
                },
              ),
            ],
          );
        });
  }

  Future<String> createTitleDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Change Title',
              style: TextStyle(color: Colors.blue[900]),
            ),
            content: TextField(
              controller: customController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Title Name',
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.blueAccent),
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
          if (value != null) {
           setState(() {
             _numCalls = value;
           });
          }
    });
  }

  createErrorDialog(BuildContext context, String msg) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(color: Colors.blue[900]),
            ),
            content: Text(
              msg,
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5,
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    if (selected != null) {
      setState(() {
        _imageFile = selected;
      });
      _cropImage();
    }
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Profile Photo',
        toolbarColor: Colors.indigo[900],
        statusBarColor: Colors.indigo[900],
        backgroundColor: Colors.indigo[900],
        activeControlsWidgetColor: Colors.indigo[900],
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        hideBottomControls: true,
      ),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  Future<void> _startUpload(DateTime dateTime) async {
    String filePath = 'users/${globals.user.uid}/${dateTime.year.toString()}/${globals.months[dateTime.month - 1]}/${DateTime.now()}.png';

    StorageUploadTask _uploadTask =
    _storage.ref().child(filePath).putFile(_imageFile);

    StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
    print('file uploaded');
    String output = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      _imageUrl = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    ShiftArguments shiftArgs = ModalRoute.of(context).settings.arguments;
    if (firstTime) {
      setState(() {
        editMode = shiftArgs.editMode;
        _shift = shiftArgs.shift;
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

    return loading ? Loading() : editMode
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
                                      child: FadeAnimation(0.3, Row(
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
                                            onTap: () async {
                                              setState(() {
                                                loading = true;
                                                edited = true;
                                                editMode = false;
                                              });
                                              if (_imageFile != null) {
                                                await _startUpload(_date);
                                              }
                                              Shift _newShift = Shift(
                                                title: _title,
                                                imageUrl: _imageUrl,
                                                date: _date,
                                                timeIn: _timeIn,
                                                timeOut: _timeOut,
                                                hoursPassed: _hoursPassed,
                                                numCalls: _numCalls,
                                                numTasks: _numTasks,
                                                listOfTasks: _listOfTasks,
                                              );
                                              await _database.editShift(_shift, _newShift);
                                              await _database.addOrSubtractUserTotals(_newShift.hoursPassed, _newShift.numCalls, _newShift.numTasks);
                                              List<Widget> dbCarousel = await _database.monthCarousels(_shift.date.year.toString());
                                              User dbUser = await _database.getUser(globals.user.uid);
                                              dynamic value = await _database.monthStats(_newShift.date.year.toString());
                                              setState(() {
                                                _shift = _newShift;
                                                globals.user = dbUser;
                                                globals.monthCarousels = dbCarousel;
                                                globals.profileMonths = value;
                                                loading = false;
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
                                      )),
                                    ),
                                    SizedBox(
                                      height:
                                          3 * SizeConfig.blockSizeVertical,
                                    ),
                                    FadeAnimation(0.4, GestureDetector(
                                      onTap: () {
                                        createTitleDialog(context).then((value) {
                                          if (value != null) {
                                            setState(() {
                                              _title = value;
                                            });
                                          }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: 76 * SizeConfig.blockSizeHorizontal,
                                            ),
                                            child: Text(
                                              _title,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 4 * SizeConfig.blockSizeVertical,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                          SizedBox(width: 2 * SizeConfig.blockSizeHorizontal,),
                                          Icon(
                                            Icons.edit,
                                            size: 4 * SizeConfig.blockSizeVertical,
                                          ),
                                        ],
                                      ),
                                    )),
                                    SizedBox(
                                      height:
                                          2.5 * SizeConfig.blockSizeVertical,
                                    ),
                                    FadeAnimation(0.5, GestureDetector(
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: _date,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                        ).then((date) {
                                          if (date != null) {
                                            setState(() {
                                              _date = DateTime(date.year, date.month, date.day, _date.hour, _date.minute);
                                            });
                                          }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            _conversions.toDateString(_date),
                                            style: TextStyle(
                                              fontSize: 2.5 *
                                                  SizeConfig.blockSizeVertical,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue[900],
                                            ),
                                          ),
                                          SizedBox(width: 2 * SizeConfig.blockSizeHorizontal,),
                                          Icon(
                                            Icons.edit,
                                            size: 2.5 * SizeConfig.blockSizeVertical,
                                            color: Colors.blue[900],
                                          ),
                                        ],
                                      ),
                                    )),
                                    SizedBox(
                                      height:
                                          2 * SizeConfig.blockSizeVertical,
                                    ),
                                    FadeAnimation(0.6, Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            showTimePicker(
                                              context: context,
                                              initialTime: _conversions.stringToTime(_timeIn)
                                            ).then((time) {
                                              if (time != null) {
                                                String _isValid = _conversions.timesAreInvalid(time.hour, time.minute, _conversions.stringToTime(_timeOut).hour, _conversions.stringToTime(_timeOut).minute);
                                                if (_isValid == 'invalid') {
                                                  createErrorDialog(context, 'Your new start time is before your end time. Please try again.');
                                                } else if (_isValid == 'same') {
                                                  createErrorDialog(context, 'Your start and end time are the same. Please try again.');
                                                } else {
                                                  num hoursPassedTemp = _conversions.calculateHoursPassed(time.hour, time.minute, _conversions.stringToTime(_timeOut).hour, _conversions.stringToTime(_timeOut).minute);
                                                  hoursPassedTemp = hoursPassedTemp % 1 == 0 ? hoursPassedTemp.toInt() : hoursPassedTemp;
                                                  setState(() {
                                                    _timeIn = time.format(context);
                                                    _hoursPassed = hoursPassedTemp;
                                                    _date = DateTime(_date.year, _date.month, _date.day, time.hour, time.minute);
                                                  });
                                                }
                                              }
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                _timeIn,
                                                style: TextStyle(
                                                  fontSize: 2.2 *
                                                      SizeConfig.blockSizeVertical,
                                                  fontWeight: FontWeight.w600,
                                                  color: _conversions.isDay(_timeIn)
                                                      ? Colors.blue[700]
                                                      : Colors.indigo[900],
                                                ),
                                              ),
                                              SizedBox(width: 2 * SizeConfig.blockSizeHorizontal,),
                                              Icon(
                                                Icons.edit,
                                                size: 2.2 * SizeConfig.blockSizeVertical,
                                                color: _conversions.isDay(_timeIn)
                                                    ? Colors.blue[700]
                                                    : Colors.indigo[900],
                                              ),
                                            ],
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
                                              initialTime: _conversions.stringToTime(_timeOut)
                                            ).then((time) {
                                              if (time != null) {
                                                String _isValid = _conversions.timesAreInvalid(_conversions.stringToTime(_timeIn).hour, _conversions.stringToTime(_timeIn).minute, time.hour, time.minute);
                                                if (_isValid == 'invalid') {
                                                  createErrorDialog(context, 'Your new end time is before your start time. Please try again.');
                                                } else if (_isValid == 'same') {
                                                  createErrorDialog(context, 'Your start and end time are the same. Please try again.');
                                                } else {
                                                  num hoursPassedTemp = _conversions.calculateHoursPassed(_conversions.stringToTime(_timeIn).hour, _conversions.stringToTime(_timeIn).minute, time.hour, time.minute);
                                                  hoursPassedTemp = hoursPassedTemp % 1 == 0 ? hoursPassedTemp.toInt() : hoursPassedTemp;
                                                  setState(() {
                                                    _timeOut = time.format(context);
                                                    _hoursPassed = hoursPassedTemp;
                                                  });
                                                }
                                              }
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                _timeOut,
                                                style: TextStyle(
                                                  fontSize: 2.2 *
                                                      SizeConfig.blockSizeVertical,
                                                  fontWeight: FontWeight.w600,
                                                  color: _conversions.isDay(_timeOut)
                                                      ? Colors.blue[700]
                                                      : Colors.indigo[900],
                                                ),
                                              ),
                                              SizedBox(width: 2 * SizeConfig.blockSizeHorizontal,),
                                              Icon(
                                                Icons.edit,
                                                size: 2.5 * SizeConfig.blockSizeVertical,
                                                color: _conversions.isDay(_timeOut)
                                                    ? Colors.blue[700]
                                                    : Colors.indigo[900],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          48 * SizeConfig.blockSizeHorizontal,
                                      height:
                                          20 * SizeConfig.blockSizeVertical,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FadeAnimation(0.7, Row(
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
                                              Row(
                                                children: [
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
                                                  SizedBox(width: 1 * SizeConfig.blockSizeHorizontal,),
                                                  Icon(Icons.edit, size: 2.5 * SizeConfig.blockSizeVertical, color: Colors.transparent,),
                                                ],
                                              ),
                                            ],
                                          )),
                                          FadeAnimation(0.8, Row(
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
                                                child: Row(
                                                  children: [
                                                    Text(
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
                                                    SizedBox(width: 1 * SizeConfig.blockSizeHorizontal),
                                                    Icon(
                                                      Icons.edit,
                                                      size: 2.5 * SizeConfig.blockSizeVertical,
                                                      color: Colors.blue[900],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                          FadeAnimation(0.9, Row(
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
                                              Row(
                                                children: [
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
                                                  SizedBox(width: 1 * SizeConfig.blockSizeHorizontal,),
                                                  Icon(Icons.edit, size: 2.5 * SizeConfig.blockSizeVertical, color: Colors.transparent,),
                                                ],
                                              ),
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                    FadeAnimation(0.7, GestureDetector(
                                      onTap: () async {
                                        await _pickImage(ImageSource.camera);
                                      },
                                      child: Stack(
                                        children: [
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
                                                  image: _imageFile == null ? NetworkImage(_imageUrl) : FileImage(_imageFile),
                                                ),
                                              ),
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
                                                  image: AssetImage('assets/images/takePhotoBlack.png'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
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
                      FadeAnimation(1, Container(
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
                      )),
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
                  List<Widget> dbCarousel = await _database.monthCarousels(_shift.date.year.toString());
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
