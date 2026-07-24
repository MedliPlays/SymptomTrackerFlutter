import 'package:flutter/material.dart';

/// Eir brand colour — the purple from the app icon glyph.
const brandPurple = Color(0xFF6E13FF);

ThemeData _base(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: brandPurple,
    brightness: brightness,
  );
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(centerTitle: false),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    ),
  );
}

ThemeData get lightTheme => _base(Brightness.light);
ThemeData get darkTheme => _base(Brightness.dark);
