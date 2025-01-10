import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_e/src/providers/is_am.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAm = ref.read(isAmProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: isAm
            ? const Color.fromARGB(255, 103, 189, 178)
            : const Color.fromARGB(255, 55, 30, 83),
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
                          _buildThemeButton('Auto', true),
                          _buildThemeButton('Light', false),
                          _buildThemeButton('Dark', false),
                        ],
                      ),
                      const SizedBox(height: 16),
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
              const SizedBox(height: 20),

              // Support Section
              const Text(
                'Support',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share App'),
                onTap: () {
                  // Add Share App functionality here
                },
              ),
              ListTile(
                leading: const Icon(Icons.coffee),
                title: const Text('Buy me a coffee'),
                onTap: () {
                  // Add Buy me a coffee functionality here
                },
              ),
              ListTile(
                leading: const Icon(Icons.bug_report),
                title: const Text('Found a bug?'),
                onTap: () {
                  // Add Found a bug functionality here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeButton(String label, bool selected) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? Colors.grey : Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.grey),
        elevation: 0,
      ),
      onPressed: () {
        // Add theme change logic here
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
