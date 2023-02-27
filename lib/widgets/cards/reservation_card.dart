import 'package:boboloc/models/event.dart';
import 'package:flutter/material.dart';

class ReservationCard extends StatelessWidget {
  final Event event;
  const ReservationCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
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
                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  height: 35,
                  child: Text(
                    "${event.rentStartDay}/${event.rentStartMonth}/${event.rentStartYear}",
                    style: TextStyle(color: Color.fromARGB(255, 163, 163, 163)),
                  ),
                )
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
                    onPressed: () {},
                    icon: const Icon(Icons.file_copy_outlined))
              ],
            ))
      ]),
    );
    ;
  }
}
