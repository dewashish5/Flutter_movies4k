import 'package:flutter/material.dart';

class Downloadpage extends StatelessWidget {
  final bool isempy;
  const Downloadpage({super.key, required this.isempy});

  @override
  Widget build(BuildContext context) {
    if (isempy == true) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Image.asset(
                "Assets/film-slash.png",
                color: Colors.white,
                height: 100,
                cacheHeight: 100,
                cacheWidth: 100,
                width: 100,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Center(
                child: Text(
                  "No Movies Downloaded",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold();
    }
  }
}
