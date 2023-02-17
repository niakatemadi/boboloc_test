import 'package:boboloc/models/car_model.dart';
import 'package:boboloc/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypt/crypt.dart';

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
