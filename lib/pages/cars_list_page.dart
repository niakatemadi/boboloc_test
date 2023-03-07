import 'package:boboloc/constants/colors/colors.dart';
import 'package:boboloc/database/database.dart';
import 'package:boboloc/widgets/my_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CarsListPage extends StatefulWidget {
  CarsListPage({super.key});

  @override
  State<CarsListPage> createState() => _CarsListPageState();
}

class _CarsListPageState extends State<CarsListPage> {
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors(opacity: 0.8).secondary,
        child: Column(
          children: [
            SizedBox(
              height: 130,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      height: 50,
                      width: 110,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Bienvenue,',
                          ),
                          Text(
                            'Company_name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                      height: 60,
                      width: 60,
                      child: const Image(
                        image: AssetImage('assets/logo_boboloc.png'),
                        fit: BoxFit.cover,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 205,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: Database(userId: currentUserId).getUserCars,
                builder: ((BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: LoadingAnimationWidget.waveDots(
                            color: MyColors(opacity: 1).primary, size: 50));
                  }

                  return SingleChildScrollView(
                    child: Column(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                      Map<String, dynamic> cars =
                          document.data() as Map<String, dynamic>;

                      return GestureDetector(
                        child: MyListTile(
                          carImage: cars['car_picture'],
                          carBrand: cars['car_brand'],
                          carModel: cars['car_model'],
                          carRegisterNumber: cars['car_registration_number'],
                        ),
                        onTap: () {
                          return context.goNamed("car_details",
                              queryParams: cars);
                        },
                      );
                    }).toList()),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: MyColors(opacity: 1).primary,
        onPressed: () async {
          var currentUserDetails =
              await Database(userId: currentUserId).getUserDetails();

          if (currentUserDetails.subscribmentStatus == 'gold') {
            context.go('/add_new_car');

            return;
          }

          var carsNumber =
              await Database(userId: currentUserId).getCarsNumber();
          if ((currentUserDetails.subscribmentStatus == 'silver' &&
                  carsNumber < 5) ||
              (currentUserDetails.subscribmentStatus == "free" &&
                  carsNumber < 1)) {
            context.go('/add_new_car');

            return;
          } else {
            context.go("/subscribment_page");
          }

          print(currentUserDetails.subscribmentStatus);
          //context.go('/add_new_car');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
