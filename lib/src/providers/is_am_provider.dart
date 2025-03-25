import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsAmNotifier extends StateNotifier<bool> {
  IsAmNotifier() : super(_getInitialIsAm());

  static bool _getInitialIsAm() {
    final now = DateTime.now();
    return now.hour < 14;
  }

  Color getBackgroundColor() {
    return state
        ? const Color.fromARGB(255, 103, 189, 178)
        : const Color.fromARGB(255, 55, 30, 83);
  }
}

final isAmProvider = StateNotifierProvider<IsAmNotifier, bool>((ref) {
  return IsAmNotifier();
});
