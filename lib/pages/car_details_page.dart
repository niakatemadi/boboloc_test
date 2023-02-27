import 'package:boboloc/constants/colors/colors.dart';
import 'package:boboloc/database/database.dart';
import 'package:boboloc/utils/clipper.dart';
import 'package:boboloc/utils/my_functions.dart';
import 'package:boboloc/widgets/cards/stats_minicard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:month_year_picker/month_year_picker.dart';

class CarDetailsPage extends StatefulWidget {
  Map<String, String> carDatas;
  CarDetailsPage({super.key, required this.carDatas});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  DateTime dateTime = DateTime.now();

  int monthPicked = 2;
  bool isMonthPicked = false;
  int yearPicked = 2023;

  bool isYearPicked = false;

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
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        leading: IconButton(
            onPressed: () => context.go('/navigation_page'),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 430,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: MyColors(opacity: 1).primary,
                  image: DecorationImage(
                      image: NetworkImage(
                        widget.carDatas['car_picture']!,
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 50,
            child: Column(children: [
              Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.carDatas['car_brand'].toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          widget.carDatas['car_registration_number'].toString(),
                          style: const TextStyle(fontSize: 15)),
                    ],
                  )),
              const SizedBox(
                height: 25,
              ),
              Form(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
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
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(
                                    monthPicked.toString(),
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
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                ]),
              ),
              const SizedBox(
                height: 35,
              ),
              StreamBuilder(
                  stream: Database(userId: currentUserId).getCarStatistics(
                      idCar: widget.carDatas['id_car']!,
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

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text("Loading"),
                      );
                    }

                    return Container(
                        child: Column(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> carStatistics =
                            document.data() as Map<String, dynamic>;

                        return Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatsMiniCard(
                                myStatValue:
                                    carStatistics['rent_car_price'].toString(),
                                iconIndex: 0),
                            StatsMiniCard(
                                myStatValue: carStatistics['rent_number_days']
                                    .toString(),
                                iconIndex: 1),
                            StatsMiniCard(
                                myStatValue: carStatistics['rent_number_days']
                                    .toString(),
                                iconIndex: 2)
                          ],
                        ));
                      }).toList(),
                    ));
                  })),
              const SizedBox(height: 25),
              const Divider(thickness: 1),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 45,
                      width: 90,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: MyColors(opacity: 1).primary),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Image(
                          image:
                              AssetImage('assets/icon_calendar_regular.png')),
                    ),
                    Container(
                      height: 45,
                      width: 213,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  MyColors(opacity: 1).primary)),
                          onPressed: () {
                            return context.goNamed("car_contract_form",
                                queryParams: widget.carDatas);
                          },
                          child: const Text('Créer un contrat')),
                    )
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
