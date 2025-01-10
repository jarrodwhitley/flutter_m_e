import 'package:flutter_riverpod/flutter_riverpod.dart';

final isAmProvider = StateNotifierProvider<IsAmNotifier, bool>((ref) {
  return IsAmNotifier();
});

class IsAmNotifier extends StateNotifier<bool> {
  IsAmNotifier() : super(_getInitialIsAm());

  static bool _getInitialIsAm() {
    final now = DateTime.now();
    return now.hour < 14;
  }
}
