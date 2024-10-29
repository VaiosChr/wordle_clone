import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle_clone/pages/first_page.dart';
import 'package:wordle_clone/pages/game_page.dart';
import 'package:wordle_clone/pages/help_page.dart';
import 'package:wordle_clone/pages/settings_page.dart';
import 'package:wordle_clone/pages/stats_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  const MyApp({super.key});

  Future getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

    if (isDarkMode) {
      MyApp.themeNotifier.value = ThemeMode.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    getThemeMode();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: MyApp.themeNotifier.value == ThemeMode.dark
            ? Colors.grey.shade900
            : const Color.fromARGB(255, 247, 245, 249),
      ),
    );

    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Wordle Clone',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: currentMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const FirstPage(),
            '/game_page': (context) => const GamePage(),
            '/stats_page': (context) => const StatsPage(),
            '/settings_page': (context) => const SettingsPage(),
            '/help_page': (context) => const HelpPage(),
          },
        );
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
      fontWeight: FontWeight.w900,
      color: Color.fromARGB(255, 80, 80, 80),
    ),
    labelMedium: TextStyle(
      color: Color.fromARGB(255, 126, 126, 126),
    ),
  ),
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    primary: Colors.green,
  ),
);

ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      letterSpacing: 1.5,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 202, 202, 202),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Color.fromARGB(153, 255, 255, 255),
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Color.fromARGB(153, 255, 255, 255),
    ),
    titleSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    ),
    titleLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 243, 243, 243),
    ),
    labelMedium: TextStyle(
      color: Color.fromARGB(255, 126, 126, 126),
    ),
  ),
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.grey.shade900,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: Brightness.dark,
  ),
);
