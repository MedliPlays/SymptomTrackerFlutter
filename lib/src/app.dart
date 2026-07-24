import 'package:flutter/material.dart';

import 'features/home/home_shell.dart';
import 'theme/app_theme.dart';

class EirApp extends StatelessWidget {
  const EirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eir Symptom Tracker',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeShell(),
    );
  }
}
