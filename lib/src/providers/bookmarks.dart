import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:m_e/src/models/sermon.dart';
import 'package:m_e/src/data/sermons.dart';

class BookmarksNotifier extends StateNotifier<List<Sermon>> {
  BookmarksNotifier() : super([]) {
    _loadBookmarks();
  }
  final sermonsData = sermons;

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarkIds = prefs.getStringList('bookmarks') ?? [];
    state = bookmarkIds
        .map((id) => Sermon.fromId(id))
        .where((sermon) => sermon.id != '')
        .toList();
    // print titles of all bookmarked sermons that are loaded
    print('(state)loaded bookmarks length ${state.length}');
    // match sermon id from the loaded bookmarks to the sermons list and print the title
    state.forEach((s) {
      final sermon = sermonsData.firstWhere(
        (sermon) => sermon.id == s.id,
        orElse: () => Sermon(
            id: '',
            title: '',
            scripture: '',
            source: '',
            sourceLink: '',
            body: const []),
      );
      if (sermon.id != '') {
        print('(state)loaded bookmarks ${sermon.title}');
      } else {
        print('(state)loaded bookmarks: Sermon not found for id ${s.id}');
      }
    });
  }

  void addBookmark(Sermon sermon) {
    if (sermon.id != '') {
      state = [...state, sermon];
    }
    _saveBookmarks();
  }

  void removeBookmark(Sermon sermon) {
    state = state.where((s) => s.id != sermon.id).toList();
    _saveBookmarks();
  }

  void clearBookmarks() {
    state = [];
    _saveBookmarks();
  }

  void toggleBookmark(Sermon sermon) {
    if (state.contains(sermon)) {
      removeBookmark(sermon);
    } else {
      addBookmark(sermon);
    }
    state.forEach((s) => print('bookmarks.dart => toggled ${s.id}'));
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('bookmarks', state.map((s) => s.id).toList());
    print('bookmarks.dart => prefs ${prefs.getStringList('bookmarks')}');
  }
}

final bookmarksProvider =
    StateNotifierProvider<BookmarksNotifier, List<Sermon>>(
  (ref) => BookmarksNotifier(),
);
