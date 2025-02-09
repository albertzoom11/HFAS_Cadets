import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hfascadets/animation/fadeAnimation.dart';
import 'package:hfascadets/screens/models/shift.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/services/conversions.dart';
import 'package:hfascadets/screens/services/database.dart';
import 'package:hfascadets/shared/loading.dart';
import 'package:hfascadets/shared/globals.dart' as globals;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://hfas-cadets.appspot.com');
  final _formKey = GlobalKey<FormState>();
  final _taskListKey = GlobalKey<AnimatedListState>();
  final Conversions _conversions = Conversions();
  final DatabaseService _database = DatabaseService();
  List<String> _tasks = [];
  String _dateOutput = '';
  DateTime _dateTime;
  TimeOfDay _startTime;
  TimeOfDay _endTime;
  int _numTasks = 0;
  int _numCalls = 0;
  String _title = '';
  bool loading = false;
  File _imageFile;
  String _imageURL;

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
      _imageURL = output;
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

  @override
  Widget build(BuildContext context) {

    return loading ? Loading()
        : Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 20 * SizeConfig.blockSizeVertical,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                      Colors.indigo[900],
                      Color.fromRGBO(20, 52, 143, 1),
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
                          FadeAnimation(
                              0.3,
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                iconSize: 8 * SizeConfig.blockSizeHorizontal,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )),
                          FadeAnimation(
                              0.4,
                              Text(
                                'CREATE ENTRY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 2.2 * SizeConfig.blockSizeVertical,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          FadeAnimation(
                              0.5,
                              IconButton(
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                iconSize: 8 * SizeConfig.blockSizeHorizontal,
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    if (_numCalls < 0 || _numCalls > 10 || _numCalls.isNaN) {
                                      createErrorDialog(context, 'Please enter a real number of calls in one shift.');
                                    } else if (_dateTime == null || _startTime == null || _endTime == null) {
                                      createErrorDialog(context, 'You\'re missing the date, start time, or end time.\n\nPlease try again.');
                                    } else {
                                      String _isValid =
                                          _conversions.timesAreInvalid(
                                              _startTime.hour,
                                              _startTime.minute,
                                              _endTime.hour,
                                              _endTime.minute);
                                      if (_isValid == 'invalid') {
                                        createErrorDialog(context,
                                            'Make sure your start time is before your end time.');
                                      } else if (_isValid == 'same') {
                                        createErrorDialog(context,
                                            'Your start and end time are the same. Please try again.');
                                      } else if (_imageFile == null) {
                                        createErrorDialog(context,
                                            'Take a photo of your duty sheet to submit.');
                                      } else {
                                        setState(() {
                                          loading = true;
                                        });
                                        await _startUpload(_dateTime);
                                        num _hoursPassed =
                                            _conversions.calculateHoursPassed(
                                                _startTime.hour,
                                                _startTime.minute,
                                                _endTime.hour,
                                                _endTime.minute);
                                        await _database.addOrSubtractUserTotals(_hoursPassed, _numCalls, _numTasks);
                                        dynamic result =
                                            await _database.addShift(Shift(
                                                title: _title,
                                                date: _dateTime,
                                                imageUrl: _imageURL,
                                                timeIn: _startTime
                                                    .format(context)
                                                    .toString(),
                                                timeOut: _endTime
                                                    .format(context)
                                                    .toString(),
                                                hoursPassed: _hoursPassed,
                                                numCalls: _numCalls,
                                                numTasks: _numTasks,
                                                listOfTasks: _tasks,
                                            ));
                                        List<Widget> dbCarousels = await _database.monthCarousels(globals.displayYear.toString());
                                        dynamic value = await _database.monthStats(globals.displayYear.toString());
                                        if (!globals.years.contains(_dateTime.year.toString())) {
                                          List<String> dbYears = await _database.getYears();
                                          setState(() {
                                            globals.years = dbYears;
                                          });
                                        }
                                        setState(() {
                                          globals.profileMonths = value;
                                          globals.monthCarousels = dbCarousels;
                                        });
                                        if (result == null) {
                                          setState(() {
                                            loading = false;
                                          });
                                          createErrorDialog(context,
                                              'Could not create entry.\nPlease try again later.');
                                        } else {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/home',
                                            (route) => false,
                                            arguments: 0,
                                          );
                                        }
                                      }
                                    }
                                  }
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 13 * SizeConfig.blockSizeVertical),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7 * SizeConfig.blockSizeVertical),
                          topRight: Radius.circular(7 * SizeConfig.blockSizeVertical)),
                    ),
                    height: 87 * SizeConfig.blockSizeVertical,
                    child: Padding(
                      padding: EdgeInsets.only(top: 6 * SizeConfig.blockSizeVertical, left: 7 * SizeConfig.blockSizeHorizontal, right: 7 * SizeConfig.blockSizeHorizontal),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FadeAnimation(
                                  0.6,
                                  GestureDetector(
                                    onTap: () async {
                                      await _pickImage(ImageSource.camera);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          5 *
                                              SizeConfig
                                                  .blockSizeHorizontal),
                                      child: Container(
                                        height: 24 *
                                            SizeConfig.blockSizeVertical,
                                        width: 34 *
                                            SizeConfig.blockSizeHorizontal,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: _imageFile == null
                                                  ? Colors.grey
                                                  : Colors.indigo[900]),
                                          borderRadius:
                                              BorderRadius.circular(5 *
                                                  SizeConfig
                                                      .blockSizeHorizontal),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: _imageFile != null
                                                ? FileImage(_imageFile)
                                                : AssetImage(
                                                    'assets/images/takePhoto.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  FadeAnimation(
                                      0.7,
                                      GestureDetector(
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: _dateTime == null
                                                ? DateTime.now()
                                                : _dateTime,
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                          ).then((date) {
                                            if (date != null) {
                                              if (_startTime == null) {
                                                setState(() {
                                                  _dateTime = date;
                                                  _dateOutput = _conversions.toDateString(date, shortened: true);
                                                });
                                              } else {
                                                setState(() {
                                                  _dateTime = DateTime(date.year, date.month, date.day, _startTime.hour, _startTime.minute);
                                                  _dateOutput = _conversions.toDateString(date, shortened: true);
                                                });
                                              }
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: 45 *
                                              SizeConfig
                                                  .blockSizeHorizontal,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: _dateTime == null
                                                    ? Colors.grey
                                                    : Colors.blue[900]),
                                            borderRadius:
                                                BorderRadius.circular(8 *
                                                    SizeConfig
                                                        .blockSizeHorizontal),
                                          ),
                                          child: Padding(
                                            padding: _dateTime == null
                                                ? EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        SizeConfig
                                                            .blockSizeVertical,
                                                    horizontal: 2 *
                                                        SizeConfig
                                                            .blockSizeHorizontal)
                                                : EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        SizeConfig
                                                            .blockSizeVertical,
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
                                                      SizeConfig
                                                          .blockSizeVertical,
                                                  color: _dateTime == null
                                                      ? Colors.grey
                                                      : Colors.blue[900],
                                                ),
                                                SizedBox(
                                                  width: 1 *
                                                      SizeConfig
                                                          .blockSizeHorizontal,
                                                ),
                                                Text(
                                                  _dateTime == null
                                                      ? 'Date'
                                                      : _dateOutput,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 2 *
                                                        SizeConfig
                                                            .blockSizeVertical,
                                                    color: _dateTime == null
                                                        ? Colors.grey
                                                        : Colors.blue[900],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                      height:
                                          2 * SizeConfig.blockSizeVertical),
                                  FadeAnimation(
                                      0.8,
                                      GestureDetector(
                                        onTap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: _startTime == null
                                                ? TimeOfDay.now()
                                                : _startTime,
                                          ).then((time) {
                                            if (time != null) {
                                              setState(() {
                                                _startTime = time;
                                                _dateTime = _dateTime == null ? null : DateTime(_dateTime.year, _dateTime.month, _dateTime.day, _startTime.hour, _startTime.minute);
                                              });
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: 45 *
                                              SizeConfig
                                                  .blockSizeHorizontal,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: _startTime == null
                                                    ? Colors.grey
                                                    : _conversions.isDay(_startTime.format(context)) ? Colors.blue[700] : Colors.indigo[900]),
                                            borderRadius:
                                                BorderRadius.circular(8 *
                                                    SizeConfig
                                                        .blockSizeHorizontal),
                                          ),
                                          child: Padding(
                                            padding: _startTime == null
                                                ? EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        SizeConfig
                                                            .blockSizeVertical,
                                                    horizontal: 5.5 *
                                                        SizeConfig
                                                            .blockSizeHorizontal)
                                                : EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        SizeConfig
                                                            .blockSizeVertical,
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
                                                      SizeConfig
                                                          .blockSizeVertical,
                                                  color: _startTime == null
                                                      ? Colors.grey
                                                      : _conversions.isDay(_startTime.format(context)) ? Colors.blue[700] : Colors.indigo[900],
                                                ),
                                                SizedBox(
                                                  width: 1 *
                                                      SizeConfig
                                                          .blockSizeHorizontal,
                                                ),
                                                Text(
                                                  _startTime == null
                                                      ? 'Start Time'
                                                      : _startTime
                                                          .format(context),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 2 *
                                                        SizeConfig
                                                            .blockSizeVertical,
                                                    color: _startTime == null
                                                        ? Colors.grey
                                                        : _conversions.isDay(_startTime.format(context)) ? Colors.blue[700] : Colors.indigo[900],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                      height:
                                          2 * SizeConfig.blockSizeVertical),
                                  FadeAnimation(
                                      0.9,
                                      GestureDetector(
                                        onTap: () {
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
                                          width: 45 *
                                              SizeConfig
                                                  .blockSizeHorizontal,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: _endTime == null
                                                    ? Colors.grey
                                                    : _conversions.isDay(_endTime.format(context)) ? Colors.blue[700] : Colors.indigo[900]),
                                            borderRadius:
                                                BorderRadius.circular(8 *
                                                    SizeConfig
                                                        .blockSizeHorizontal),
                                          ),
                                          child: Padding(
                                            padding: _endTime == null
                                                ? EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        SizeConfig
                                                            .blockSizeVertical,
                                                    horizontal: 6.5 *
                                                        SizeConfig
                                                            .blockSizeHorizontal)
                                                : EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        SizeConfig
                                                            .blockSizeVertical,
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
                                                      SizeConfig
                                                          .blockSizeVertical,
                                                  color: _endTime == null
                                                      ? Colors.grey
                                                      : _conversions.isDay(_endTime.format(context)) ? Colors.blue[700] : Colors.indigo[900],
                                                ),
                                                SizedBox(
                                                  width: 1 *
                                                      SizeConfig
                                                          .blockSizeHorizontal,
                                                ),
                                                Text(
                                                  _endTime == null
                                                      ? 'End Time'
                                                      : _endTime
                                                          .format(context),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 2 *
                                                        SizeConfig
                                                            .blockSizeVertical,
                                                    color: _endTime == null
                                                        ? Colors.grey
                                                        : _conversions.isDay(_endTime.format(context)) ? Colors.blue[700] : Colors.indigo[900],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
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
                                FadeAnimation(
                                    1,
                                    TextFormField(
                                      textCapitalization: TextCapitalization.words,
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.title),
                                        hintText: 'Title',
                                      ),
                                      validator: (val) => val.isEmpty
                                          ? 'Please enter a title.'
                                          : null,
                                      onChanged: (val) {
                                        setState(() {
                                          _title = val;
                                        });
                                      },
                                    )),
                                SizedBox(
                                    height:
                                        2 * SizeConfig.blockSizeVertical),
                                FadeAnimation(
                                    1.1,
                                    TextFormField(
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.call),
                                        hintText: 'Number of Calls',
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (val) => val.isEmpty
                                          ? 'Please enter a number.'
                                          : null,
                                      onChanged: (val) {
                                        setState(() {
                                          _numCalls = int.parse(val);
                                        });
                                      },
                                    )),
                                SizedBox(
                                  height: 1 * SizeConfig.blockSizeVertical,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3 * SizeConfig.blockSizeVertical,
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FadeAnimation(
                                  1.2,
                                  Text(
                                    'Tasks: $_numTasks',
                                    style: TextStyle(
                                      color: _numTasks == 0
                                          ? Colors.grey
                                          : Colors.indigo[900],
                                      fontSize: 2.4 *
                                          SizeConfig.blockSizeVertical,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              FadeAnimation(
                                  1.3,
                                  GestureDetector(
                                    onTap: () {
                                      createTaskDialog(context)
                                          .then((value) {
                                        if (value != null) {
                                          _addTask(value);
                                          setState(() {
                                            _numTasks += 1;
                                          });
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 1 *
                                              SizeConfig
                                                  .blockSizeHorizontal),
                                      child: Icon(
                                        Icons.add,
                                        color: _numTasks == 0
                                            ? Colors.grey
                                            : Colors.indigo[900],
                                        size: 4 *
                                            SizeConfig.blockSizeVertical,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 1.5 * SizeConfig.blockSizeVertical,
                          ),
                          FadeAnimation(
                              1.3,
                              Container(
                                height: 23 * SizeConfig.blockSizeVertical,
                                decoration: BoxDecoration(
                                  border: Border.symmetric(
                                      vertical: BorderSide(
                                          color: _numTasks == 0
                                              ? Colors.grey
                                              : Colors.indigo[900])),
                                ),
                                child: AnimatedList(
                                  key: _taskListKey,
                                  initialItemCount: _tasks.length,
                                  itemBuilder: (context, index, animation) {
                                    return _buildTask(_tasks[index], animation, index);
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildTask(String task, Animation animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text(
            task,
            style: TextStyle(
              color: Colors.indigo[900],
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.indigo[900],
            ),
            onPressed: () {
              _removeTask(index);
              setState(() {
                _numTasks -= 1;
              });
            },
          ),
        ),
      ),
    );
  }

  void _addTask(String task) {
    int i = _tasks.length;
    _tasks.insert(i, task);
    _taskListKey.currentState.insertItem(i);
  }

  void _removeTask(int i) {
    String removedItem = _tasks.removeAt(i);
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildTask(removedItem, animation, i);
    };
    _taskListKey.currentState.removeItem(i, builder);
  }
}
