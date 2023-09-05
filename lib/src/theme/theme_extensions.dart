import 'package:flutter/material.dart';

class ColorsExtension extends ThemeExtension<ColorsExtension> {
  const ColorsExtension({
    this.primaryColor,
    this.secondaryColor,
    this.accentColor,
    this.backgroundColor,
    this.textColor,
  });

  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? accentColor;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  ThemeExtension<ColorsExtension> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? accentColor,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return ColorsExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      accentColor: accentColor ?? this.accentColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  ThemeExtension<ColorsExtension> lerp(
    covariant ThemeExtension<ColorsExtension>? other,
    double t,
  ) {
    if (other is! ColorsExtension) return this;
    return ColorsExtension(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      accentColor: Color.lerp(accentColor, other.accentColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
    );
  }
}
