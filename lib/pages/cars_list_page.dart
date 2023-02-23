import 'package:boboloc/database/database.dart';
import 'package:boboloc/widgets/my_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 1, 1, 0),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 175,
            color: Color.fromARGB(255, 227, 228, 230),
          ),
          Container(
            color: Color.fromARGB(255, 227, 228, 230),
            height: 450,
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
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
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
      bottomNavigationBar: FloatingActionButton(
        onPressed: () => context.go('/calendar_page'),
        child: Icon(Icons.plus_one),
      ),
    );
  }
}
