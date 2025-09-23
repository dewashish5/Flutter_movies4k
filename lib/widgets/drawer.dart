import 'package:flutter/material.dart';

class Drawermenu extends StatefulWidget {
  const Drawermenu({super.key});

  @override
  State<Drawermenu> createState() => _DrawerState();
}

class _DrawerState extends State<Drawermenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(backgroundColor: Theme.of(context).scaffoldBackgroundColor);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
