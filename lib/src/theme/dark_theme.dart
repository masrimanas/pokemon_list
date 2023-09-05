import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_list/src/theme/color_palette.dart';
import 'package:pokemon_list/src/theme/text_themes.dart';

final customDarkTheme = ThemeData(
  useMaterial3: true,
  extensions: const [customDarkColors],
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: customDarkColors.primaryColor,
    titleTextStyle: customDarkTextTheme.headlineSmall,
  ),
  scaffoldBackgroundColor: customDarkColors.backgroundColor,
  textTheme: GoogleFonts.getTextTheme('Montserrat', customDarkTextTheme),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
  ),
  listTileTheme: ListTileThemeData(
    tileColor: customDarkColors.backgroundColor,
    textColor: customDarkColors.textColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
