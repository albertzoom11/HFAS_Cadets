import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/size_config.dart';

class TaskDisplay extends StatefulWidget {
  final String task;
  final int taskNum;
  final bool editable;

  TaskDisplay({this.task, this.taskNum, this.editable});

  @override
  _TaskDisplayState createState() => _TaskDisplayState();
}

class _TaskDisplayState extends State<TaskDisplay> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(left: 8 * SizeConfig.blockSizeHorizontal, bottom: 3 * SizeConfig.blockSizeVertical),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8 * SizeConfig.blockSizeHorizontal), bottomLeft: Radius.circular(8 * SizeConfig.blockSizeHorizontal)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6 * SizeConfig.blockSizeHorizontal, vertical: 2 * SizeConfig.blockSizeVertical),
          child: Row(
            children: [
              Text(
                widget.taskNum.toString(),
                style: TextStyle(
                  fontSize: 3 * SizeConfig.blockSizeVertical,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: 5 * SizeConfig.blockSizeHorizontal,),
              Container(
                width: 60 * SizeConfig.blockSizeHorizontal,
                child: Text(
                  widget.task,
                  style: TextStyle(
                    fontSize: 2 * SizeConfig.blockSizeVertical,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

