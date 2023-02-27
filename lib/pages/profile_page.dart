import 'package:boboloc/constants/colors/colors.dart';
import 'package:boboloc/widgets/buttons/logout_button.dart';
import 'package:boboloc/widgets/cards/profile_card.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors(opacity: 0.8).secondary,
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: const Text(
                'Profil',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
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
            const SizedBox(
              height: 30,
            ),
            Column(children: const [
              ProfileCard(
                cardIconIndex: 0,
                cardText: 'Editer le profil',
              ),
              ProfileCard(cardText: 'Liste des reservations', cardIconIndex: 1),
              ProfileCard(cardText: 'Paramètres', cardIconIndex: 2),
              ProfileCard(cardText: 'Contact', cardIconIndex: 3),
            ]),
            const LogoutButton()
          ],
        ),
      ),
    );
  }
}
