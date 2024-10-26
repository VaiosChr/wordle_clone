import 'package:flutter/material.dart';
import 'package:wordle_clone/pages/first_page.dart';
import 'package:wordle_clone/pages/game_page.dart';
import 'package:wordle_clone/pages/help_page.dart';
import 'package:wordle_clone/pages/settings_page.dart';
import 'package:wordle_clone/pages/stats_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wordle Clone',
      theme: lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstPage(),
        '/game_page': (context) => const GamePage(),
        '/stats_page': (context) => const StatsPage(),
        '/settings_page': (context) => const SettingsPage(),
        '/help_page': (context) => const HelpPage(),
      },
    );
  }
}

ThemeData lightTheme = ThemeData(
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      letterSpacing: 1.5,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 126, 126, 126),
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      color: Color.fromARGB(153, 0, 0, 0),
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Color.fromARGB(153, 0, 0, 0),
    ),
    titleSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    ),
    titleLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 80, 80, 80),
    ),
    labelMedium: TextStyle(
      color: Color.fromARGB(255, 126, 126, 126),
    ),
  ),
  // scaffoldBackgroundColor: const Color.fromARGB(255, , 248, 253),
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    primary: Colors.green,
  ),
);
