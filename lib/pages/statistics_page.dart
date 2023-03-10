import 'package:boboloc/constants/colors/colors.dart';
import 'package:boboloc/database/database.dart';
import 'package:boboloc/utils/clipper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  DateTime dateTime = DateTime.now();

  int monthPicked = 0;
  bool isMonthPicked = false;

  int yearPicked = 2023;
  bool isYearPicked = false;

  var total = 0;

  bool isYearAndMonthPicked() {
    bool isYearAndMonthPicked = isMonthPicked && isYearPicked;
    bool isMonthPickedAndYearNotNull = isMonthPicked && initialYear() >= 1;
    bool isYearPickedAndMonthNotNull =
        isYearAndMonthPicked && initialMonth() >= 1;

    bool validator = isYearAndMonthPicked ||
        isYearPickedAndMonthNotNull ||
        isMonthPickedAndYearNotNull;
    return validator;
  }

  int initialMonth() {
    return dateTime.month;
  }

  int initialYear() {
    return dateTime.year;
  }

  var monthsName = [
    '',
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Aout',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre'
  ];

  var itemsMonth = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  var itemsYear = [
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
    '2031',
    '2032',
    '2033',
    '2034',
  ];

  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors(opacity: 1).primary,
        centerTitle: true,
        title: const Text(
          'Statistiques',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Container(
        color: MyColors(opacity: 0.8).secondary,
        child: Column(
          children: [
            ClipPath(
              clipper: SmallWaveClipper(),
              child: Container(
                height: 170,
                color: MyColors(opacity: 1).primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: MyColors(opacity: 1).tertiary,
                                border: Border.all(
                                  color: MyColors(opacity: 0.8).myGrey,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            height: 45,
                            width: 170,
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 30,
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: MyColors(opacity: 0.8).myGrey,
                                  ),
                                ),
                                Text(
                                  'Mois :',
                                  style: TextStyle(
                                      color: MyColors(opacity: 0.8).myGrey),
                                ),
                                Container(
                                  height: 40,
                                  width: 75,
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text(
                                      monthPicked == 0
                                          ? dateTime.month.toString()
                                          : monthPicked.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    items: itemsMonth.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        monthPicked = int.parse(value!);
                                        if (monthPicked >= 1) {
                                          isMonthPicked = true;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )),
                        Container(
                            decoration: BoxDecoration(
                                color: MyColors(opacity: 1).tertiary,
                                border: Border.all(
                                    color: MyColors(opacity: 0.8).myGrey),
                                borderRadius: BorderRadius.circular(5)),
                            height: 45,
                            width: 170,
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 30,
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: MyColors(opacity: 0.8).myGrey,
                                  ),
                                ),
                                Text(
                                  'Année :',
                                  style: TextStyle(
                                      color: MyColors(opacity: 0.8).myGrey),
                                ),
                                Container(
                                  height: 40,
                                  width: 75,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text(yearPicked.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    items: itemsYear.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        print(value!);
                                        yearPicked = int.parse(value);
                                        if (yearPicked >= 2000) {
                                          isYearPicked = true;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Bilan ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                          monthPicked == 0
                              ? monthsName[dateTime.month]
                              : monthsName[monthPicked],
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(yearPicked.toString() ?? dateTime.year.toString(),
                          style: const TextStyle(fontSize: 20))
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    child: StreamBuilder(
                        stream: Database(userId: currentUserId)
                            .getAllStatistics(
                                month: isYearAndMonthPicked() == true
                                    ? monthPicked
                                    : initialMonth(),
                                year: isYearAndMonthPicked() == true
                                    ? yearPicked
                                    : initialYear()),
                        builder: ((BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: LoadingAnimationWidget.waveDots(
                                  color: MyColors(opacity: 1).primary,
                                  size: 50),
                            );
                          }
                          num totalAmount = 0;
                          for (var document in snapshot.data!.docs) {
                            Map<String, dynamic> statistics =
                                document.data() as Map<String, dynamic>;

                            totalAmount =
                                totalAmount + statistics['rent_car_price'];
                          }

                          return Column(
                            children: [
                              const SizedBox(height: 15),
                              Table(
                                border: TableBorder.all(),
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> statistics =
                                      document.data() as Map<String, dynamic>;

                                  return TableRow(children: [
                                    Container(
                                      height: 40,
                                      color: MyColors(opacity: 1).tertiary,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${statistics['rent_car_brand'].toString()} ",
                                              style: const TextStyle(
                                                  fontSize: 15.0),
                                            ),
                                            Text(
                                              " ${statistics['rent_car_model'].toString()} ",
                                              style: const TextStyle(
                                                  fontSize: 13.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 45,
                                      color: MyColors(opacity: 1).tertiary,
                                      child: Center(
                                        child: Text(
                                          "${statistics['rent_number_days'].toString()} jours",
                                          style:
                                              const TextStyle(fontSize: 15.0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 45,
                                      color: MyColors(opacity: 1).tertiary,
                                      child: Center(
                                        child: Text(
                                          "+ ${statistics['rent_car_price'].toString()} €",
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ]);
                                }).toList(),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Center(
                                    child: totalAmount > 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                                color: MyColors(opacity: 1)
                                                    .primary,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            height: 45,
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Total: ",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "+${totalAmount.toString()}€",
                                                    style: const TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Text(
                                            'Pas de statistique pour ce mois')),
                              ),
                            ],
                          );
                        })),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*  return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${statistics['rent_car_price'].toString()} €'),
                          Text(
                              '${statistics['rent_number_days'].toString()} jours')
                        ],
                      );*/