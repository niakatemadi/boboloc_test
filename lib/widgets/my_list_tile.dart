import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyListTile extends StatelessWidget {
  String carImage;
  String carName;
  String carRegisterNumber;
  MyListTile(
      {super.key,
      required this.carImage,
      required this.carName,
      required this.carRegisterNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Row(
        children: [
          Container(
            height: 90,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                color: Colors.black,
                image: DecorationImage(
                    image: NetworkImage(carImage), fit: BoxFit.cover)),
          ),
          Container(
            height: 90,
            width: 80,
            child: Column(children: [
              SizedBox(
                height: 5,
              ),
              Text(carName,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(carRegisterNumber)
            ]),
          )
        ],
      ),
    );
  }
}
