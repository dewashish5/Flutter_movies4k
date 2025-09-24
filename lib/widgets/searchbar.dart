import 'dart:developer';

import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => TextSelectionTheme(
        data: TextSelectionThemeData(
          cursorColor: Theme.of(context).brightness == Brightness.light
              ? const Color(0xFF07213D).withValues(alpha: 0.51)
              : const Color(0xff92929D),
          selectionColor: Theme.of(context).brightness == Brightness.light
              ? const Color(0xff4B8787)
              : const Color(0xff92929D), // selection highlight
          selectionHandleColor: Theme.of(context).brightness == Brightness.light
              ? const Color(0xff4B8787)
              : const Color(0xff92929D), // drag handle
        ),
        child: SearchAnchor.bar(
          shrinkWrap: true,
          isFullScreen: false,
          onSubmitted: (value) => {log(value)},

          dividerColor: Theme.of(context).dividerColor,
          barHintText: "Search for a movie",
          barHintStyle: WidgetStatePropertyAll(
            TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? const Color.fromARGB(255, 7, 33, 61).withValues(alpha: 0.51)
                  : const Color(0xff92929D),
            ),
          ),
          barTrailing: [
            Center(
              child: SizedBox(
                height: 20,
                child: VerticalDivider(
                  thickness: 1.5,
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color(0xff07213D).withValues(alpha: 0.51)
                      : const Color(0xff696974),
                ),
              ),
            ),
            IconButton(
              onPressed: () => {},
              icon: SizedBox(
                height: 18,
                width: 18,
                child: Image.asset(
                  'Assets/settings-sliders.png',
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color(0xff07213D).withValues(alpha: 0.51)
                      : const Color(0xff696974),
                ),
              ),
            ),
          ],

          barBackgroundColor: Theme.of(context).brightness == Brightness.light
              ? WidgetStatePropertyAll(
                  const Color(0xFFFFFFFF).withValues(alpha: 0.51),
                )
              : WidgetStatePropertyAll(
                  const Color(0xff131A22).withValues(alpha: 0.51),
                ),
          viewBackgroundColor: Theme.of(context).brightness == Brightness.light
              ? const Color(0xFFFFFFFF).withValues(alpha: 0.51)
              : const Color(0xff131A22).withValues(alpha: 0.71),
          barElevation: WidgetStatePropertyAll(0),
          barLeading: Icon(
            Icons.search,
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xff92929D)
                : const Color(0xff07213D).withValues(alpha: 0.51),
          ),

          suggestionsBuilder: (context, query) {
            return [
              for (int i = 0; i < 3; i++)
                const ListTile(title: Text('example')),
            ];
          },
        ),
      ),
    );
  }
}
