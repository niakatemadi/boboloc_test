import 'package:boboloc/constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    //debut
    void _ShowAlertSignUpSucceed() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: MyColors(opacity: 1).tertiary,
              title: const Text(
                'Suppresion',
                textAlign: TextAlign.center,
              ),
              content: const Text(
                'Voulez vous vraiment supprimer ce véhicule ?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 20),
              ),
              actions: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  MyColors(opacity: 1).primary)),
                          onPressed: () async {
                            print('Voiture supprimé !');
                          },
                          child: const Text('Oui')),
                    ),
                  ],
                ),
              ],
            );
          });
    }

    //fin
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
            width: 100,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                color: MyColors(opacity: 1).primary,
                image: DecorationImage(
                    image: NetworkImage(carImage), fit: BoxFit.fill)),
          ),
          Container(
            height: 88,
            width: 200,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Text(
                      carBrand,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      carModel,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  carRegisterNumber,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 104, 104, 104)),
                ),
              )
            ]),
          ),
          Container(
            height: 50,
            width: 30,
            color: Colors.red,
            child: IconButton(
                onPressed: () {
                  _ShowAlertSignUpSucceed();
                },
                icon: Icon(Icons.more_vert)),
          )
        ],
      ),
    );
  }
}
