import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_e/src/providers/is_am_provider.dart';
import 'package:m_e/src/providers/settings_provider.dart';
import 'package:m_e/src/widgets/theme_button.dart';
import 'package:m_e/src/widgets/font_size_button.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final isAm = ref.watch(isAmProvider.notifier);
    final int colorThemeOverride =
        ref.watch(settingsProvider).colorThemeOverride;
    final Color? colorThemeOverrideBackground =
        ref.watch(settingsProvider).colorThemeOverrideBackground;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: colorThemeOverride > 0
            ? colorThemeOverrideBackground
            : isAm.getBackgroundColor(),
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
                        'Color Theme',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ThemeButton(
                              ref: ref,
                              type: 'color',
                              label: 'Auto',
                              isSelected: colorThemeOverride == 0,
                              selected: 0,
                              onPressed: () {
                                ref
                                    .read(settingsProvider.notifier)
                                    .setColorThemeOverride(0);
                              }),
                          ThemeButton(
                              ref: ref,
                              type: 'color',
                              label: 'Light',
                              isSelected: colorThemeOverride == 1,
                              selected: 1,
                              onPressed: () {
                                ref
                                    .read(settingsProvider.notifier)
                                    .setColorThemeOverride(1);
                              }),
                          ThemeButton(
                              ref: ref,
                              type: 'color',
                              label: 'Dark',
                              isSelected: colorThemeOverride == 2,
                              selected: 2,
                              onPressed: () {
                                ref
                                    .read(settingsProvider.notifier)
                                    .setColorThemeOverride(2);
                              }),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Reader Theme',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ThemeButton(
                              ref: ref,
                              type: 'reader',
                              label: 'Auto',
                              selected: 0),
                          ThemeButton(
                              ref: ref,
                              type: 'reader',
                              label: 'Light',
                              selected: 1),
                          ThemeButton(
                              ref: ref,
                              type: 'reader',
                              label: 'Dark',
                              selected: 2),
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
                          FontSizeButton(
                            icon: Icons.remove,
                            onPressed: () {
                              // Add font size decrease logic here
                            },
                          ),
                          FontSizeButton(
                            icon: Icons.add,
                            onPressed: () {
                              // Add font size increase logic here
                            },
                          ),
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
}
