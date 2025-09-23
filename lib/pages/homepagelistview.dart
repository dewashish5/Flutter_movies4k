import 'package:flutter/material.dart';
import 'package:movies/pages/wishlist.dart';
import 'package:movies/utils/theme.dart';
import 'package:movies/widgets/categories.dart';
import 'package:movies/widgets/custom_caraousal.dart';

import 'package:movies/widgets/searchbar.dart';

class Homepagelistview extends StatefulWidget {
  final bool isloggedin;
  final VoidCallback openDrawerCallback;

  const Homepagelistview({
    super.key,
    required this.isloggedin,
    required this.openDrawerCallback,
  });

  @override
  State<Homepagelistview> createState() => _HomepagelistviewState();
}

class _HomepagelistviewState extends State<Homepagelistview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const SizedBox(width: 5),

                  GestureDetector(
                    onTap: () {
                      widget.openDrawerCallback();
                    },
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: widget.isloggedin
                          ? CircleAvatar(
                              backgroundColor: Theme.of(
                                context,
                              ).scaffoldBackgroundColor,
                              backgroundImage: const NetworkImage(
                                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                              ),
                            )
                          : const CircleAvatar(child: Icon(Icons.person)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Hello, Dewashish",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "Let's Stream Your Favorite Movies",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(15),
                        right: Radius.circular(15),
                      ),
                      color: CustomTheme().wishlistcontainercolordark(context),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Wishlist(),
                            ),
                          );
                        },
                        icon: SizedBox(
                          height: 22,
                          width: 22,
                          child: Image.asset(
                            'Assets/whislist.png',
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(margin: const EdgeInsets.all(20), child: const Searchbar()),
          const SizedBox(child: CustomCaraousal()),
          const SizedBox(height: 30),
          const SizedBox(child: Categories()),
          const SizedBox(child: Categories()),
          const SizedBox(child: CustomCaraousal()),
        ],
      ),
    );
  }
}
