class CarContractModel {
  // renter datas
  String renterName;
  String renterFirstName;
  String renterIdentityCardRecto;
  String? renterIdentityCardVerso;
  String renterLicenseDriverRecto;
  String? renterLicenseDriverVerso;
  String renterAdresse;
  String renterCity;
  String renterPostalCode;
  String? renterPhoneNumber;
  String? renterEmail;

  String rentStartDay;
  String rentEndDay;
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
      required this.rentPrice,
      required this.rentStartDay,
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
