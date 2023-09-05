// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pokemon_list/src/theme/theme_extensions.dart';

// https://realtimecolors.com/?colors=181112-eee7e8-f74a64-e6dbdc-636a92
const customLightColors = ColorsExtension(
  primaryColor: Color(0xFFF74A64),
  secondaryColor: Color(0xFFE6DBDC),
  accentColor: Color(0xFF636A92),
  backgroundColor: Color(0xFFEEE7E8),
  textColor: Color(0xFF181112),
);

const customDarkColors = ColorsExtension(
  primaryColor: Color(0xFFF74A64),
  secondaryColor: Color(0xFF181111),
  accentColor: Color(0xFFBCBFD2),
  backgroundColor: Color(0xFF181112),
  textColor: Color(0xFFEEE7E8),
);
