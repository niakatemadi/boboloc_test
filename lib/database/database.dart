import 'dart:io';
import 'dart:math';

import 'package:boboloc/models/bdd_car_contract_model.dart';
import 'package:boboloc/models/car_contract_model.dart';
import 'package:boboloc/models/car_model.dart';
import 'package:boboloc/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Database {
  String userId;
  Database({required this.userId});

  FirebaseFirestore db = FirebaseFirestore.instance;

  addNewCar(NewCar newCar) {
    db.collection("cars").doc(userId).collection(userId).add({
      'car_brand': newCar.carBrand,
      'car_kilometer': newCar.currentCarKilometer,
      'car_picture': newCar.carPicture,
      'car_registration_number': newCar.carRegistrationNumber
    }).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  addNewContractToFirestore(
      {required BddCarContractModel bddCarContractModel}) {
    print('mmmaaaddii');
    db.collection("contracts").doc(userId).collection(userId).add({
      'id_car': bddCarContractModel.idCar,
      'rent_start_day': bddCarContractModel.rentStartDay,
      'rent_start_month': bddCarContractModel.rentStartMonth,
      'rent_start_year': bddCarContractModel.rentStartYear,
      'rent_end_day': bddCarContractModel.rentEndDay,
      'rent_end_month': bddCarContractModel.rentEndMonth,
      'rent_end_year': bddCarContractModel.rentEndYear,
      'renter_name': bddCarContractModel.renterName,
      'renter_firstname': bddCarContractModel.renterFirstName,
      'rent_price': bddCarContractModel.rentPrice,
      'contract_url': bddCarContractModel.contractUrl,
      'created_at': DateTime.now()
    }).then((DocumentReference doc) =>
        print('DocumentSnapshot contract added with ID: ${doc.id}'));
  }

  Future getUserDetails() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();

    final userDatas =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userDatas;
  }

  Stream<QuerySnapshot> get getUserCars {
    return FirebaseFirestore.instance
        .collection('cars')
        .doc(userId)
        .collection(userId)
        .snapshots();
  }
}
