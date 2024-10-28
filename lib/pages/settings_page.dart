import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle_clone/components/custom_container.dart';
import 'package:wordle_clone/main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _saveThemePreference(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "THEME",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: Icon(
                      MyApp.themeNotifier.value == ThemeMode.light
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Colors.green,
                    ),
                    onPressed: () async {
                      MyApp.themeNotifier.value =
                          MyApp.themeNotifier.value == ThemeMode.light
                              ? ThemeMode.dark
                              : ThemeMode.light;
                      _saveThemePreference(
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? false
                            : true,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CustomContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "HELP",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.info,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/help_page');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
