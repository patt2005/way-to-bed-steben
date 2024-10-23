import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_to_bed_steben/pages/home_page.dart';
import 'package:way_to_bed_steben/utils/utils.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentPageIndex = 0;

  final List<Widget> _pagesList = [
    const Homepage(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          _pagesList[_currentPageIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: CupertinoTabBar(
              backgroundColor: Colors.white,
              currentIndex: _currentPageIndex,
              activeColor: kbuton,
              inactiveColor: Colors.grey,
              onTap: (value) {
                setState(() {
                  _currentPageIndex = value;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.placemark),
                  label: "Routes",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.calendar),
                  label: "Calendar",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.map),
                  label: "Places",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
