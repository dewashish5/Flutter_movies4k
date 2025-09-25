import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  final String? title, posterimage, genre, rating;
  const Wishlist({
    super.key,
    this.title,
    this.posterimage,
    this.genre,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wishlist",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 23),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "Assets/film-slash.png",
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.grey.shade700,
              height: 100,
              cacheHeight: 100,
              cacheWidth: 100,
              width: 100,
            ),
            Text(
              "Nothing in your wishlist",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
