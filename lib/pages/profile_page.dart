import 'package:boboloc/constants/colors/colors.dart';
import 'package:boboloc/widgets/buttons/logout_button.dart';
import 'package:boboloc/widgets/cards/profile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    void _showAlertLogout() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: MyColors(opacity: 1).tertiary,
              title: const Text(
                'Déconnexion',
                textAlign: TextAlign.center,
              ),
              content: const Text(
                'Voulez vous vraiment vous déconnecter ?',
                textAlign: TextAlign.center,
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
                            context.go('/sign_in');
                            await FirebaseAuth.instance.signOut();
                          },
                          child: const Text('Oui')),
                    ),
                    Container(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  MyColors(opacity: 1).secondary),
                              foregroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.black)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Annuler')),
                    )
                  ],
                ),
              ],
            );
          });
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: MyColors(opacity: 0.8).secondary,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: const Text(
                'Profil',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 25),
            Column(children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: MyColors(opacity: 0.3).primary,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'AI Transport',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text('aitransport@gmail.com')
            ]),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Column(children: const [
              ProfileCard(
                cardIconIndex: 0,
                cardText: 'Editer le profil',
                navigationPath: 'contact_page',
              ),
              ProfileCard(
                cardText: 'Liste des reservations',
                cardIconIndex: 1,
                navigationPath: 'contact_page',
              ),
              ProfileCard(
                cardText: 'Contact',
                cardIconIndex: 3,
                navigationPath: 'contact_page',
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                _showAlertLogout();
              },
              child: Container(
                height: 40,
                width: 140,
                margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 237, 33, 19)),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 35,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            topRight: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                      ),
                      child: const Icon(Icons.logout, color: Colors.white),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      padding: const EdgeInsets.fromLTRB(10, 12, 0, 0),
                      child: const Text(
                        'Déconnexion',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
