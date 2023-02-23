import 'package:boboloc/database/database.dart';
import 'package:boboloc/models/bdd_car_contract_model.dart';
import 'package:boboloc/models/car_contract_model.dart';
import 'package:boboloc/models/user_model.dart';
import 'package:boboloc/utils/my_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';

class ContractFormPage extends StatefulWidget {
  ContractFormPage({super.key, required this.carDatas});
  Map<String, String> carDatas;

  @override
  State<ContractFormPage> createState() => _ContractFormPageState();
}

class _ContractFormPageState extends State<ContractFormPage> {
  String _city = '';
  String _caution = '';
  String _name = '';
  String _firstName = '';
  String _phoneNumber = '';
  String _email = '';
  String _postalCode = '';
  String _adresse = '';
  String _startLocationDate = '';
  String _endLocationDate = '';
  int _daysOfLocation = 0;
  int _price = 0;
  String _currentKilometer = '';
  String _exceedKilometer = '';
  late Uint8List _licenseDriverRecto;
  late Uint8List _licenseDriververso;
  late Uint8List _identityCardRecto;
  late Uint8List _identityCardVerso;
  String _kilometerAllowed = '';

  var _rentEndDay;
  var _rentEndMonth;
  var _rentEndYear;
  var date = DateTime.now();
  var _rentStartDay;
  var _rentStartMonth;
  var _rentStartYear;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String carBrand = widget.carDatas['car_brand']!;
    String carModel = 'modelss';
    String carRegistrationNumber = widget.carDatas['car_registration_number']!;
    String carId = widget.carDatas['id_car']!;
    var currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(title: Text('Contrat de location : $carBrand')),
      body: Form(
          key: _formKey,
          child: Center(
            child: SizedBox(
                width: 300,
                child: SingleChildScrollView(
                  child: Column(children: [
                    const Text(
                      'Informations personnelles',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Nom'),
                      onChanged: (value) {
                        _name = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Entrer un nom";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2030))
                              .then((value) {
                            setState(() {
                              var datePicked = value;
                              _rentStartMonth = datePicked!.month;
                              _rentStartYear = datePicked.year;
                              _rentStartDay = datePicked.day;
                            });
                          });
                        },
                        child: Text('date')),
                    const SizedBox(height: 5),
                    Text('Jour : $_rentStartDay'),
                    Text('Mois : $_rentStartMonth'),
                    Text('Année : $_rentStartYear'),
                    const SizedBox(height: 5),
                    Container(
                      child: ElevatedButton(
                          onPressed: () async {
                            var limitDay = await MyFunctions()
                                .getLimitDay(monthPicked: _rentStartMonth);

                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime(_rentStartYear,
                                        _rentStartMonth, _rentStartDay),
                                    firstDate: DateTime(_rentStartYear,
                                        _rentStartMonth, _rentStartDay),
                                    lastDate: DateTime(_rentStartYear,
                                        _rentStartMonth, limitDay!))
                                .then((value) {
                              setState(() {
                                var datePicked = value;
                                _rentEndMonth = datePicked!.month;
                                _rentEndYear = datePicked.year;
                                _rentEndDay = datePicked.day;
                              });
                            });
                          },
                          child: Text('date fin')),
                    ),
                    Text('Jour : $_rentEndDay'),
                    Text('Mois : $_rentEndMonth'),
                    Text('Année : $_rentEndYear'),
                    TextFormField(
                        decoration: const InputDecoration(hintText: 'Prénom'),
                        onChanged: (value) {
                          _firstName = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer un prénom";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Numéro de téléphone'),
                        onChanged: (value) {
                          _phoneNumber = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer un numéro de téléphone";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    TextFormField(
                        decoration: const InputDecoration(hintText: 'Email'),
                        onChanged: (value) {
                          _email = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer un email";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    TextFormField(
                        decoration: const InputDecoration(hintText: 'Ville'),
                        onChanged: (value) {
                          _city = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer une ville";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'Code postal'),
                        onChanged: (value) {
                          _postalCode = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer un code postal";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    TextFormField(
                        decoration: const InputDecoration(hintText: 'Adresse'),
                        onChanged: (value) {
                          _adresse = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer une adresse";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    const Divider(
                      height: 10,
                      color: Color.fromARGB(255, 26, 91, 213),
                      thickness: 5,
                    ),
                    OutlinedButton(
                        onPressed: () async {
                          Uint8List identityCardRectoPicked =
                              await MyFunctions().pickImageFromgallery();

                          setState(() {
                            _identityCardRecto = identityCardRectoPicked;
                          });
                        },
                        child: const Text("Carte d'identité recto")),
                    OutlinedButton(
                        onPressed: () async {
                          Uint8List identityCardVersoPicked =
                              await MyFunctions().pickImageFromgallery();
                          setState(() {
                            _identityCardVerso = identityCardVersoPicked;
                          });
                        },
                        child: const Text("Carte d'identité verso")),
                    OutlinedButton(
                        onPressed: () async {
                          Uint8List licenseDriverRectoPicked =
                              await MyFunctions().pickImageFromgallery();

                          setState(() {
                            _licenseDriverRecto = licenseDriverRectoPicked;
                          });
                        },
                        child: const Text("Permis de conduire recto")),
                    OutlinedButton(
                        onPressed: () async {
                          Uint8List licenseDriverversoPicked =
                              await MyFunctions().pickImageFromgallery();

                          setState(() {
                            _licenseDriververso = licenseDriverversoPicked;
                          });
                        },
                        child: const Text("Permis de conduire verso")),
                    const Text(
                      'Informations du véhicule',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'jours de location'),
                        onChanged: (value) {
                          _daysOfLocation = int.parse(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer le nombre de jour exact de location";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    TextFormField(
                        decoration: const InputDecoration(hintText: 'Tarif'),
                        onChanged: (value) {
                          _price = int.parse(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer le tarif";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    TextFormField(
                        decoration: const InputDecoration(hintText: 'Caution'),
                        onChanged: (value) {
                          _caution = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer le montant de la caution";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Kilomètres actuel'),
                        onChanged: (value) {
                          _currentKilometer = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer le nombre de kilomètre actuel";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Kilomètres autorisé'),
                        onChanged: (value) {
                          _kilometerAllowed = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer le nombre de kilomètre autorisé";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Prix du kilomètre dépassé'),
                        onChanged: (value) {
                          _exceedKilometer = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer le prix du kilomètre dépassé";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    const Divider(
                        height: 10,
                        color: Color.fromARGB(255, 26, 91, 213),
                        thickness: 5),
                    FutureBuilder(
                      future: Database(userId: currentUserId).getUserDetails(),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            UserModel userDatas = snapshot.data as UserModel;

                            return ElevatedButton(
                                onPressed: () async {
                                  String contractUrl = await MyFunctions()
                                      .generatorPdf(
                                          contractDatas: CarContractModel(
                                              rentEndMonth: _rentEndMonth,
                                              rentEndYear: _rentEndYear,
                                              renterName: _name,
                                              renterFirstName: _firstName,
                                              renterAdresse: _adresse,
                                              renterCity: _city,
                                              renterEmail: _email,
                                              renterIdentityCardRecto:
                                                  _identityCardRecto,
                                              renterIdentityCardVerso:
                                                  _identityCardVerso,
                                              renterLicenseDriverVerso:
                                                  _licenseDriververso,
                                              renterLicenseDriverRecto:
                                                  _licenseDriverRecto,
                                              renterPhoneNumber: _phoneNumber,
                                              renterPostalCode: _postalCode,
                                              rentEndDay: _rentEndDay,
                                              rentPrice: _price,
                                              rentStartDay: _rentStartDay,
                                              rentStartMonth: _rentStartMonth,
                                              rentStartYear: _rentStartYear,
                                              rentalDeposit: _caution,
                                              numberOfRentDays: _daysOfLocation,
                                              kilometerAllowed:
                                                  _kilometerAllowed,
                                              currentCarKilometer:
                                                  _currentKilometer,
                                              priceExceedKilometer:
                                                  _exceedKilometer,
                                              ownerAdresse: userDatas.adresse,
                                              ownerCompanyName:
                                                  userDatas.companyName,
                                              ownerEmail: userDatas.email,
                                              ownerFirstName:
                                                  userDatas.firstName,
                                              ownerName: userDatas.name,
                                              ownerPhoneNumber:
                                                  '07 00 00 00 00',
                                              carBrand: carBrand,
                                              carModel: carModel,
                                              carRegistrationNumber:
                                                  carRegistrationNumber));

                                  await Database(userId: currentUserId)
                                      .addNewContractToFirestore(
                                          bddCarContractModel:
                                              BddCarContractModel(
                                                  idCar: carId,
                                                  rentStartDay: _rentStartDay,
                                                  rentStartMonth:
                                                      _rentStartMonth,
                                                  rentStartYear: _rentStartYear,
                                                  rentEndDay: _rentEndDay,
                                                  rentEndMonth: _rentEndMonth,
                                                  rentEndYear: _rentEndYear,
                                                  rentPrice: _price,
                                                  renterName: _name,
                                                  renterFirstName: _firstName,
                                                  contractUrl: contractUrl,
                                                  rentNumberDays:
                                                      _daysOfLocation));
                                },
                                child: const Text('Générer le contrat'));
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(snapshot.hasError.toString()));
                          } else {
                            return const Center(
                                child: Text('Something went wrong !'));
                          }
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                    )
                  ]),
                )),
          )),
    );
  }
}
