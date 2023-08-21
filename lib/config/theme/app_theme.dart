import 'package:flutter/material.dart';

Color get backgroundColor => const Color(0xFF272727);
Color get accentColor => const Color(0xFFF3A838);

ThemeData theme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: 'Inter',
    appBarTheme: appBarTheme(),
    bottomNavigationBarTheme: bottomNavigationBarThemeData(),
    inputDecorationTheme: inputDecorationTheme(),
    textSelectionTheme: textSelectionTheme(),
    radioTheme: radioTheme(),
    checkboxTheme: checkboxTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Color(0xFF434343),
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
  );
}

BottomNavigationBarThemeData bottomNavigationBarThemeData() {
  return BottomNavigationBarThemeData(selectedItemColor: accentColor);
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    focusColor: accentColor,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: accentColor,
      ),
    ),
    suffixIconColor: accentColor,
  );
}

TextSelectionThemeData textSelectionTheme() {
  return TextSelectionThemeData(
    cursorColor: accentColor,
  );
}

RadioThemeData radioTheme() {
  return RadioThemeData(
    fillColor: MaterialStateProperty.all(accentColor),
  );
}

CheckboxThemeData checkboxTheme() {
  return CheckboxThemeData(
    checkColor: MaterialStateProperty.all(accentColor),
    fillColor: MaterialStateProperty.all(Colors.transparent),
    side: BorderSide(color: accentColor, width: 1),
  );
}

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all(
        const Size.fromHeight(50.0),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}
