import 'dart:io';
import 'dart:math';
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
  String _carBrand = '';
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
        currentCarKilometer: _carCurrentKilometer,
        carPicture: getStorageCarsRefUrl,
        carRegistrationNumber: _carRegistrationNumber,
      ));
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.go('/cars_list'),
            icon: Icon(Icons.arrow_back)),
        title: const Text('Nouvelle voiture'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                return context.go('/wrapper');
              },
              child: Text('Sign out')),
        ],
      ),
      body: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
              width: 300,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        'Nouvelle voiture',
                        style: TextStyle(fontSize: 25),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(hintText: 'Marque'),
                        onChanged: (value) {
                          _carBrand = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer la marque du véhicule ";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Nombre de kilomètre actuel'),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ],
                        onChanged: (value) {
                          _carCurrentKilometer = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer le nombre de kilométre ";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'Immatriculation'),
                        onChanged: (value) {
                          _carRegistrationNumber = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer le numéro d'immatriculation ";
                          }
                          return null;
                        },
                      ),
                      Container(
                          width: 200,
                          child: OutlinedButton(
                            style: const ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.black),
                            ),
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
                            },
                            child: Text('Choisir une photo..'),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print('new car added !');
                              uploadGalleryPicture(
                                  imagePicked:
                                      _imagePickedPathConvertedToBytes);
                            }
                          },
                          child: const Text('Ajouter'))
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
