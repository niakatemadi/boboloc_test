import 'dart:core';
import 'package:boboloc/models/bdd_car_contract_model.dart';
import 'package:boboloc/models/car_model.dart';
import 'package:boboloc/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  updateCarStats(
      {required statsDocumentId,
      required int newRentNumberDays,
      required int currentRentNumberDays}) {
    int rentNumberDays = currentRentNumberDays + newRentNumberDays;

    print('new total number days : $rentNumberDays');
    db
        .collection("statistique")
        .doc(userId)
        .collection(userId)
        .doc(statsDocumentId)
        .update({
      'rent_number_days': rentNumberDays,
    });
  }

  addCarStats(
      {required String idCar,
      required int rentStartMonth,
      required int rentStartYear,
      required int rentNumberDays}) {
    db.collection("statistique").doc(userId).collection(userId).add({
      'id_car': idCar,
      'rent_start_month': rentStartMonth,
      'rent_start_year': rentStartYear,
      'rent_number_days': rentNumberDays
    }).then((DocumentReference doc) =>
        print('Statistique added with ID: ${doc.id}'));
  }

  Future addOrUpdateCarMonthStats(
      {required int rentStartMonth,
      required int rentStartYear,
      required String idCar,
      required int rentNumberDays}) async {
    final carMonthStats = await FirebaseFirestore.instance
        .collection('statistique')
        .doc(userId)
        .collection(userId)
        .where('id_car', isEqualTo: idCar)
        .where('rent_start_month', isEqualTo: rentStartMonth)
        .where('rent_start_year', isEqualTo: rentStartYear)
        .get();

    if (carMonthStats.size == 1) {
      print('on a bien un document pour ce mois, annee et idcar');
      print('ce document existe déja');
      int currentRentNumberDays = carMonthStats.docs[0]['rent_number_days'];
      print('current rent number days : $currentRentNumberDays');
      for (var documentSnapshot in carMonthStats.docs) {
        String documentId = documentSnapshot.id;
        print("La clé du document est : $documentId");
        updateCarStats(
            statsDocumentId: documentId,
            newRentNumberDays: rentNumberDays,
            currentRentNumberDays: currentRentNumberDays);
      }
    } else {
      print('Ce document existe pas encore');
      addCarStats(
          idCar: idCar,
          rentStartMonth: rentStartMonth,
          rentStartYear: rentStartYear,
          rentNumberDays: rentNumberDays);
    }
  }

  addNewContractToFirestore(
      {required BddCarContractModel bddCarContractModel}) async {
    print('mmmaaaddii');
    await db.collection("contracts").doc(userId).collection(userId).add({
      'id_car': bddCarContractModel.idCar,
      'rent_number_days': bddCarContractModel.rentNumberDays,
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

    await addOrUpdateCarMonthStats(
        rentStartMonth: bddCarContractModel.rentStartMonth,
        rentStartYear: bddCarContractModel.rentStartYear,
        idCar: bddCarContractModel.idCar,
        rentNumberDays: bddCarContractModel.rentNumberDays);
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
