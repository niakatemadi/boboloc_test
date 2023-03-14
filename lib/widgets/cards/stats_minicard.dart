import 'package:boboloc/constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class StatsMiniCard extends StatelessWidget {
  final String myStatValue;
  final int iconIndex;
  StatsMiniCard(
      {super.key, required this.myStatValue, required this.iconIndex});

  final List myIcons = <Widget>[
    const Image(image: AssetImage('assets/icon_euro.png')),
    const Image(image: AssetImage('assets/icon_calendar.png')),
    const Image(image: AssetImage('assets/icon_km.png'))
  ];

  String myEndText({required endTextIndex}) {
    final List myEndTextValues = <String>['€', 'Jours', ''];

    return myEndTextValues[endTextIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors(opacity: 0.13).primary,
      ),
      child: Column(
        children: [
          Container(height: 35, width: 40, child: myIcons[iconIndex]),
          Container(
            height: 35,
            width: 65,
            child: Center(
              child: Text(
                "${myStatValue.toString()} ${myEndText(endTextIndex: iconIndex)} ",
                style: TextStyle(color: MyColors(opacity: 1).primary),
              ),
            ),
          )
        ],
      ),
    );
  }
}
