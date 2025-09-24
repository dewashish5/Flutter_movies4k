import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:movies/pages/homepagelistview.dart';
import 'package:movies/widgets/drawer.dart';

class Mainapp extends StatefulWidget {
  const Mainapp({super.key});

  @override
  State<Mainapp> createState() => _MainappState();
}

class _MainappState extends State<Mainapp> {
  int _navCurrentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Pages for Bottom Navigation
  late final List<Widget> _pages = [
    Homepagelistview(
      isloggedin: true,
      openDrawerCallback: () {
        _scaffoldKey.currentState?.openDrawer();
      },
    ),
    const Center(child: Text('Search Page')),
    const Center(child: Text('Downloads Page')),
    const Center(child: Text('Profile Page')),
  ];

  /// Handle bottom navigation taps
  void _onItemTapped(int index) {
    if (!mounted) return;
    setState(() {
      _navCurrentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("Current Index: $_navCurrentIndex");

    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawermenu(),
      drawerScrimColor: Colors.transparent,
      body: _pages[_navCurrentIndex],

      bottomNavigationBar: Container(
        width: double.infinity,
        height: 72,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildNavItem(
              index: 0,
              width: 102,
              icon: "Assets/home.png",
              label: "Home",
            ),
            buildNavItem(
              index: 1,
              width: 106,
              icon: "Assets/search.png",
              label: "Search",
            ),
            buildNavItem(
              index: 2,
              width: 132,
              icon: "Assets/download.png",
              label: "Downloads",
            ),
            buildNavItem(
              index: 3,
              width: 102,
              icon: "Assets/user.png",
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  /// Custom Bottom Navigation Item
  Widget buildNavItem({
    required int index,
    required double width,
    required String icon,
    required String label,
  }) {
    bool isSelected = _navCurrentIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: isSelected ? width : 48,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xff131A22).withValues(alpha: 0.85)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          IconButton(
            enableFeedback: false,
            padding: const EdgeInsets.all(10),
            onPressed: () => _onItemTapped(index),
            icon: Image.asset(
              icon,
              color: isSelected
                  ? const Color(0xff12CDD9)
                  : Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color.fromARGB(125, 255, 255, 255),
            ),
          ),
          if (isSelected)
            Flexible(
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                child: Text(
                  label,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: const TextStyle(
                    color: Color(0xff12CDD9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
