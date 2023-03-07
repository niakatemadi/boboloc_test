import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  String carImage;
  String carBrand;
  String carModel;
  String carRegisterNumber;
  MyListTile(
      {super.key,
      required this.carImage,
      required this.carBrand,
      required this.carModel,
      required this.carRegisterNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: MediaQuery.of(context).size.width - 50,
      margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Row(
        children: [
          Container(
            height: 88,
            width: 129,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                color: Colors.black,
                image: DecorationImage(
                    image: NetworkImage(carImage), fit: BoxFit.fill)),
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
                  carBrand,
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
