import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hfascadets/screens/models/size_config.dart';

class ShiftPage extends StatefulWidget {
  @override
  _ShiftPageState createState() => _ShiftPageState();
}

class _ShiftPageState extends State<ShiftPage> {
  @override
  Widget build(BuildContext context) {
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
              flex: 7,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18 * SizeConfig.blockSizeHorizontal)),
                  color: Colors.white,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4 * SizeConfig.blockSizeVertical, horizontal: 6 * SizeConfig.blockSizeHorizontal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(height: 4 * SizeConfig.blockSizeVertical,),
                        Container(
                          width: 60 * SizeConfig.blockSizeHorizontal,
                          child: Text(
                            'Fiddle Leaf Fig Topiary',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 4 * SizeConfig.blockSizeVertical,
                            ),
                          ),
                        ),
                        Text(
                          '10" Nursery Pot',
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}

