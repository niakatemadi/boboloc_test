import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class BddCarContractModel {
  String idCar;
  int rentStartDay;
  int rentStartMonth;
  int rentStartYear;
  int rentEndDay;
  int rentEndMonth;
  int rentEndYear;
  String renterName;
  String renterFirstName;
  int rentPrice;
  String contractUrl;
  int rentNumberDays;
  String rentCarBrand;
  String rentCarModel;
  String currentCarKilometer;

  BddCarContractModel(
      {required this.idCar,
      required this.rentStartDay,
      required this.rentStartMonth,
      required this.rentStartYear,
      required this.rentEndDay,
      required this.rentEndMonth,
      required this.rentEndYear,
      required this.rentPrice,
      required this.renterFirstName,
      required this.renterName,
      required this.contractUrl,
      required this.rentNumberDays,
      required this.rentCarBrand,
      required this.rentCarModel,
      required this.currentCarKilometer});
}
