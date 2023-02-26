import 'package:boboloc/database/database.dart';
import 'package:boboloc/widgets/my_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
        color: const Color.fromRGBO(243, 243, 255, 0.2),
        child: Column(
          children: [
            Container(
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
                      margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                      height: 50,
                      width: 50,
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
                    return const Center(
                      child: Text("Loading"),
                    );
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
                          carName: cars['car_brand'],
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
        backgroundColor: const Color.fromRGBO(113, 101, 227, 1),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: GNav(
        color: const Color.fromRGBO(133, 133, 133, 1),
        activeColor: const Color.fromRGBO(113, 101, 227, 1),
        gap: 4,
        onTabChange: (index) {
          print(index);
        },
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Accueil',
          ),
          GButton(
            icon: Icons.calendar_month,
            text: 'Calendrier',
          ),
          GButton(
            icon: Icons.bar_chart,
            text: 'Statistiques',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
