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
      'car_registration_number': newCar.carRegistrationNumber,
      'id_car': newCar.carId
    }).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  updateCarStats(
      {required statsDocumentId,
      required int newRentNumberDays,
      required int currentRentNumberDays,
      required int currentRentTotalPrice,
      required int newRentPrice}) {
    // currentRentTotalPrice is the actual total price of rent in bdd
    // newRentPrice is the new price added to the actual total price of the bdd
    int rentTotalNumberDays = currentRentNumberDays + newRentNumberDays;
    int rentCarTotalPrice = currentRentTotalPrice + newRentPrice;

    db
        .collection("statistique")
        .doc(userId)
        .collection(userId)
        .doc(statsDocumentId)
        .update({
      'rent_number_days': rentTotalNumberDays,
      'rent_car_price': rentCarTotalPrice
    });
  }

  addCarStats(
      {required String idCar,
      required int rentStartMonth,
      required int rentStartYear,
      required int rentNumberDays,
      required int rentCarPrice}) {
    db.collection("statistique").doc(userId).collection(userId).add({
      'id_car': idCar,
      'rent_start_month': rentStartMonth,
      'rent_start_year': rentStartYear,
      'rent_number_days': rentNumberDays,
      'rent_car_price': rentCarPrice
    }).then((DocumentReference doc) =>
        print('Statistique added with ID: ${doc.id}'));
  }

  Future triggerAddOrUpdateCarMonthStats(
      {required int rentStartMonth,
      required int rentStartYear,
      required String idCar,
      required int rentNumberDays,
      required int rentCarPrice}) async {
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
      int currentRentTotalPrice = carMonthStats.docs[0]['rent_car_price'];
      print('$currentRentTotalPrice');
      print('current rent number days : $currentRentNumberDays');
      for (var documentSnapshot in carMonthStats.docs) {
        String documentId = documentSnapshot.id;
        print("La clé du document est : $documentId");
        updateCarStats(
            statsDocumentId: documentId,
            newRentNumberDays: rentNumberDays,
            currentRentNumberDays: currentRentNumberDays,
            currentRentTotalPrice: currentRentTotalPrice,
            newRentPrice: rentCarPrice);
      }
    } else {
      print('Ce document existe pas encore');
      addCarStats(
          idCar: idCar,
          rentStartMonth: rentStartMonth,
          rentStartYear: rentStartYear,
          rentNumberDays: rentNumberDays,
          rentCarPrice: rentCarPrice);
    }
  }

  addNewContractToFirestore(
      {required BddCarContractModel bddCarContractModel}) async {
    print('mmmaaaddii');
    await db.collection("contracts").doc(userId).collection(userId).add({
      'id_car': bddCarContractModel.idCar,
      'user_id': userId,
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
      'created_at': DateTime.now(),
    }).then((DocumentReference doc) {
      // Je récupère l'id du document et je créer un nouveau champ 'contract_id' dans
      // le document pour l'insérer
      db
          .collection('contracts')
          .doc(userId)
          .collection(userId)
          .doc(doc.id)
          .update({'contract_id': doc.id});
      print('DocumentSnapshot contract added with ID: ${doc.id}');
    });

    await triggerAddOrUpdateCarMonthStats(
        rentStartMonth: bddCarContractModel.rentStartMonth,
        rentStartYear: bddCarContractModel.rentStartYear,
        idCar: bddCarContractModel.idCar,
        rentNumberDays: bddCarContractModel.rentNumberDays,
        rentCarPrice: bddCarContractModel.rentPrice);
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

  Future getCarsNumber() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('cars')
        .doc(userId)
        .collection(userId)
        .get();

    var length = snapshot.docs.length;

    return length;
  }

  Stream<QuerySnapshot> get getUserCars {
    return FirebaseFirestore.instance
        .collection('cars')
        .doc(userId)
        .collection(userId)
        .snapshots();
  }

  Stream<QuerySnapshot> get getMyReservations {
    return FirebaseFirestore.instance
        .collection('contracts')
        .doc(userId)
        .collection(userId)
        .snapshots();
  }

// return statistics of a car based on month, year and car id
  getCarStatistics(
      {required String idCar, required int month, required int year}) {
    return FirebaseFirestore.instance
        .collection('statistique')
        .doc(userId)
        .collection(userId)
        .where('id_car', isEqualTo: idCar)
        .where('rent_start_month', isEqualTo: month)
        .where('rent_start_year', isEqualTo: year)
        .snapshots();
  }

  // return all reservations of a specific car

  getAllCarReservations({idCar}) {
    return FirebaseFirestore.instance
        .collection('contracts')
        .doc(userId)
        .collection(userId)
        .where('id_car', isEqualTo: idCar)
        .snapshots();
  }

  // return all statistics of a specific user

  getAllStatistics() {
    return FirebaseFirestore.instance
        .collection('statistique')
        .doc(userId)
        .collection(userId)
        .snapshots();
  }

// delete a specific reservation by his id

  deleteContract({contractId}) {
    print('contract : $contractId deleted');
    FirebaseFirestore.instance
        .collection('contracts')
        .doc(userId)
        .collection(userId)
        .doc(contractId)
        .delete();
  }

//Cette fonction permet de mettre à jour le document statistique qui contient le prix et
// le nbre de jrs de location de ce contrat
// En gros ça remet la stats à jour en ne prenant plus en compte ce contrat
  updateStats(
      {carId,
      rentStartMonth,
      rentStartYear,
      rentCarPrice,
      numberOfRentDays}) async {
    // Je récupère le document statistique qui contient les données du
    // contrat que je m'apprete à supprimer
    var statistiquePicked = await db
        .collection('statistique')
        .doc(userId)
        .collection(userId)
        .where('id_car', isEqualTo: carId)
        .where('rent_start_month', isEqualTo: rentStartMonth)
        .where('rent_start_year', isEqualTo: rentStartYear)
        .get();
    // Je stocke la ref du document statistique que j'ai récupérer
    var statsPickedRef = statistiquePicked.docs.first.reference;

    // Je stocke le prix et nombre de jours de location du document statistique que
    //j'ai récupérer
    int statsPickedTotalPrice =
        statistiquePicked.docs[0].data()['rent_car_price'];
    int statsPickedTotalRentDays =
        statistiquePicked.docs[0].data()['rent_number_days'];
    print(statsPickedTotalPrice);

    // Je retire le prix et le nombre de jours de location du contrat que je m'apprete
    // à supprimer au document statistique qui le contient
    var newStatsPrice = statsPickedTotalPrice - rentCarPrice;
    var newTotalRentDays = statsPickedTotalRentDays - numberOfRentDays;
// Je met à jour avec les nouvelles données
    statsPickedRef.update({'rent_car_price': newStatsPrice});
    statsPickedRef.update({'rent_number_days': newTotalRentDays});
  }
}
