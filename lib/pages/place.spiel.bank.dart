import 'package:flutter/material.dart';

class Placespielbank extends StatefulWidget {
  const Placespielbank({super.key});

  @override
  State<Placespielbank> createState() => _PlacespielbankState();
}

class _PlacespielbankState extends State<Placespielbank> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                "Spielbank Bad Steben",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Bayon",
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                  "Alexander von Humboldt, Bad Steben's most famous resident, might have been saddened that during his years in the spa (from 1792 to 1795) there was no casino yet. The great scientist might have been so enthralled by the impressive world of entertainment that he might even have abandoned his scientific expeditions.\n"),
              Text(
                  "Today, guests at the casino in Bad Steben can immerse themselves in the stylish and spacious atmosphere of the halls, experience the excitement and thrill of roulette, poker or blackjack tables, and enjoy a wide selection of slot machines. Even the smallest bets here can turn into a source of pleasure, and modern slot machines provide an opportunity to try your luck in first-class conditions.\n"),
              Text(
                  "In addition to gambling, cultural events await visitors. The CasinoLIVE stage hosts colorful shows, such as cabaret and concerts, which create an unforgettable atmosphere and lift your spirits. And winning and dancing give not only adrenaline, but also real hormones of happiness.\n"),
              Text(
                  "Gourmets will also find something special here: the chefs of the casino restaurant offer guests exquisite dishes of both local and international cuisine, which can conquer any connoisseur.\n"),
              Text(
                  "The Casino Bad Steben invites you to spend time in this magnificent place, enjoying exciting games, gastronomic masterpieces and moments of happiness.\n")
            ],
          ),
        ),
      )),
    );
  }
}
