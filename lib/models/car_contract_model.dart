import 'package:flutter/foundation.dart';

class CarContractModel {
  // renter datas
  String renterName;
  String renterFirstName;
  Uint8List renterIdentityCardRecto;
  Uint8List? renterIdentityCardVerso;
  Uint8List renterLicenseDriverRecto;
  Uint8List? renterLicenseDriverVerso;
  String renterAdresse;
  String renterCity;
  String renterPostalCode;
  String? renterPhoneNumber;
  String? renterEmail;

  int rentStartDay;
  int rentStartMonth;
  int rentStartYear;
  int rentEndDay;
  int rentEndMonth;
  int rentEndYear;
  String numberOfRentDays;
  String rentPrice;
  String rentalDeposit;
  String currentCarKilometer;
  String kilometerAllowed;
  String priceExceedKilometer;

  // Owner datas
  String ownerName;
  String ownerFirstName;
  String ownerAdresse;
  String ownerCompanyName;
  String ownerEmail;
  String ownerPhoneNumber;

  // Car datas
  String carBrand;
  String carModel;
  String carRegistrationNumber;

  CarContractModel(
      {required this.renterName,
      required this.renterFirstName,
      required this.renterAdresse,
      required this.renterCity,
      required this.renterEmail,
      required this.renterIdentityCardRecto,
      this.renterIdentityCardVerso,
      required this.renterLicenseDriverRecto,
      this.renterLicenseDriverVerso,
      required this.renterPhoneNumber,
      required this.renterPostalCode,
      required this.rentEndDay,
      required this.rentEndMonth,
      required this.rentEndYear,
      required this.rentPrice,
      required this.rentStartDay,
      required this.rentStartMonth,
      required this.rentStartYear,
      required this.rentalDeposit,
      required this.numberOfRentDays,
      required this.kilometerAllowed,
      required this.currentCarKilometer,
      required this.priceExceedKilometer,
      required this.ownerAdresse,
      required this.ownerCompanyName,
      required this.ownerEmail,
      required this.ownerFirstName,
      required this.ownerName,
      required this.ownerPhoneNumber,
      required this.carBrand,
      required this.carModel,
      required this.carRegistrationNumber});
}
