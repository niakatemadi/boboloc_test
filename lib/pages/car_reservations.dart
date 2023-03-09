import 'package:boboloc/constants/colors/colors.dart';
import 'package:boboloc/database/database.dart';
import 'package:boboloc/models/event.dart';
import 'package:boboloc/utils/clipper.dart';
import 'package:boboloc/widgets/cards/reservation_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CarReservations extends StatefulWidget {
  var carDatas;
  CarReservations({super.key, required this.carDatas});

  @override
  State<CarReservations> createState() => _CarReservationsState();
}

class _CarReservationsState extends State<CarReservations> {
  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Contrats : ${widget.carDatas['car_brand']}',
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(color: MyColors(opacity: 0.8).secondary),
          child: Column(
            children: [
              Stack(children: [
                ClipPath(
                  clipper: SmallWaveClipper(),
                  child: Container(
                    height: 152,
                    decoration:
                        const BoxDecoration(color: Colors.black, boxShadow: [
                      //
                    ]),
                  ),
                ),
                ClipPath(
                  clipper: SmallWaveClipper(),
                  child: Container(
                    height: 150,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Text(widget.carDatas['id_car']),
                  ),
                ),
              ]),
              SizedBox(
                height: MediaQuery.of(context).size.height - 205,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: Database(userId: currentUserId)
                      .getAllCarReservations(idCar: widget.carDatas['id_car']),
                  builder: ((BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.waveDots(
                            color: MyColors(opacity: 1).primary, size: 50),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                        Map<String, dynamic> contract =
                            document.data() as Map<String, dynamic>;

                        return ReservationCard(
                          event: Event(
                              renterName: contract['renter_name'],
                              renterFirstName: contract['renter_firstname'],
                              rentEndDay: contract['rent_end_day'],
                              rentEndMonth: contract['rent_end_month'],
                              rentEndYear: contract['rent_end_year'],
                              rentPrice: contract['rent_price'],
                              rentStartDay: contract['rent_start_day'],
                              rentStartMonth: contract['rent_start_month'],
                              rentStartYear: contract['rent_start_year'],
                              contractId: contract['contract_id'],
                              carId: contract['id_car'],
                              numberOfRentDays: contract['rent_number_days'],
                              contractUrl: contract['contract_url']),
                        );
                      }).toList()),
                    );
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}
