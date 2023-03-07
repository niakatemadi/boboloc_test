import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String name;
  String firstName;
  String companyName;
  String password;
  String email;
  String city;
  String adresse;
  String? subscribmentId;
  String subscribmentStatus;

  UserModel(
      {required this.name,
      required this.firstName,
      required this.companyName,
      required this.password,
      required this.city,
      required this.email,
      required this.adresse,
      this.uid,
      this.subscribmentId,
      required this.subscribmentStatus});

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return UserModel(
        name: data['name'],
        firstName: data["firstName"],
        companyName: data["company_name"],
        password: data["password"],
        city: data["city"],
        email: data["mail"],
        adresse: data["adresse"],
        uid: document.id,
        subscribmentId: data["subscribment_id"],
        subscribmentStatus: data["subscribment_status"]);
  }
}
