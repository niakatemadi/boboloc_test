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
  String rentPrice;
  String contractUrl;

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
      required this.contractUrl});
}
