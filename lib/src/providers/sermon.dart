// provider for settings and getting the selected sermon
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_e/src/models/sermon.dart';
import 'package:m_e/src/data/sermons.dart';

class SermonNotifier extends StateNotifier<Sermon?> {
  SermonNotifier() : super(null);

  void selectSermon(Sermon sermon) {
    state = sermon;
  }

  void clearSermon() {
    state = null;
  }

  Sermon getSermonById(String id) {
    return sermons.firstWhere((sermon) => sermon.id == id);
  }
}

final sermonProvider = StateNotifierProvider<SermonNotifier, Sermon?>(
  (ref) => SermonNotifier(),
);
