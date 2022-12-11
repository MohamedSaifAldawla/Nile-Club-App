import 'package:flutter/material.dart';

import '../theme.dart';

Stack waveClipper() {
  return Stack(
    children: [
      Opacity(
        opacity: 0.5,
        child: ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 140,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor,
                  blurRadius: 20.2,
                  offset: Offset(0, 10),
                ),
              ],
            ),
          ),
        ),
      ),
      ClipPath(
        clipper: WaveClipper(),
        child: Container(
          color: kPrimaryColor,
          height: 130,
        ),
      ),
    ],
  );
}

Stack waveClipper2() {
  return Stack(
    children: [
      Opacity(
        opacity: 0.5,
        child: ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor,
                  blurRadius: 20.2,
                  offset: Offset(0, 10),
                ),
              ],
            ),
          ),
        ),
      ),
      ClipPath(
        clipper: WaveClipper(),
        child: Container(
          color: kPrimaryColor,
          height: 70,
        ),
      ),
    ],
  );
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());

    var path = new Path();

    path.lineTo(0, size.height);
    //first point of qudratic bezier curve
    var firstStart = Offset(size.width / 5, size.height);
    //Second point of qudratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    //Third point of qudratic bezier curve
    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //Fourth point of qudratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    // throw UnimplementedError();
    return false;
  }
}
