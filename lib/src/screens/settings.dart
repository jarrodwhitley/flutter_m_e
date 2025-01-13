import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_e/src/providers/is_am.dart';
import 'package:m_e/src/providers/settings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAm = ref.watch(isAmProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: isAm.getBackgroundColor(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Appearance Section
              const Text(
                'Appearance',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Theme',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildThemeButton(ref, 'Auto', 0),
                          _buildThemeButton(ref, 'Light', 1),
                          _buildThemeButton(ref, 'Dark', 2),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Font Size - 16',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFontSizeButton(Icons.remove),
                          _buildFontSizeButton(Icons.add),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setThemeOverride(WidgetRef ref, int selected) {
    final settingsNotifier = ref.read(settingsProvider.notifier);
    settingsNotifier.setThemeOverride(selected);
  }

  Widget _buildThemeButton(WidgetRef ref, String label, int selected) {
    final themeOverride = ref.watch(settingsProvider).themeOverride;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selected == themeOverride ? Colors.grey : Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.grey),
        elevation: 0,
      ),
      onPressed: () {
        setThemeOverride(ref, selected);
      },
      child: Text(label),
    );
  }

  Widget _buildFontSizeButton(IconData icon) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.grey),
        elevation: 0,
      ),
      onPressed: () {
        // Add font size change logic here
      },
      child: Icon(icon),
    );
  }
}
