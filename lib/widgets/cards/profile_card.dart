import 'package:boboloc/pages/contact_us_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileCard extends StatelessWidget {
  final String cardText;
  final int cardIconIndex;
  final String navigationPath;
  const ProfileCard(
      {super.key,
      required this.cardText,
      required this.cardIconIndex,
      required this.navigationPath});

  @override
  Widget build(BuildContext context) {
    print('sss');
    List<Widget> cardIcons = const [
      Icon(
        Icons.person_2_outlined,
        color: Color.fromRGBO(113, 101, 227, 1),
      ),
      Icon(Icons.calendar_month_outlined,
          color: Color.fromRGBO(113, 101, 227, 1)),
      Icon(Icons.settings, color: Color.fromRGBO(113, 101, 227, 1)),
      Icon(Icons.email, color: Color.fromRGBO(113, 101, 227, 1))
    ];
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute<void>(builder: (BuildContext context) {
          return ContactUsPage();
        }));
      },
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 50,
        margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  color: Color.fromRGBO(113, 101, 227, 0.3)),
              child: cardIcons[cardIconIndex],
            ),
            Container(
              height: 45,
              width: 160,
              padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
              child: Text(cardText),
            )
          ],
        ),
      ),
    );
  }
}
