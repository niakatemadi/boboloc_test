class Event {
  String renterName;
  String renterFirstName;
  int rentStartDay;
  int rentStartMonth;
  int rentStartYear;
  int rentEndDay;
  int rentEndMonth;
  int rentEndYear;
  int rentPrice;
  int numberOfRentDays;
  String contractId;
  String carId;
  String contractUrl;
  String currentKilometer;

  Event(
      {required this.renterName,
      required this.renterFirstName,
      required this.rentEndDay,
      required this.rentEndMonth,
      required this.rentEndYear,
      required this.rentPrice,
      required this.rentStartDay,
      required this.rentStartMonth,
      required this.rentStartYear,
      required this.contractId,
      required this.carId,
      required this.numberOfRentDays,
      required this.contractUrl,
      required this.currentKilometer});
}
