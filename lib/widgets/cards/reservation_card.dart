import 'dart:typed_data';

import 'package:boboloc/database/database.dart';
import 'package:boboloc/models/event.dart';
import 'package:boboloc/utils/my_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ReservationCard extends StatelessWidget {
  final Event event;
  const ReservationCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    void _showAlertDeleteReservation() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.pinkAccent,
              title: const Text('Supppresion de reservation'),
              content: const Text(
                  'Voulez vous vraiment supprimer cette reservation ?'),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      await Database(userId: currentUserId).updateStats(
                          carId: event.carId,
                          rentStartMonth: event.rentStartMonth,
                          rentStartYear: event.rentStartYear,
                          rentCarPrice: event.rentPrice,
                          numberOfRentDays: event.numberOfRentDays);

                      // Je supprime le contrat de la bdd
                      await Database(userId: currentUserId)
                          .deleteContract(contractId: event.contractId);

                      Navigator.pop(context);
                    },
                    child: const Text('Supprimer')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Annuler'))
              ],
            );
          });
    }

    return Container(
      height: 90,
      margin: const EdgeInsets.fromLTRB(0, 6, 0, 4),
      color: Colors.white,
      child: Column(children: [
        SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width - 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 3, 0, 0),
                      child: Text(
                        "${event.renterName} ${event.renterFirstName} ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 3, 0, 0),
                      child: const Text(
                        'ID: 345678',
                        style: TextStyle(
                            color: Color.fromARGB(255, 163, 163, 163)),
                      ))
                ]),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                    height: 35,
                    child: IconButton(
                      onPressed: () async {
                        _showAlertDeleteReservation();
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ))
              ],
            )),
        SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width - 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                  child: Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Début'),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                            "${event.rentStartDay}/${event.rentStartMonth}/${event.rentStartYear}")
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Fin'),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                            "${event.rentEndDay}/${event.rentEndMonth}/${event.rentEndYear}")
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Prix location'),
                        const SizedBox(
                          height: 2,
                        ),
                        Text('${event.rentPrice}€')
                      ],
                    ),
                  ]),
                ),
                IconButton(
                    onPressed: () async {
                      Uint8List? pdfBytes = await FirebaseStorage.instance
                          .refFromURL(event.contractUrl)
                          .getData();

                      MyFunctions().downloadPdf(pdfBytes: pdfBytes);
                    },
                    icon: const Icon(Icons.file_copy_outlined))
              ],
            ))
      ]),
    );
    ;
  }
}
