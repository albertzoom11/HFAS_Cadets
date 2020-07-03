import 'package:flutter/material.dart';
import 'package:hfascadets/screens/services/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    double sidebarSize = mediaQuery.width * 0.65;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.indigo[900],
            Colors.indigo[800],
            Colors.blue[900],
          ]),
        ),
        width: mediaQuery.width,
        child: Stack(
          children: <Widget>[
            Center(
              child: MaterialButton(
                onPressed: () {},
                color: Colors.white,
                child: Text(
                  'Hello World',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              width: sidebarSize,
              child: Stack(
                children: <Widget>[
                  CustomPaint(
                    size: Size(sidebarSize, mediaQuery.height),
                    painter: DrawerPainter(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    double startWidth = size.width * 0.35 / 0.65;

    Paint paint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(startWidth, 0);
    path.lineTo(startWidth + 2 * size.width, 0);
    path.lineTo(startWidth + 2 * size.width, size.height);
    path.lineTo(startWidth, size.height);
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}