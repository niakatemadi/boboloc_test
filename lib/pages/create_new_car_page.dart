import 'dart:io';
import 'dart:math';
import 'package:boboloc/constants/colors/colors.dart';
import 'package:boboloc/utils/clipper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:boboloc/database/database.dart';
import 'package:boboloc/models/car_model.dart';
import 'package:boboloc/models/user_connexion_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class CreateNewCarPage extends StatefulWidget {
  const CreateNewCarPage({super.key});

  @override
  State<CreateNewCarPage> createState() => _CreateNewCarPageState();
}

class _CreateNewCarPageState extends State<CreateNewCarPage> {
  int randomNumberGenerator() {
    Random rng = Random();
    return rng.nextInt(9000);
  }

  String carIdGenerator() {
    String timestamp =
        Timestamp.fromDate(DateTime.now()).microsecondsSinceEpoch.toString();
    return timestamp + randomNumberGenerator().toString();
  }

  bool _isFieldEmpty = false;
  bool _isFieldCarPicked = false;
  String _carBrand = '';
  String _carModel = '';
  String _carPicture = '';
  String _carRegistrationNumber = '';
  String _carCurrentKilometer = '';

  late Uint8List _imagePickedPathConvertedToBytes;
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final storage = FirebaseStorage.instance;

  uploadGalleryPicture({imagePicked}) async {
    Random random = Random();
    int dateConvertedToTimestamp =
        Timestamp.fromDate(DateTime.now()).microsecondsSinceEpoch;
    String uniqueImageName =
        '${random.nextInt(1000000)}${dateConvertedToTimestamp}.jpg';

    final storageRef = storage.ref();
    final storageCarsRef = storageRef.child("images/cars/$uniqueImageName");

    try {
      // Upload raw data.
      await storageCarsRef.putData(imagePicked);

      // get image Url
      String getStorageCarsRefUrl = await storageCarsRef.getDownloadURL();

      Database(userId: currentUserId).addNewCar(NewCar(
          carBrand: _carBrand,
          carModel: _carModel,
          currentCarKilometer: _carCurrentKilometer,
          carPicture: getStorageCarsRefUrl,
          carRegistrationNumber: _carRegistrationNumber,
          carId: carIdGenerator()));
    } catch (e) {
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserConnexionData?>(context);
    final currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        leading: IconButton(
            onPressed: () => context.go('/navigation_page'),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          'Ajouter un véhicule',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: MyColors(opacity: 0.8).secondary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                ClipPath(
                  clipper: SmallWaveClipper(),
                  child: Container(
                    height: 151,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: MyColors(opacity: 0.2).primary,
                    ),
                  ),
                ),
                ClipPath(
                  clipper: SmallWaveClipper(),
                  child: Container(
                    height: 148,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: MyColors(opacity: 1).tertiary,
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: _isFieldEmpty ? 65 : 45,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Marque',
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                              onChanged: (value) {
                                _carBrand = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  setState(() {
                                    _isFieldEmpty = true;
                                  });
                                  return "Entrer la marque du véhicule ";
                                }
                                setState(() {
                                  _isFieldEmpty = false;
                                });
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: _isFieldEmpty ? 65 : 45,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Modèle',
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                              onChanged: (value) {
                                _carModel = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  setState(() {
                                    _isFieldEmpty = true;
                                  });
                                  return "Entrer le modèle du véhicule ";
                                }
                                setState(() {
                                  _isFieldEmpty = false;
                                });
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: _isFieldEmpty ? 65 : 45,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Immatriculation',
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                              onChanged: (value) {
                                _carRegistrationNumber = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  setState(() {
                                    _isFieldEmpty = true;
                                  });
                                  return "Entrer le numéro d'immatriculation ";
                                }
                                setState(() {
                                  _isFieldEmpty = false;
                                });
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                              color: Colors.white,
                              height: 45,
                              width: MediaQuery.of(context).size.width - 80,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        const MaterialStatePropertyAll<Color>(
                                            Colors.black),
                                    backgroundColor: _isFieldCarPicked == true
                                        ? MaterialStatePropertyAll<Color>(
                                            MyColors(opacity: 0.5).primary)
                                        : const MaterialStatePropertyAll<Color>(
                                            Colors.white)),
                                onPressed: () async {
                                  final ImagePicker _picker = ImagePicker();
                                  // Pick an image
                                  final XFile? imagePicked = await _picker
                                      .pickImage(source: ImageSource.gallery);

                                  // ImagePicked Path converted to File
                                  File imagePickedPathConvertedToFile =
                                      File(imagePicked!.path);

                                  Uint8List imagePickedPathConvertedToBytes =
                                      imagePickedPathConvertedToFile
                                          .readAsBytesSync();
                                  _imagePickedPathConvertedToBytes =
                                      imagePickedPathConvertedToBytes;

                                  setState(() {
                                    _isFieldCarPicked = true;
                                  });
                                },
                                child: Text('Choisir une photo..'),
                              )),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width - 80,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            MyColors(opacity: 1).primary)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    print('new car added !');
                                    await uploadGalleryPicture(
                                        imagePicked:
                                            _imagePickedPathConvertedToBytes);

                                    context.go('/navigation_page');
                                  }
                                },
                                child: const Text('Ajouter')),
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
