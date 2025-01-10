import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:m_e/src/models/sermon.dart';
import 'package:m_e/src/data/sermons.dart'; // Import the predefined sermons

final bookmarksProvider =
    StateNotifierProvider<BookmarksNotifier, List<String>>((ref) {
  return BookmarksNotifier();
});

class BookmarksNotifier extends StateNotifier<List<String>> {
  BookmarksNotifier() : super([]) {
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final List<Sermon> sermonsData = sermons;
    final prefs = await SharedPreferences.getInstance();
    final bookmarkIds = prefs.getStringList('bookmarks') ?? [];
    state = bookmarkIds;

    // print titles of all bookmarked sermons that are loaded
    print('(state)loaded bookmarks length ${state.length}');

    // match sermon id from the loaded bookmarks to the sermons list and print the title
    for (final id in state) {
      final sermon = sermonsData.firstWhere(
        (sermon) => sermon.id == id,
        orElse: () => Sermon(
          id: '',
          title: 'Unknown',
          scripture: '',
          source: 'Unknown',
          sourceLink: '',
          body: [],
        ),
      );
      if (sermon.id != '') {
        print('(state)loaded bookmarks ${sermon.title}');
      } else {
        print('(state)loaded bookmarks: Sermon not found for id $id');
      }
    }
  }

  void addBookmark(String id) {
    if (!state.contains(id)) {
      state = [...state, id];
      _saveBookmarks();
    }
  }

  void removeBookmark(String id) {
    state = state.where((s) => s != id).toList();
    _saveBookmarks();
  }

  void clearBookmarks() {
    state = [];
    _saveBookmarks();
  }

  void toggleBookmark(String id) {
    if (state.contains(id)) {
      removeBookmark(id);
    } else {
      addBookmark(id);
    }
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('bookmarks', state);
    print('bookmarks.dart => saved prefs ${prefs.getStringList('bookmarks')}');
  }
}

// create a isBookmarked function to check if a sermon is bookmarked
Future<bool> isBookmarked(Sermon sermon) async {
  // final List<Sermon> sermonsData = sermons;
  final prefs = await SharedPreferences.getInstance();
  final bookmarkIds = prefs.getStringList('bookmarks') ?? [];
  return bookmarkIds.contains(sermon.id);
}
