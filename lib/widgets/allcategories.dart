import 'package:flutter/material.dart';

class Allcategories extends StatefulWidget {
  const Allcategories({super.key});

  @override
  State<Allcategories> createState() => _AllcategoriesState();
}

class _AllcategoriesState extends State<Allcategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
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
      body: Center(child: Text("Coming soon")),
    );
  }
}
