import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hfascadets/screens/models/size_config.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitRing(
          lineWidth: 1 * SizeConfig.blockSizeHorizontal,
          color: Colors.indigo[900],
          size: 6 * SizeConfig.blockSizeVertical,
        ),
      ),
    );
  }
}