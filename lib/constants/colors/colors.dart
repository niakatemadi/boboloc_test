import 'package:flutter/material.dart';

class MyColors {
  double opacity = 1;

  MyColors({required this.opacity});

  get primary {
    // opacity must be 1
    return Color.fromRGBO(113, 101, 227, opacity);
  }

  get secondary {
    // opacity must be 0.8
    return Color.fromRGBO(243, 243, 255, opacity);
  }

  get tertiary {
    return Colors.white;
  }

  get myGrey {
    return Color.fromRGBO(60, 60, 60, opacity);
  }
}
