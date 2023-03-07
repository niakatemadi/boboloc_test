import 'package:boboloc/constants/colors/colors.dart';
import 'package:boboloc/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Statistiques'),
      ),
      body: Column(
        children: [
          Container(),
          Container(
            child: StreamBuilder(
                stream: Database(userId: currentUserId).getAllStatistics(),
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

                  return Column(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> statistics =
                          document.data() as Map<String, dynamic>;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${statistics['rent_car_price'].toString()} €'),
                          Text(
                              '${statistics['rent_number_days'].toString()} jours')
                        ],
                      );
                    }).toList(),
                  );
                })),
          )
        ],
      ),
    );
  }
}