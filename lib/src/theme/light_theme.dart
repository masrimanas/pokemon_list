import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_list/src/theme/color_palette.dart';
import 'package:pokemon_list/src/theme/text_themes.dart';

final customLightTheme = ThemeData(
  useMaterial3: true,
  extensions: const [customLightColors],
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: customLightColors.primaryColor,
    titleTextStyle: customLightTextTheme.headlineSmall,
  ),
  scaffoldBackgroundColor: customLightColors.backgroundColor,
  textTheme: GoogleFonts.getTextTheme('Montserrat', customLightTextTheme),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
  ),
  listTileTheme: ListTileThemeData(
    tileColor: customLightColors.backgroundColor,
    textColor: customLightColors.textColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
