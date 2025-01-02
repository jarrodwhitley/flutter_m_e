import 'package:flutter/material.dart';
import 'package:m_e/src/data/devotions.dart';
import 'package:m_e/src/models/devotion.dart';
import 'package:m_e/src/models/sermon.dart';
import 'package:m_e/src/screens/drawer.dart';
import 'package:m_e/src/screens/devotion.dart';
import 'package:m_e/src/screens/sermon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _pageController = PageController();
  late List<Devotion> selectedDevotions = [];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDevotions = devotions.where((content) {
      return content.month == now.month && content.day == now.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isAm = now.hour < 12;
    final devotion = selectedDevotions
        .firstWhere((content) => content.time == (isAm ? 'am' : 'pm'));

    // Handle the active page
    Widget activePage = DevotionScreen(
      isAm: isAm,
      devotion: devotion,
    );
    var activePageTitle = devotion.title;

    if (_selectedPageIndex == 1) {
      activePage = SermonScreen();
      activePageTitle = 'sermon.title';
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: isAm
              ? const Color.fromARGB(255, 103, 189, 178)
              : const Color.fromARGB(255, 55, 30, 83),
        ),
        elevation: 0,
        title: Text(
          activePageTitle,
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
        children: [
          DevotionScreen(isAm: isAm, devotion: devotion),
          SermonScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isAm
            ? const Color.fromARGB(255, 86, 159, 149)
            : const Color.fromARGB(255, 41, 22, 62),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            label: 'Devotions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Sermons',
          ),
        ],
      ),
    );
  }
}
