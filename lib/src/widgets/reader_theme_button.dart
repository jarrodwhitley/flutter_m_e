import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_e/src/providers/settings_provider.dart';
import 'package:m_e/src/widgets/theme_button.dart';

class ReaderThemeButton extends StatelessWidget {
  final WidgetRef ref;
  final String label;
  final int selected;

  const ReaderThemeButton({
    super.key,
    required this.ref,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final readerThemeOverride = ref.watch(settingsProvider).readerThemeOverride;

    return ThemeButton(
      ref: ref,
      label: label,
      selected: selected,
      isSelected: selected == readerThemeOverride,
      onPressed: () {
        final settingsNotifier = ref.read(settingsProvider.notifier);
        settingsNotifier.setReadercolorThemeOverride(selected);
      },
    );
  }
}
