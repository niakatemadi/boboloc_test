import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await FirebaseAuth.instance.signOut();
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
    );
  }
}
