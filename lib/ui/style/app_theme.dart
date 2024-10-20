import 'package:flutter/material.dart';

class AppTheme {
  // Definición de colores como constantes
  static const Color primaryColor = Color.fromRGBO(59, 130, 246, 1);
  static const Color appBarColor = Color.fromRGBO(59, 130, 246, 1);
  static const Color bodyTextColor = Colors.black;
  static const Color hintTextColor = Colors.grey;
  static const Color buttonColor = Color.fromRGBO(59, 130, 246, 1);
  static const Color inputBorderColor = Colors.grey;

  // Definición de estilos de texto
  static TextTheme textTheme() {
    return const TextTheme(
      bodyLarge: TextStyle(color: bodyTextColor, fontSize: 16),
      bodyMedium: TextStyle(color: bodyTextColor, fontSize: 14),
      bodySmall: TextStyle(color: bodyTextColor, fontSize: 12),
      titleLarge: TextStyle(
          color: bodyTextColor, fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: bodyTextColor, fontSize: 18),
      titleSmall: TextStyle(color: bodyTextColor, fontSize: 16),
      // Puedes agregar más estilos de texto según sea necesario
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        titleTextStyle: textTheme().titleLarge?.copyWith(color: Colors.white),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: buttonColor,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: textTheme(),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: inputBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: primaryColor),
        ),
        hintStyle: const TextStyle(
          color: hintTextColor,
        ), // Estilo del texto de sugerencia
      ),
    );
  }
}
