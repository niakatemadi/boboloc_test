import 'package:boboloc/constants/colors/colors.dart';
import 'package:boboloc/pages/profile_page.dart';
import 'package:boboloc/utils/clipper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactUsPage extends StatefulWidget {
  ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isFieldNameEmpty = false;
  bool _isFieldEmailEmpty = false;
  bool _isFieldMessageEmpty = false;
  String sujet = '';
  String message = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        title: const Text('Contactez nous'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                height: MediaQuery.of(context).size.height / 1.9,
                color: MyColors(opacity: 1).primary,
                child: Center(
                  child: Container(
                    height: 250,
                    width: 250,
                    child:
                        Image(image: AssetImage('assets/contact_us_logo.png')),
                  ),
                ),
              ),
            ),
            Container(
              width: 310,
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: _isFieldNameEmpty ? 65 : 45,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Sujet',
                                filled: true,
                                fillColor: MyColors(opacity: 1).tertiary),
                            onChanged: (value) {
                              sujet = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                setState(() {
                                  _isFieldNameEmpty = true;
                                });
                                return 'Entrer votre nom';
                              }
                              setState(() {
                                _isFieldNameEmpty = false;
                              });

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: _isFieldEmailEmpty ? 65 : 45,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                filled: true,
                                fillColor: MyColors(opacity: 1).tertiary),
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                setState(() {
                                  _isFieldEmailEmpty = true;
                                });
                                return 'Entrer votre email';
                              }
                              setState(() {
                                _isFieldEmailEmpty = false;
                              });

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          height: 100,
                          child: const TextField(
                            expands: true,
                            maxLines: null,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                            height: 45,
                            width: 310,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        MyColors(opacity: 1).primary)),
                                onPressed: () {},
                                child: const Text('Envoyer')))
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
