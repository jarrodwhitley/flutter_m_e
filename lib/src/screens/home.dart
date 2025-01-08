import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:m_e/src/data/devotions.dart';
import 'package:m_e/src/models/devotion.dart';
import 'package:m_e/src/models/sermon.dart';
import 'package:m_e/src/screens/drawer.dart';
import 'package:m_e/src/screens/devotion.dart';
import 'package:m_e/src/screens/sermon_search.dart';
import 'package:m_e/src/screens/sermon.dart';
import 'package:m_e/src/providers/bookmarks.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _pageController = PageController();
  final bookmarksProvider = StateProvider<List<Sermon>>((ref) => []);
  late List<Devotion> selectedDevotions = [];
  Sermon? sermon;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDevotions = devotions.where((content) {
      return content.month == now.month && content.day == now.day;
    }).toList();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarkIds = prefs.getStringList('bookmarks') ?? [];
    setState(() {
      ref.read(bookmarksProvider.notifier).state =
          bookmarkIds.map((id) => Sermon.fromId(id)).toList();
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      sermon = null;
    });
    // _pageController.animateToPage(
    //   index,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    // );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isAm = now.hour < 14;
    final devotion = selectedDevotions
        .firstWhere((content) => content.time == (isAm ? 'am' : 'pm'));

    // Handle the active page
    Widget activeScreen = DevotionScreen(
      isAm: isAm,
      devotion: devotion,
    );
    var activeScreenTitle = devotion.title;

    void onSermonSelected(Sermon selectedSermon) {
      setState(() {
        sermon = selectedSermon;
      });
    }

    if (_selectedPageIndex == 1) {
      if (sermon != null) {
        activeScreen = SermonScreen(sermon: sermon!);
        activeScreenTitle = 'Sermon';
      } else {
        activeScreen = SermonSearchScreen(
          onSermonSelected: onSermonSelected,
        );
        activeScreenTitle = 'Sermons';
      }
    }

    void bookmarkToggle(Sermon sermon) {
      setState(() {
        final bookmarks = ref.read(bookmarksProvider);
        if (bookmarks.contains(sermon)) {
          ref.read(bookmarksProvider).remove(sermon);
        } else {
          ref.read(bookmarksProvider).add(sermon);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: sermon != null
            ? [
                IconButton(
                  icon: Icon(
                    ref.read(bookmarksProvider).contains(sermon!)
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                  ),
                  onPressed: () {
                    bookmarkToggle(sermon!);
                  },
                ),
              ]
            : null,
        flexibleSpace: Container(
          color: isAm
              ? const Color.fromARGB(255, 103, 189, 178)
              : const Color.fromARGB(255, 55, 30, 83),
        ),
        elevation: 0,
        title: Text(
          activeScreenTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors
              .white, // Set the color of the drawer icon and back arrow to white
        ),
      ),
      drawer: const MainDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        children: [activeScreen],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isAm
            ? const Color.fromARGB(255, 86, 159, 149)
            : const Color.fromARGB(255, 41, 22, 62),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(isAm ? Icons.sunny : Icons.nightlight_round),
            label: 'Devotion',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Sermons',
          ),
        ],
      ),
    );
  }
}
