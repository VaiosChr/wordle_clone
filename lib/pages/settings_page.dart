import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.help_outline,
              size: 28,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/help_page');
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Settings'),
      ),
    );
  }
}
