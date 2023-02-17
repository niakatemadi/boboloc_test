import 'package:boboloc/database/database.dart';
import 'package:boboloc/models/user_model.dart';
import 'package:boboloc/utils/my_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

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
  String _daysOfLocation = '';
  String _price = '';
  String _currentKilometer = '';
  String _exceedKilometer = '';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String carBrand = widget.carDatas['car_brand']!;
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
                        onPressed: () {},
                        child: const Text("Carte d'identité recto")),
                    OutlinedButton(
                        onPressed: () {},
                        child: const Text("Carte d'identité verso")),
                    OutlinedButton(
                        onPressed: () {},
                        child: const Text("Permis de conduire recto")),
                    OutlinedButton(
                        onPressed: () {},
                        child: const Text("Permis de conduire verso")),
                    const Text(
                      'Informations du véhicule',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Début de location'),
                        onChanged: (value) {
                          _startLocationDate = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer une date de début de location";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'Fin de location'),
                        onChanged: (value) {
                          _endLocationDate = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer une date de fin de  location";
                          }
                          return null;
                        }),
                    const SizedBox(height: 5),
                    TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'jours de location'),
                        onChanged: (value) {
                          _daysOfLocation = value;
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
                          _price = value;
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
                      thickness: 5,
                    ),
                    FutureBuilder(
                      future: Database(userId: currentUserId).getUserDetails(),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            UserModel userDatas = snapshot.data as UserModel;

                            return ElevatedButton(
                                onPressed: () async {
                                  print('oook');
                                  await MyFunctions().generatorPdf(
                                      nom: 'karl', prenom: 'Lagarfiel');
                                  print('kkk');
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
