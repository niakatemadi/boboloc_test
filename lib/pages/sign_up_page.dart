import 'package:boboloc/database/authentication.dart';
import 'package:boboloc/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = '';
  String _firstName = '';
  String _mail = '';
  String _password = '';
  String _adresse = '';
  String _city = '';
  String _companyName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page d'inscription"),
        actions: [
          IconButton(
              onPressed: () => context.go('/sign_in'),
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      body: Center(
        child: Container(
            width: 300,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(children: [
                  const Text(
                    'Inscription',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Name'),
                    onChanged: (value) {
                      _name = value;
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                      decoration: const InputDecoration(hintText: 'Prénom'),
                      onChanged: (String value) {
                        _firstName = value;
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some firstName';
                        }
                        return null;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(hintText: 'Email'),
                      onChanged: (String value) {
                        _mail = value;
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      }),
                  TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Mot de passe'),
                      onChanged: (String value) {
                        _password = value;
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Nom de votre société'),
                      onChanged: (String value) {
                        _companyName = value;
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your company name';
                        }
                        return null;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(hintText: 'Adresse'),
                      onChanged: (String value) {
                        _adresse = value;
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your adresse';
                        }
                        return null;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(hintText: 'Ville'),
                      onChanged: (String value) {
                        _city = value;
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      }),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('New user signed up !');
                          print(_mail);
                          print(_password);

                          Authentication().signUp(UserModel(
                              name: _name,
                              firstName: _firstName,
                              companyName: _companyName,
                              password: _password,
                              city: _city,
                              email: _mail,
                              adresse: _adresse));
                        }
                      },
                      child: const Text("S'inscrire"))
                ]),
              ),
            )),
      ),
    );
  }
}
