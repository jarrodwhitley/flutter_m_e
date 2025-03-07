import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_e/src/providers/settings_provider.dart';

class ThemeButton extends StatelessWidget {
  final WidgetRef ref;
  final String label;
  final int selected;

  const ThemeButton({
    super.key,
    required this.ref,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final themeOverride = ref.watch(settingsProvider).themeOverride;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selected == themeOverride ? Colors.grey : Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.grey),
        elevation: 0,
      ),
      onPressed: () {
        final settingsNotifier = ref.read(settingsProvider.notifier);
        settingsNotifier.setThemeOverride(selected);
      },
      child: Text(label),
    );
  }
}
