import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());

    var path = Path();
    path.lineTo(0, size.height);

    var firstStart = Offset(size.width / 25, size.height - 42);
    var firstEnd = Offset(size.width / 8, size.height - 42);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    path.lineTo(size.width - size.width / 6, size.height - 42);

    var secondStart = Offset(size.width, size.height - 50);
    var secondEnd = Offset(size.width, size.height - 100);

    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
    throw UnimplementedError();
  }
}

class WaveClipperSignUp extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());

    var path = Path();
    path.lineTo(0, size.height);

    var firstStart = Offset(size.width / 20, size.height - 20);
    var firstEnd = Offset(size.width / 9, size.height - 20);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    path.lineTo(size.width - size.width / 6, size.height - 20);

    var secondStart = Offset(size.width, size.height - 22);
    var secondEnd = Offset(size.width, size.height - 60);

    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
    throw UnimplementedError();
  }
}
