import 'package:boboloc/constants/colors/colors.dart';
import 'package:boboloc/database/database.dart';
import 'package:boboloc/models/bdd_car_contract_model.dart';
import 'package:boboloc/models/car_contract_model.dart';
import 'package:boboloc/models/user_model.dart';
import 'package:boboloc/utils/my_functions.dart';
import 'package:boboloc/widgets/input/form_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:signature/signature.dart';

class ContractFormPage extends StatefulWidget {
  ContractFormPage({super.key, required this.carDatas});
  Map<String, String> carDatas;

  @override
  State<ContractFormPage> createState() => _ContractFormPageState();
}

class _ContractFormPageState extends State<ContractFormPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
  late Uint8List _fieldCarCheck1;
  late Uint8List _fieldCarCheck2;
  Uint8List? _fieldCarCheck3;
  Uint8List? _fieldCarCheck4;
  Uint8List? _fieldCarCheck5;
  String _kilometerAllowed = '';

  var _rentEndDay = 0;
  var _rentEndMonth = 0;
  var _rentEndYear = 0;
  var date = DateTime.now();
  var _rentStartDay = 0;
  var _rentStartMonth = 0;
  var _rentStartYear = 0;

  //test
  var pseudo;
  bool isFieldEmpty = false;
  bool _isFieldNameEmpty = false;
  bool _isFieldFirstnameEmpty = false;
  bool _isFieldEmailEmpty = false;
  bool _isFieldAdresseEmpty = false;
  bool _isFieldExceedKilometerEmpty = false;
  bool _isFieldPhoneNumberEmpty = false;
  bool _isFieldKilometerAllowedEmpty = false;
  bool _isFieldCityEmpty = false;
  bool _isFieldCurrentKilometerEmpty = false;
  bool _isFieldPostalCodeEmpty = false;
  bool _isFieldDaysOfLocationEmpty = false;
  bool _isFieldDepositEmpty = false;
  bool _isFieldPriceEmpty = false;
  bool _isFieldLicenseDriveRectoEmpty = false;
  bool _isFieldLicenseDriveVersoEmpty = false;
  bool _isFieldIdentityCardRectoEmpty = false;
  bool _isFieldIdentityCardVersoEmpty = false;
  bool _isFieldCarCheck1Empty = false;
  bool _isFieldCarCheck2Empty = false;
  bool _isFieldCarCheck3Empty = false;
  bool _isFieldCarCheck4Empty = false;
  bool _isFieldCarCheck5Empty = false;
  // signature

  late Uint8List renterSignature;
  late Uint8List ownerSignature;

  final SignatureController renterSignatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  final SignatureController ownerSignatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
// debut
  void _ShowAlertContractCreated() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: MyColors(opacity: 1).tertiary,
            title: const Text(
              '',
              textAlign: TextAlign.center,
            ),
            content: const Text(
              'Contrat crée avec succès !',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            actions: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                MyColors(opacity: 1).primary)),
                        onPressed: () async {
                          context.go('/navigation_page');
                        },
                        child: const Text('Ok')),
                  ),
                ],
              ),
            ],
          );
        });
  }

  //fin

  @override
  Widget build(BuildContext context) {
    String carBrand = widget.carDatas['car_brand']!;
    String carModel = widget.carDatas['car_model']!;
    String carRegistrationNumber = widget.carDatas['car_registration_number']!;
    String carId = widget.carDatas['id_car']!;
    var currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColors(opacity: 1).primary,
          title: Text('Location : $carBrand $carModel')),
      body: Container(
        decoration: BoxDecoration(
          color: MyColors(opacity: 0.8).secondary,
        ),
        child: Form(
            key: formKey,
            child: Center(
              child: SizedBox(
                  width: 300,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Informations du véhicule',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Départ:'), Text('Arrivé:')],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 45,
                              width: 140,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              MyColors(opacity: 1).primary)),
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(Icons.calendar_month),
                                      const SizedBox(
                                        width: 5,
                                        height: 20,
                                      ),
                                      Text(
                                          "$_rentStartDay/$_rentStartMonth/$_rentStartYear")
                                    ],
                                  )),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              height: 45,
                              width: 140,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              MyColors(opacity: 1).primary)),
                                  onPressed: () async {
                                    var limitDay = await MyFunctions()
                                        .getLimitDay(
                                            monthPicked: _rentStartMonth);

                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime(
                                                _rentStartYear,
                                                _rentStartMonth,
                                                _rentStartDay),
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(Icons.calendar_month),
                                      const SizedBox(
                                        width: 5,
                                        height: 20,
                                      ),
                                      Text(
                                          "$_rentEndDay/$_rentEndMonth/$_rentEndYear")
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: _isFieldDaysOfLocationEmpty ? 65 : 45,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Jours de location*',
                              filled: true,
                              fillColor: MyColors(opacity: 1).tertiary),
                          onChanged: (value) {
                            _daysOfLocation = int.parse(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              setState(() {
                                _isFieldDaysOfLocationEmpty = true;
                              });
                              return 'Entrer le nombre de jours de location';
                            }
                            setState(() {
                              _isFieldDaysOfLocationEmpty = false;
                            });

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: _isFieldPriceEmpty ? 65 : 45,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Tarif*',
                              filled: true,
                              fillColor: MyColors(opacity: 1).tertiary),
                          onChanged: (value) {
                            _price = int.parse(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              setState(() {
                                _isFieldPriceEmpty = true;
                              });
                              return 'Entrer un tarif';
                            }
                            setState(() {
                              _isFieldPriceEmpty = false;
                            });

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: _isFieldDepositEmpty ? 65 : 45,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Caution*',
                              filled: true,
                              fillColor: MyColors(opacity: 1).tertiary),
                          onChanged: (value) {
                            _caution = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              setState(() {
                                _isFieldDepositEmpty = true;
                              });
                              return 'Entrer le montant de la caution';
                            }
                            setState(() {
                              _isFieldDepositEmpty = false;
                            });

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: _isFieldCurrentKilometerEmpty ? 65 : 45,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Kilomètre actuel*',
                              filled: true,
                              fillColor: MyColors(opacity: 1).tertiary),
                          onChanged: (value) {
                            _currentKilometer = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              setState(() {
                                _isFieldCurrentKilometerEmpty = true;
                              });
                              return 'Entrer le nom de kilomètre actuel';
                            }
                            setState(() {
                              _isFieldCurrentKilometerEmpty = false;
                            });

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: _isFieldKilometerAllowedEmpty ? 65 : 45,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Kilomètres autorisé*',
                              filled: true,
                              fillColor: MyColors(opacity: 1).tertiary),
                          onChanged: (value) {
                            _kilometerAllowed = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              setState(() {
                                _isFieldKilometerAllowedEmpty = true;
                              });
                              return 'Entrer le nombre de kilomètre autorisé';
                            }
                            setState(() {
                              _isFieldKilometerAllowedEmpty = false;
                            });

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: _isFieldExceedKilometerEmpty ? 65 : 45,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Tarif kilomètre dépassé*',
                              filled: true,
                              fillColor: MyColors(opacity: 1).tertiary),
                          onChanged: (value) {
                            _exceedKilometer = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              setState(() {
                                _isFieldExceedKilometerEmpty = true;
                              });
                              return 'Entrer le prix du kilomètre dépassé';
                            }
                            setState(() {
                              _isFieldExceedKilometerEmpty = false;
                            });

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Informations du locataire',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: _isFieldNameEmpty ? 65 : 45,
                            width: 140,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nom*',
                                  filled: true,
                                  fillColor: MyColors(opacity: 1).tertiary),
                              onChanged: (value) {
                                _name = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  setState(() {
                                    _isFieldNameEmpty = true;
                                  });
                                  return 'Entrer une nom';
                                }
                                setState(() {
                                  _isFieldNameEmpty = false;
                                });

                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: _isFieldFirstnameEmpty ? 65 : 45,
                            width: 140,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Prénom*',
                                  filled: true,
                                  fillColor: MyColors(opacity: 1).tertiary),
                              onChanged: (value) {
                                _firstName = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  setState(() {
                                    _isFieldFirstnameEmpty = true;
                                  });
                                  return 'Entrer un prénom';
                                }
                                setState(() {
                                  _isFieldFirstnameEmpty = false;
                                });

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: _isFieldPhoneNumberEmpty ? 65 : 45,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Numéro de telephone*',
                              filled: true,
                              fillColor: MyColors(opacity: 1).tertiary),
                          onChanged: (value) {
                            _phoneNumber = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                _isFieldPhoneNumberEmpty = true;
                              });
                              return 'Entrer un numéro de téléphone';
                            }

                            if (!RegExp(
                                    r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                .hasMatch(value)) {
                              return 'Entrer un numéro de téléphone valide';
                            }
                            setState(() {
                              _isFieldPhoneNumberEmpty = false;
                            });

                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        height: _isFieldEmailEmpty ? 65 : 45,
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email*',
                              filled: true,
                              fillColor: MyColors(opacity: 1).tertiary),
                          onChanged: (value) {
                            _email = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              setState(() {
                                _isFieldEmailEmpty = true;
                              });
                              return 'Entrer un email';
                            }
                            setState(() {
                              _isFieldEmailEmpty = false;
                            });

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: _isFieldCityEmpty ? 65 : 45,
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ville*',
                              filled: true,
                              fillColor: MyColors(opacity: 1).tertiary),
                          onChanged: (value) {
                            _city = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              setState(() {
                                _isFieldCityEmpty = true;
                              });
                              return 'Entrer une ville';
                            }
                            setState(() {
                              _isFieldCityEmpty = false;
                            });

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: _isFieldPostalCodeEmpty ? 65 : 45,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Code postal*',
                              filled: true,
                              fillColor: MyColors(opacity: 1).tertiary),
                          onChanged: (value) {
                            _postalCode = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              setState(() {
                                _isFieldPostalCodeEmpty = true;
                              });
                              return 'Entrer un code postal';
                            }
                            setState(() {
                              _isFieldPostalCodeEmpty = false;
                            });

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: _isFieldAdresseEmpty ? 65 : 45,
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Adresse*',
                              filled: true,
                              fillColor: MyColors(opacity: 1).tertiary),
                          onChanged: (value) {
                            _adresse = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              setState(() {
                                _isFieldAdresseEmpty = true;
                              });
                              return 'Entrer une adresse';
                            }
                            setState(() {
                              _isFieldAdresseEmpty = false;
                            });

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Documents du locataire',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 300,
                        child: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: _isFieldIdentityCardRectoEmpty
                                  ? MaterialStatePropertyAll(Colors.white)
                                  : MaterialStatePropertyAll(Colors.black),
                              backgroundColor: MaterialStatePropertyAll(
                                  _isFieldIdentityCardRectoEmpty
                                      ? MyColors(opacity: 0.6).primary
                                      : MyColors(opacity: 1).tertiary),
                            ),
                            onPressed: () async {
                              Uint8List identityCardRectoPicked =
                                  await MyFunctions().pickImageFromgallery();

                              _identityCardRecto = identityCardRectoPicked;

                              setState(() {
                                _isFieldIdentityCardRectoEmpty = true;
                              });
                            },
                            child: const Text("Carte d'identité recto*")),
                      ),
                      SizedBox(
                        width: 300,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                foregroundColor: _isFieldIdentityCardVersoEmpty
                                    ? const MaterialStatePropertyAll(
                                        Colors.white)
                                    : const MaterialStatePropertyAll(
                                        Colors.black),
                                backgroundColor: MaterialStatePropertyAll(
                                    _isFieldIdentityCardVersoEmpty
                                        ? MyColors(opacity: 0.6).primary
                                        : MyColors(opacity: 1).tertiary)),
                            onPressed: () async {
                              Uint8List identityCardVersoPicked =
                                  await MyFunctions().pickImageFromgallery();

                              _identityCardVerso = identityCardVersoPicked;
                              setState(() {
                                _isFieldIdentityCardVersoEmpty = true;
                              });
                            },
                            child: const Text("Carte d'identité verso*")),
                      ),
                      SizedBox(
                        width: 300,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                foregroundColor: _isFieldLicenseDriveRectoEmpty
                                    ? const MaterialStatePropertyAll(
                                        Colors.white)
                                    : const MaterialStatePropertyAll(
                                        Colors.black),
                                backgroundColor: MaterialStatePropertyAll(
                                    _isFieldLicenseDriveRectoEmpty
                                        ? MyColors(opacity: 0.6).primary
                                        : MyColors(opacity: 1).tertiary)),
                            onPressed: () async {
                              Uint8List licenseDriverRectoPicked =
                                  await MyFunctions().pickImageFromgallery();

                              _licenseDriverRecto = licenseDriverRectoPicked;
                              setState(() {
                                _isFieldLicenseDriveRectoEmpty = true;
                              });
                            },
                            child: const Text("Permis de conduire recto*")),
                      ),
                      SizedBox(
                        width: 300,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                foregroundColor: _isFieldLicenseDriveVersoEmpty
                                    ? const MaterialStatePropertyAll(
                                        Colors.white)
                                    : const MaterialStatePropertyAll(
                                        Colors.black),
                                backgroundColor: MaterialStatePropertyAll(
                                    _isFieldLicenseDriveVersoEmpty
                                        ? MyColors(opacity: 0.6).primary
                                        : MyColors(opacity: 1).tertiary)),
                            onPressed: () async {
                              Uint8List licenseDriverversoPicked =
                                  await MyFunctions().pickImageFromgallery();

                              _licenseDriververso = licenseDriverversoPicked;

                              setState(() {
                                _isFieldLicenseDriveVersoEmpty = true;
                              });
                            },
                            child: const Text("Permis de conduire verso*")),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Etats des lieux',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 300,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                foregroundColor: _isFieldCarCheck1Empty
                                    ? const MaterialStatePropertyAll(
                                        Colors.white)
                                    : const MaterialStatePropertyAll(
                                        Colors.black),
                                backgroundColor: MaterialStatePropertyAll(
                                    _isFieldCarCheck1Empty
                                        ? MyColors(opacity: 0.6).primary
                                        : MyColors(opacity: 1).tertiary)),
                            onPressed: () async {
                              Uint8List pictureCarCheckPicked =
                                  await MyFunctions().pickImageFromgallery();

                              _fieldCarCheck1 = pictureCarCheckPicked;
                              setState(() {
                                _isFieldCarCheck1Empty = true;
                              });
                            },
                            child: const Text("Photo du véhicule 1*")),
                      ),
                      SizedBox(
                        width: 300,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                foregroundColor: _isFieldCarCheck2Empty
                                    ? const MaterialStatePropertyAll(
                                        Colors.white)
                                    : const MaterialStatePropertyAll(
                                        Colors.black),
                                backgroundColor: MaterialStatePropertyAll(
                                    _isFieldCarCheck2Empty
                                        ? MyColors(opacity: 0.6).primary
                                        : MyColors(opacity: 1).tertiary)),
                            onPressed: () async {
                              Uint8List pictureCarCheckPicked =
                                  await MyFunctions().pickImageFromgallery();

                              _fieldCarCheck2 = pictureCarCheckPicked;
                              setState(() {
                                _isFieldCarCheck2Empty = true;
                              });
                            },
                            child: const Text("Photo du véhicule 2*")),
                      ),
                      SizedBox(
                        width: 300,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                foregroundColor: _isFieldCarCheck3Empty
                                    ? const MaterialStatePropertyAll(
                                        Colors.white)
                                    : const MaterialStatePropertyAll(
                                        Colors.black),
                                backgroundColor: MaterialStatePropertyAll(
                                    _isFieldCarCheck3Empty
                                        ? MyColors(opacity: 0.6).primary
                                        : MyColors(opacity: 1).tertiary)),
                            onPressed: () async {
                              Uint8List pictureCarCheckPicked =
                                  await MyFunctions().pickImageFromgallery();

                              _fieldCarCheck3 = pictureCarCheckPicked;
                              setState(() {
                                _isFieldCarCheck3Empty = true;
                              });
                            },
                            child: const Text("Photo du véhicule 3")),
                      ),
                      SizedBox(
                        width: 300,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                foregroundColor: _isFieldCarCheck4Empty
                                    ? const MaterialStatePropertyAll(
                                        Colors.white)
                                    : const MaterialStatePropertyAll(
                                        Colors.black),
                                backgroundColor: MaterialStatePropertyAll(
                                    _isFieldCarCheck4Empty
                                        ? MyColors(opacity: 0.6).primary
                                        : MyColors(opacity: 1).tertiary)),
                            onPressed: () async {
                              Uint8List pictureCarCheckPicked =
                                  await MyFunctions().pickImageFromgallery();

                              _fieldCarCheck4 = pictureCarCheckPicked;
                              setState(() {
                                _isFieldCarCheck4Empty = true;
                              });
                            },
                            child: const Text("Photo du véhicule 4")),
                      ),
                      SizedBox(
                        width: 300,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                foregroundColor: _isFieldCarCheck5Empty
                                    ? const MaterialStatePropertyAll(
                                        Colors.white)
                                    : const MaterialStatePropertyAll(
                                        Colors.black),
                                backgroundColor: MaterialStatePropertyAll(
                                    _isFieldCarCheck5Empty
                                        ? MyColors(opacity: 0.6).primary
                                        : MyColors(opacity: 1).tertiary)),
                            onPressed: () async {
                              Uint8List pictureCarCheckPicked =
                                  await MyFunctions().pickImageFromgallery();

                              _fieldCarCheck5 = pictureCarCheckPicked;
                              setState(() {
                                _isFieldCarCheck5Empty = true;
                              });
                            },
                            child: const Text("Photo du véhicule 5")),
                      ),
                      const Text("Signature du locataire* :"),
                      Signature(
                        controller: renterSignatureController,
                        width: 300,
                        height: 200,
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                      Container(
                        width: 300,
                        color: Color.fromARGB(255, 205, 22, 9),
                        child: TextButton(
                            onPressed: () {
                              renterSignatureController.clear();
                            },
                            child: const Text(
                              "Effacer",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      const SizedBox(height: 20),
                      const Text("Signature du propriétaire* :"),
                      Signature(
                        controller: ownerSignatureController,
                        width: 300,
                        height: 200,
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                      Container(
                        width: 300,
                        color: Color.fromARGB(255, 205, 22, 9),
                        child: TextButton(
                            onPressed: () {
                              ownerSignatureController.clear();
                            },
                            child: const Text(
                              "Effacer",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      const SizedBox(height: 30),
                      FutureBuilder(
                        future:
                            Database(userId: currentUserId).getUserDetails(),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              UserModel userDatas = snapshot.data as UserModel;

                              return Container(
                                height: 45,
                                width: 300,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                MyColors(opacity: 1).primary)),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        Uint8List renterSignature =
                                            await MyFunctions().exportSignature(
                                                mySignatureController:
                                                    renterSignatureController);

                                        Uint8List ownerSignature =
                                            await MyFunctions().exportSignature(
                                                mySignatureController:
                                                    ownerSignatureController);
                                        String contractUrl =
                                            await MyFunctions().generatorPdf(
                                                contractDatas: CarContractModel(
                                          renterSignature: renterSignature,
                                          ownerSignature: ownerSignature,
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
                                          kilometerAllowed: _kilometerAllowed,
                                          currentCarKilometer:
                                              _currentKilometer,
                                          priceExceedKilometer:
                                              _exceedKilometer,
                                          ownerAdresse: userDatas.adresse,
                                          ownerCompanyName:
                                              userDatas.companyName,
                                          ownerEmail: userDatas.email,
                                          ownerFirstName: userDatas.firstName,
                                          ownerName: userDatas.name,
                                          ownerPhoneNumber: '07 00 00 00 00',
                                          carBrand: carBrand,
                                          carModel: carModel,
                                          carRegistrationNumber:
                                              carRegistrationNumber,
                                          fieldCarCheck1: _fieldCarCheck1,
                                          fieldCarCheck2: _fieldCarCheck2,
                                          fieldCarCheck3: _fieldCarCheck3,
                                          fieldCarCheck4: _fieldCarCheck4,
                                          fieldCarCheck5: _fieldCarCheck5,
                                        ));

                                        await Database(userId: currentUserId)
                                            .addNewContractToFirestore(
                                                bddCarContractModel:
                                                    BddCarContractModel(
                                                        idCar: carId,
                                                        rentStartDay:
                                                            _rentStartDay,
                                                        rentStartMonth:
                                                            _rentStartMonth,
                                                        rentStartYear:
                                                            _rentStartYear,
                                                        rentEndDay: _rentEndDay,
                                                        rentEndMonth:
                                                            _rentEndMonth,
                                                        rentEndYear:
                                                            _rentEndYear,
                                                        rentPrice: _price,
                                                        renterName: _name,
                                                        renterFirstName:
                                                            _firstName,
                                                        contractUrl:
                                                            contractUrl,
                                                        rentNumberDays:
                                                            _daysOfLocation,
                                                        rentCarBrand: carBrand,
                                                        rentCarModel: carModel,
                                                        currentCarKilometer:
                                                            _currentKilometer));

                                        _ShowAlertContractCreated();
                                      }
                                    },
                                    child: const Text('Générer le contrat')),
                              );
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
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ]),
                  )),
            )),
      ),
    );
  }
}
