// this file will be used to create a provider for bookmarks to favorite sermons
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_e/src/models/sermon.dart';
import 'package:shared_preferences/shared_preferences.dart';

final bookmarksProvider =
    StateNotifierProvider<BookmarksNotifier, List<Sermon>>((ref) {
  return BookmarksNotifier();
});

class BookmarksNotifier extends StateNotifier<List<Sermon>> {
  BookmarksNotifier() : super([]) {
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarkIds = prefs.getStringList('bookmarks') ?? [];
    state = bookmarkIds.map((id) => Sermon.fromId(id)).toList();
  }

  Future<void> addBookmark(Sermon sermon) async {
    state = [...state, sermon];
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('bookmarks', state.map((s) => s.id).toList());
  }

  Future<void> removeBookmark(Sermon sermon) async {
    state = state.where((s) => s.id != sermon.id).toList();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('bookmarks', state.map((s) => s.id).toList());
  }

  bool contains(Sermon sermon) {
    return state.contains(sermon);
  }
}
