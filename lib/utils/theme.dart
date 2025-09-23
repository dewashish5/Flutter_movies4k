import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  Color wishlistcontainercolordark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xff252836).withValues(alpha: 0.8)
        : const Color(0xffC2C8CE).withValues(alpha: 0.5);
  }
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xff4B8787),
  textTheme: TextTheme(
    titleMedium: GoogleFonts.montserrat(
      color: const Color(0xFFFFFFFF),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.montserrat(
      color: const Color(0xFFFFFFFF),
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF303131),
  textTheme: TextTheme(
    titleMedium: GoogleFonts.montserrat(
      color: const Color(0xFFFFFFFF),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.montserrat(
      color: const Color(0xFFFFFFFF),
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  ),
);
