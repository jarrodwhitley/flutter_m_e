// provider for settings and getting the selected sermon
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_e/src/models/sermon.dart';

class SermonNotifier extends StateNotifier<Sermon?> {
  SermonNotifier() : super(null);

  //

  void selectSermon(Sermon sermon) {
    print('Selected sermon: ${sermon.title}');
    state = sermon;
  }

  void clearSermon() {
    state = null;
  }
}

final sermonProvider = StateNotifierProvider<SermonNotifier, Sermon?>(
  (ref) => SermonNotifier(),
);
