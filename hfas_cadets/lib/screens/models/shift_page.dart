import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/shift.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/services/conversions.dart';

class ShiftPage extends StatefulWidget {
  @override
  _ShiftPageState createState() => _ShiftPageState();
}

class _ShiftPageState extends State<ShiftPage> {
  @override
  final Conversions _conversions = Conversions();

  Widget build(BuildContext context) {
    final Shift _shift = ModalRoute.of(context).settings.arguments;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(20, 52, 143, 1),
            Colors.indigo[900],
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18 * SizeConfig.blockSizeHorizontal)),
                  color: Colors.white,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 3 * SizeConfig.blockSizeVertical, left: 7 * SizeConfig.blockSizeHorizontal),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 7 * SizeConfig.blockSizeHorizontal),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {Navigator.pop(context);},
                                    child: Icon(Icons.arrow_back, color: Colors.black, size: 4.5 * SizeConfig.blockSizeVertical,),
                                  ),
                                  GestureDetector(
                                    onTap: () {Navigator.pop(context);},
                                    child: Icon(Icons.edit, color: Colors.black, size: 4 * SizeConfig.blockSizeVertical,),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 3 * SizeConfig.blockSizeVertical,),
                            Container(
                              width: 86 * SizeConfig.blockSizeHorizontal,
                              child: Text(
                                _shift.title,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 4 * SizeConfig.blockSizeVertical,
                                ),
                              ),
                            ),
                            SizedBox(height: 2.5 * SizeConfig.blockSizeVertical,),
                            Text(
                              _conversions.toDateString(_shift.date),
                              style: TextStyle(
                                fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue[900],
                              ),
                            ),
                            SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                            Row(
                              children: [
                                Text(
                                  _shift.timeIn,
                                  style: TextStyle(
                                    fontSize: 2.2 * SizeConfig.blockSizeVertical,
                                    fontWeight: FontWeight.w600,
                                    color: _conversions.isDay(_shift.timeIn) ? Colors.blue[700] : Colors.indigo[900],
                                  ),
                                ),
                                Text('  -  ', style: TextStyle(fontSize: 2.2 * SizeConfig.blockSizeVertical, fontWeight: FontWeight.bold,),),
                                Text(
                                  _shift.timeOut,
                                  style: TextStyle(
                                    fontSize: 2.2 * SizeConfig.blockSizeVertical,
                                    fontWeight: FontWeight.w600,
                                    color: _conversions.isDay(_shift.timeIn) ? Colors.blue[700] : Colors.indigo[900],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 43 * SizeConfig.blockSizeHorizontal,
                              height: 20 * SizeConfig.blockSizeVertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.hourglass_empty),
                                          SizedBox(width: 3 * SizeConfig.blockSizeHorizontal,),
                                          Text(
                                            'Hours',
                                            style: TextStyle(
                                              fontSize: 2.8 * SizeConfig.blockSizeVertical,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        _shift.hoursPassed.toString(),
                                        style: TextStyle(
                                          fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                          fontWeight: FontWeight.w600,
                                          color: _shift.hoursPassed == 0 ? Colors.black54 : Colors.blue[900],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.phone),
                                          SizedBox(width: 3 * SizeConfig.blockSizeHorizontal,),
                                          Text(
                                            'Calls',
                                            style: TextStyle(
                                              fontSize: 2.8 * SizeConfig.blockSizeVertical,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        _shift.numCalls.toString(),
                                        style: TextStyle(
                                          fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                          fontWeight: FontWeight.w600,
                                          color: _shift.numCalls == 0 ? Colors.black54 : Colors.blue[900],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.list),
                                          SizedBox(width: 3 * SizeConfig.blockSizeHorizontal,),
                                          Text(
                                            'Tasks',
                                            style: TextStyle(
                                              fontSize: 2.8 * SizeConfig.blockSizeVertical,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        _shift.numTasks.toString(),
                                        style: TextStyle(
                                          fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                          fontWeight: FontWeight.w600,
                                          color: _shift.numTasks == 0 ? Colors.black54 : Colors.blue[900],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8 * SizeConfig.blockSizeHorizontal), bottomLeft: Radius.circular(8 * SizeConfig.blockSizeHorizontal),),
                              child: Container(
                                height: 30 * SizeConfig.blockSizeVertical,
                                width: 43 * SizeConfig.blockSizeHorizontal,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8 * SizeConfig.blockSizeHorizontal), bottomLeft: Radius.circular(8 * SizeConfig.blockSizeHorizontal),),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(_shift.imageUrl),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1 * SizeConfig.blockSizeVertical,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
        floatingActionButton: Container(
          height: 7.5 * SizeConfig.blockSizeVertical,
          width: 7.5 * SizeConfig.blockSizeVertical,
          child: FloatingActionButton(
            child: Icon(Icons.delete, size: 4.5 * SizeConfig.blockSizeVertical, color: Colors.indigo[900],),
            backgroundColor: Colors.white,
            onPressed: () {
              print('delete');
            },
          ),
        ),
      ),
    );
  }
}

