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
      height: 88,
      width: MediaQuery.of(context).size.width - 50,
      margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Row(
        children: [
          Container(
            height: 88,
            width: 129,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage('assets/car1_list.png'),
                    fit: BoxFit.fill)),
          ),
          Container(
            height: 88,
            width: 80,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  carName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Text(
                  carRegisterNumber,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
