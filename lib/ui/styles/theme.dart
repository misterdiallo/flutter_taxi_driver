import 'package:flutter/material.dart';
import 'colors.dart';

const TextStyle basicTextStyle = TextStyle(
  fontFamily: "SFUIDisplay",
  fontWeight: FontWeight.normal,
  fontSize: 16.0,
);

final TextTheme textTheme = TextTheme(
  bodyMedium: basicTextStyle,
  bodyLarge: basicTextStyle.merge(const TextStyle(fontSize: 14.0)),
  titleLarge: basicTextStyle.merge(
    const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 30.0,
    ),
  ),
  titleSmall: basicTextStyle.merge(
    const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12.0,
    ),
  ),
);

class ThemeScheme {
  static dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: dbackgroundColor,
      primaryColor: dprimaryColor,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[400]!,
          ),
        ),
      ),
      colorScheme:
          const ColorScheme.dark().copyWith(secondary: dsecondaryColor),
      // colorScheme:
      //     ColorScheme.fromSwatch().copyWith(secondary: dsecondaryColor),
    );
  }

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lbackgroundColor,
      primaryColor: lprimaryColor,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: dbasicDarkColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[400]!,
          ),
        ),
      ),
      colorScheme:
          const ColorScheme.light().copyWith(secondary: lsecondaryColor),
      // colorScheme:
      //     ColorScheme.fromSwatch().copyWith(secondary: lsecondaryColor),
    );
  }
}
