import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Muli",

      appBarTheme: const AppBarTheme(
        color: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white),
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        bodySmall: TextStyle(color: Colors.black)
      ),

      inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Colors.blue),
        contentPadding: EdgeInsets.symmetric(horizontal:20, vertical: 15),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue,width: 2),
        ),
        focusColor: Colors.blue
      ),


      visualDensity: VisualDensity.adaptivePlatformDensity,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange.shade400,
          foregroundColor: Colors.white,
          // minimumSize: const Size(double.infinity, 48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        )
      )
    );
  }
}

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(28)),
  borderSide: BorderSide(color: Colors.black),
  gapPadding: 10,
);

LinearGradient gradient = LinearGradient(
  colors: [Colors.blue, Colors.lightBlue],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);