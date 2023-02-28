import 'package:boboloc/constants/colors/colors.dart';
import 'package:boboloc/database/database.dart';
import 'package:boboloc/models/event.dart';
import 'package:boboloc/widgets/cards/reservation_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: MyColors(opacity: 0.8).secondary),
        child: Column(children: [
          StreamBuilder(
              stream: Database(userId: currentUserId).getMyReservations,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text("Loading"),
                  );
                }

                Map<DateTime, List<Event>> dataStuctured() {
                  Map<DateTime, List<Event>> events = {};

                  snapshot.data!.docs.forEach((document) {
                    Map<String, dynamic> contract =
                        document.data() as Map<String, dynamic>;

                    DateTime date = DateTime.utc(
                        contract['rent_start_year'],
                        contract['rent_start_month'],
                        contract['rent_start_day']);

                    if (events.containsKey(date)) {
                      events[date]!.add(Event(
                          renterName: contract['renter_name'],
                          renterFirstName: contract['renter_firstname'],
                          rentEndDay: contract['rent_end_day'],
                          rentEndMonth: contract['rent_end_month'],
                          rentEndYear: contract['rent_end_year'],
                          rentPrice: contract['rent_price'],
                          rentStartDay: contract['rent_start_day'],
                          rentStartMonth: contract['rent_start_month'],
                          rentStartYear: contract['rent_start_year']));
                    } else {
                      events[date] = [];
                      events[date]!.add(Event(
                          renterName: contract['renter_name'],
                          renterFirstName: contract['renter_firstname'],
                          rentEndDay: contract['rent_end_day'],
                          rentEndMonth: contract['rent_end_month'],
                          rentEndYear: contract['rent_end_year'],
                          rentPrice: contract['rent_price'],
                          rentStartDay: contract['rent_start_day'],
                          rentStartMonth: contract['rent_start_month'],
                          rentStartYear: contract['rent_start_year']));
                    }
                  });

                  return events;
                }

                List<Event> getEventsForDay(DateTime day) {
                  Map<DateTime, List<Event>> events = dataStuctured();

                  return events[day] ?? [];
                }

                void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                    });

                    var datas = dataStuctured();
                    print('ngngn');
                    print(datas);

                    _selectedEvents.value = datas[selectedDay] ?? [];
                  }
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 20,
                        margin: const EdgeInsets.fromLTRB(20, 34, 0, 0),
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          'Calendrier',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration:
                            BoxDecoration(color: MyColors(opacity: 1).tertiary),
                        child: TableCalendar(
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: _focusedDay,
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: onDaySelected,
                          calendarFormat: CalendarFormat.month,
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                          eventLoader: (day) {
                            return getEventsForDay(day);
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          'Reservations',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 169,
                        width: MediaQuery.of(context).size.width - 40,
                        child: ValueListenableBuilder<List<Event>>(
                          valueListenable: _selectedEvents,
                          builder: (context, value, _) {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: false,
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  return ReservationCard(
                                    event: Event(
                                        renterName: value[index].renterName,
                                        renterFirstName:
                                            value[index].renterFirstName,
                                        rentEndDay: value[index].rentEndDay,
                                        rentEndMonth: value[index].rentEndMonth,
                                        rentEndYear: value[index].rentEndYear,
                                        rentPrice: value[index].rentPrice,
                                        rentStartDay: value[index].rentStartDay,
                                        rentStartMonth:
                                            value[index].rentStartMonth,
                                        rentStartYear:
                                            value[index].rentStartYear),
                                  );
                                });
                          },
                        ),
                      )
                    ],
                  ),
                );
              })
        ]),
      ),
    );
  }
}
