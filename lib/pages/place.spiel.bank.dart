import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_to_bed_steben/models/route_article.dart';

class Placespielbank extends StatefulWidget {
  const Placespielbank({super.key, required this.article});
  final RouteArticle article;
  @override
  State<Placespielbank> createState() => _PlacespielbankState();
}

class _PlacespielbankState extends State<Placespielbank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                widget.article.title,
                style: const TextStyle(
                  fontSize: 30,
                  fontFamily: "Bayon",
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(widget.article.content),
            ],
          ),
        ),
      )),
    );
  }
}
