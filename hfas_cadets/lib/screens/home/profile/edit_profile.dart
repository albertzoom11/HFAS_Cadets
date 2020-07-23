import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/screen_arguments.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/models/user.dart';
import 'package:hfascadets/animation/fadeAnimation.dart';
import 'package:hfascadets/screens/services/auth.dart';
import 'package:hfascadets/screens/services/database.dart';
import 'package:hfascadets/shared/loading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://hfas-cadets.appspot.com');
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  // text field state
  String email = '';
  String name = '';
  String error = '';

  // image capture
  File _imageFile;
  String _imageURL = '';

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    if (selected != null) {
      setState(() {
        _imageFile = selected;
      });
    }
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      cropStyle: CropStyle.circle,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Profile Photo',
        toolbarColor: Colors.indigo[900],
        statusBarColor: Colors.indigo[900],
        backgroundColor: Colors.indigo[900],
        activeControlsWidgetColor: Colors.indigo[900],
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
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

  // change profile picture options modal
  createPictureModal(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Change Profile Photo',
              style: TextStyle(color: Colors.indigo[900]),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 1 * SizeConfig.blockSizeVertical),
                  child: Divider(
                    height: 0.1 * SizeConfig.blockSizeVertical,
                    color: Colors.indigo[900],
                  ),
                ),
                SizedBox(
                  height: 1 * SizeConfig.blockSizeVertical,
                ),
                FlatButton(
                  onPressed: () async {
                    await _pickImage(ImageSource.camera);
                    await _cropImage();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Take Photo with Camera',
                    style: TextStyle(
                      color: Colors.indigo[900],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1 * SizeConfig.blockSizeVertical,
                ),
                FlatButton(
                  onPressed: () async {
                    await _pickImage(ImageSource.gallery);
                    await _cropImage();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Choose from Gallery',
                    style: TextStyle(
                      color: Colors.indigo[900],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1 * SizeConfig.blockSizeVertical,
                ),
                FlatButton(
                  onPressed: () async {
                    setState(() {
                      _imageFile = null;
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Remove Profile Photo',
                    style: TextStyle(
                      color: Colors.indigo[900],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    email = email == '' ? user.email : email;
    name = name == '' ? user.name : name;
    _imageURL = _imageURL == '' ? user.profilePic : _imageURL;
    final DatabaseService _databaseService = DatabaseService(uid: user.uid);

    Future<void> _startUpload() async {
      String filePath = 'users/${user.uid}/profile.png';

      StorageUploadTask _uploadTask = _storage.ref().child(filePath).putFile(_imageFile);

      StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
      print('file uploaded');
      String output = await taskSnapshot.ref.getDownloadURL();
      setState(() {
        _imageURL = output;
      });
    }

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
                  SizedBox(
                    height: 1 * SizeConfig.blockSizeVertical,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          FadeAnimation(
                              .6,
                              GestureDetector(
                                child: Container(
                                  height: 13 * SizeConfig.blockSizeVertical,
                                  width: 26 * SizeConfig.blockSizeHorizontal,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: _imageFile == null
                                          ? NetworkImage(user.profilePic)
                                          : FileImage(_imageFile),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  createPictureModal(context);
                                },
                              )),
                          SizedBox(
                            height: 2 * SizeConfig.blockSizeVertical,
                          ),
                          FadeAnimation(
                              .7,
                              GestureDetector(
                                child: Text(
                                  'Change Profile Photo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                onTap: () {
                                  createPictureModal(context);
                                },
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
                            topLeft: Radius.circular(
                                7 * SizeConfig.blockSizeVertical),
                            topRight: Radius.circular(
                                7 * SizeConfig.blockSizeVertical)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8 * SizeConfig.blockSizeHorizontal),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5 * SizeConfig.blockSizeVertical,
                            ),
                            FadeAnimation(
                                .8,
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.person),
                                          labelText: 'Name',
                                        ),
                                        initialValue: user.name,
                                        validator: (val) => val.isEmpty
                                            ? 'Please enter a name.'
                                            : null,
                                        onChanged: (val) {
                                          setState(() {
                                            name = val;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                          height:
                                              2 * SizeConfig.blockSizeVertical),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.email),
                                          labelText: 'Email',
                                        ),
                                        initialValue: user.email,
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
                                        height:
                                            1 * SizeConfig.blockSizeVertical,
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
                            FadeAnimation(
                              .9,
                              Text(
                                'Change Role',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 2 * SizeConfig.blockSizeVertical,
                                ),
                              ),
                            ),
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
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          highlightElevation: 0,
                                          disabledBorderColor: Colors.black,
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(4 *
                                                  SizeConfig
                                                      .blockSizeHorizontal),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                          if (_formKey.currentState
                                              .validate()) {
                                            String tempUrl;
                                            if (_imageFile != null) {
                                              await _startUpload();
                                            }
                                            setState(() {
                                              loading = true;
                                            });
                                            dynamic updateEmailResult = 'no change';
                                            if (email != user.email) {
                                              updateEmailResult =
                                                  await _auth
                                                      .updateEmail(email);
                                            }
                                            if (updateEmailResult == null) {
                                              setState(() {
                                                error =
                                                    'Please enter a valid email.';
                                                loading = false;
                                              });
                                            } else {
                                              User newUser = User(
                                                uid: user.uid,
                                                profilePic: _imageURL,
                                                name: name,
                                                email: email,
                                                role: user.role,
                                                totalHours: user.totalHours,
                                                totalCalls: user.totalCalls,
                                                totalTasks: user.totalTasks,
                                              );
                                              dynamic result =
                                                  await _databaseService
                                                      .updateUserInfo(newUser);
                                              if (result == null) {
                                                setState(() {
                                                  error =
                                                      'Something went wrong.';
                                                  loading = false;
                                                });
                                              } else {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                  context,
                                                  '/home',
                                                  (route) => false,
                                                  arguments: ScreenArguments(
                                                      user: newUser,
                                                      tabNumber: 3),
                                                );
                                              }
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
                                              padding: EdgeInsets.all(4 *
                                                  SizeConfig
                                                      .blockSizeHorizontal),
                                              child: Text(
                                                'Save Changes',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
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
