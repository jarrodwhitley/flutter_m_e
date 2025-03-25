import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:m_e/src/models/devotion.dart';
import 'package:m_e/src/providers/settings_provider.dart';
import 'package:m_e/src/providers/is_am_provider.dart';

class DevotionScreen extends ConsumerStatefulWidget {
  const DevotionScreen({super.key, required this.devotion});

  final Devotion devotion;

  @override
  ConsumerState<DevotionScreen> createState() => _DevotionScreenState();
}

class _DevotionScreenState extends ConsumerState<DevotionScreen> {
  @override
  Widget build(BuildContext context) {
    final isAm = ref.read(isAmProvider);
    final int colorThemeOverride =
        ref.watch(settingsProvider).colorThemeOverride;

    String backgroundImage() {
      if (isAm && colorThemeOverride == 0 || colorThemeOverride == 1) {
        return 'lib/src/assets/images/morning_bg.png';
      } else {
        return 'lib/src/assets/images/evening_bg.png';
      }
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage()),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  widget.devotion.keyverse,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.devotion.body,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
