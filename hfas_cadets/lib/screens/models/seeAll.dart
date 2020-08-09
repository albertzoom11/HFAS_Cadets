import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/shift.dart';
import 'package:hfascadets/screens/models/size_config.dart';
import 'package:hfascadets/screens/services/conversions.dart';
import 'package:hfascadets/shared/globals.dart' as globals;

class MonthSeeAll extends StatelessWidget {
  final String _year = DateTime.now().year.toString();
  final Conversions _conversions = Conversions();

  @override
  Widget build(BuildContext context) {
    final List<Shift> shifts = ModalRoute.of(context).settings.arguments;
    final Color _monthColor = _conversions.getMonthColor(shifts[0].date.month);

    return Scaffold(
      backgroundColor: Color(0xFFF3F5F7),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 100 * SizeConfig.blockSizeHorizontal,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(4 * SizeConfig.blockSizeHorizontal),
                  boxShadow: [
                    BoxShadow(
                      color: _monthColor,
                      offset: Offset(0.0, 10),
                      blurRadius: 3 * SizeConfig.blockSizeVertical, // change to sizeconfig
                    )
                  ],
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(3 * SizeConfig.blockSizeHorizontal),
                    child: Image(
                      image: AssetImage('assets/images/months/${globals.months[shifts[0].date.month - 1].toLowerCase()}.jpg'),
                      fit: BoxFit.cover,
                    )),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 4 * SizeConfig.blockSizeHorizontal,
                      vertical: 1.5 * SizeConfig.blockSizeVertical),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        iconSize: 5 * SizeConfig.blockSizeVertical,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        iconSize: 5 * SizeConfig.blockSizeVertical,
                        onPressed: () {
                          print('Delete month');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 4 * SizeConfig.blockSizeVertical,
                left: 6 * SizeConfig.blockSizeHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      globals.months[shifts[0].date.month - 1],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 5 * SizeConfig.blockSizeVertical,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.blockSizeVertical,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 3 * SizeConfig.blockSizeHorizontal),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 4 * SizeConfig.blockSizeVertical,
                          ),
                          SizedBox(
                            width: 3 * SizeConfig.blockSizeHorizontal,
                          ),
                          Text(
                            _year,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 3 * SizeConfig.blockSizeVertical,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: shifts.length,
              itemBuilder: (BuildContext context, int index) {
                Shift shift = shifts[index];

                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 8 * SizeConfig.blockSizeHorizontal,
                          top: 1 * SizeConfig.blockSizeVertical,
                          right: 4 * SizeConfig.blockSizeHorizontal,
                          bottom: 1 * SizeConfig.blockSizeVertical),
                      height: 24 * SizeConfig.blockSizeVertical,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3 * SizeConfig.blockSizeHorizontal),
                        boxShadow: [
                          BoxShadow(
                            color: _monthColor,
                            offset: Offset(0, 10),
                            blurRadius: 5 * SizeConfig.blockSizeHorizontal,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 30 * SizeConfig.blockSizeHorizontal,
                          top: 1 * SizeConfig.blockSizeVertical,
                          bottom: 1 * SizeConfig.blockSizeVertical,
                          right: 4 * SizeConfig.blockSizeHorizontal,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 42 * SizeConfig.blockSizeHorizontal,
                                  child: Text(
                                    shift.title,
                                    style: TextStyle(
                                      fontSize: 2.5 * SizeConfig.blockSizeVertical,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      shift.date.day.toString(),
                                      style: TextStyle(
                                        color: _monthColor,
                                        fontSize: 3.5 * SizeConfig.blockSizeVertical,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      globals.weekdays[shift.date.weekday - 1].substring(0, 3),
                                      style: TextStyle(
                                        color: _monthColor,
                                        fontSize: 2 * SizeConfig.blockSizeVertical,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                            Row(
                              children: [
                                Container(
                                  width: 22 * SizeConfig.blockSizeHorizontal,
                                  height: 4 * SizeConfig.blockSizeVertical,
                                  decoration: shift.numCalls == 0 ? BoxDecoration(
                                    border: Border.all(color: Colors.blue[900]),
                                    borderRadius: BorderRadius.circular(8 * SizeConfig.blockSizeHorizontal),
                                  ) : BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius: BorderRadius.circular(8 * SizeConfig.blockSizeHorizontal),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${shift.numCalls} Calls',
                                    style: TextStyle(
                                      color: shift.numCalls == 0 ? Colors.blue[900] : Colors.white,
                                      fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3 * SizeConfig.blockSizeHorizontal,),
                                Container(
                                  width: 22 * SizeConfig.blockSizeHorizontal,
                                  height: 4 * SizeConfig.blockSizeVertical,
                                  decoration: shift.numTasks == 0 ? BoxDecoration(
                                    border: Border.all(color: Colors.blue[900]),
                                    borderRadius: BorderRadius.circular(8 * SizeConfig.blockSizeHorizontal),
                                  ) : BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius: BorderRadius.circular(8 * SizeConfig.blockSizeHorizontal),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${shift.numTasks} Tasks',
                                    style: TextStyle(
                                      color: shift.numTasks == 0 ? Colors.blue[900] : Colors.white,
                                      fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2 * SizeConfig.blockSizeVertical,),
                            Row(
                              children: [
                                Container(
                                  width: 22 * SizeConfig.blockSizeHorizontal,
                                  height: 4 * SizeConfig.blockSizeVertical,
                                  decoration: BoxDecoration(
                                    color: _conversions.isDay(shift.timeIn) ? Colors.blue[700] : Colors.indigo[900],
                                    borderRadius: BorderRadius.circular(8 * SizeConfig.blockSizeHorizontal),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    shift.timeIn,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3 * SizeConfig.blockSizeHorizontal,),
                                Container(
                                  width: 22 * SizeConfig.blockSizeHorizontal,
                                  height: 4 * SizeConfig.blockSizeVertical,
                                  decoration: BoxDecoration(
                                    color: _conversions.isDay(shift.timeOut) ? Colors.blue[700] : Colors.indigo[900],
                                    borderRadius: BorderRadius.circular(8 * SizeConfig.blockSizeHorizontal),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    shift.timeOut,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 1.8 * SizeConfig.blockSizeVertical,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 4 * SizeConfig.blockSizeHorizontal,
                      top: 1 * SizeConfig.blockSizeVertical,
                      bottom: 1 * SizeConfig.blockSizeVertical,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5 * SizeConfig.blockSizeHorizontal),
                        child: Image(
                          width: 30 * SizeConfig.blockSizeHorizontal,
                          image: NetworkImage(shift.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
