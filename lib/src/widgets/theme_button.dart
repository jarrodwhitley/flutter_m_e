import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_e/src/providers/settings_provider.dart';

class ThemeButton extends StatelessWidget {
  final WidgetRef ref;
  final String type;
  final String label;
  final int selected;
  final bool isSelected;
  final VoidCallback onPressed;

  const ThemeButton({
    super.key,
    required this.ref,
    required this.label,
    required this.type,
    required this.selected,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.grey : Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.grey),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
