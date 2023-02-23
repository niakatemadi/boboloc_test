import 'package:boboloc/database/database.dart';
import 'package:boboloc/models/event.dart';
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
      body: Column(children: [
        StreamBuilder(
            stream: Database(userId: currentUserId).getMyReservations,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                  DateTime date = DateTime.utc(contract['rent_start_year'],
                      contract['rent_start_month'], contract['rent_start_day']);

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

              return Column(
                children: [
                  TableCalendar(
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
                  const SizedBox(height: 10),
                  Container(
                    height: 280,
                    child: ValueListenableBuilder<List<Event>>(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: false,
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  width: 150,
                                  height: 50,
                                  margin: EdgeInsets.all(4),
                                  decoration:
                                      BoxDecoration(color: Colors.green),
                                  child: Column(
                                    children: [
                                      Text('Nom :${value[index].renterName}'),
                                      Text(
                                          'Prénom :${value[index].renterFirstName}'),
                                      Text(
                                          'Mois :${value[index].renterFirstName}')
                                    ],
                                  ));
                            });
                      },
                    ),
                  )
                ],
              );
            })
      ]),
    );
  }
}
