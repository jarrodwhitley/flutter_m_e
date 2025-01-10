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
    // before assigning the state, remove duplicate ids
    final uniqueBookmarkIds = bookmarkIds.toSet().toList();
    prefs.setStringList('bookmarks', uniqueBookmarkIds);
    state = bookmarkIds
        .map((id) => Sermon.fromId(id))
        .where((sermon) => sermon.id != '')
        .toList();
    print('bookmarks.dart => loaded prefs ${prefs.getStringList('bookmarks')}');
    print('(state)loaded bookmarks length ${state.length}');
    // match sermon id from the loaded bookmarks to the sermons list and print the title
    for (final sermon in bookmarkIds) {
      final sermonTitle = sermonsData.firstWhere((s) => s.id == sermon).title;
      print('bookmarks.dart => loaded bookmarks ${sermonTitle}');
    }
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
    final bookmarkIds = state.map((s) => s.id).toList();
    for (final sermon in state) {
      if (!bookmarkIds.contains(sermon.id)) {
        prefs.setStringList('bookmarks', bookmarkIds);
      }
      print('bookmarks.dart => saved bookmarks ${sermon.id}');
    }

    print('bookmarks.dart => saved prefs ${prefs.getStringList('bookmarks')}');
  }
}

final bookmarksProvider =
    StateNotifierProvider<BookmarksNotifier, List<Sermon>>(
  (ref) => BookmarksNotifier(),
);
