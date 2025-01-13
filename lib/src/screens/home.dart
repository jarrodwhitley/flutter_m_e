import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:m_e/src/data/devotions.dart';
import 'package:m_e/src/models/devotion.dart';
import 'package:m_e/src/models/sermon.dart';
import 'package:m_e/src/screens/drawer.dart';
import 'package:m_e/src/screens/devotion.dart';
import 'package:m_e/src/screens/sermon_search.dart';
import 'package:m_e/src/screens/sermon.dart';
import 'package:m_e/src/providers/bookmarks.dart';
import 'package:m_e/src/providers/is_am.dart';
import 'package:m_e/src/providers/sermon.dart';
import 'package:m_e/src/widgets/me_app_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _pageController = PageController();
  late List<Devotion> selectedDevotions = [];
  // Sermon? sermon;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDevotions = devotions.where((content) {
      return content.month == now.month && content.day == now.day;
    }).toList();
    // _loadBookmarks();
  }

  bool isBookmarked(Sermon sermon) {
    final bookmarks = ref.read(bookmarksProvider);
    return bookmarks.contains(sermon);
  }

  void bookmarkToggle(Sermon sermon) {
    setState(() {
      ref.read(bookmarksProvider.notifier).toggleBookmark(sermon.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAm = ref.read(isAmProvider);
    final devotion = selectedDevotions
        .firstWhere((content) => content.time == (isAm ? 'am' : 'pm'));
    final sermon = ref.watch(sermonProvider);
    Widget activeScreen = DevotionScreen(
      isAm: isAm,
      devotion: devotion,
    );
    var activeScreenTitle = devotion.title;

    if (_selectedPageIndex == 1) {
      if (sermon != null) {
        activeScreen = SermonScreen(sermon: sermon);
        activeScreenTitle = 'Sermon';
      } else {
        activeScreen = const SermonSearchScreen();
        activeScreenTitle = 'Sermons';
      }
    }

    void selectPage(int index) {
      ref.read(sermonProvider.notifier).clearSermon();
      setState(() {
        _selectedPageIndex = index;
      });
    }

    return Scaffold(
      appBar: MeAppBar(
        activeScreenTitle: activeScreenTitle,
        sermon: sermon,
        isAm: isAm,
        bookmarkToggle: bookmarkToggle,
        isBookmarked: sermon != null ? isBookmarked(sermon) : false,
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
            ? const Color.fromARGB(255, 75, 139, 131)
            : const Color.fromARGB(255, 41, 22, 62),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: selectPage,
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
