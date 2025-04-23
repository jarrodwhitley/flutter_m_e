import 'package:flutter/material.dart';
import 'package:m_e/src/data/content_data.dart';
import 'package:m_e/src/models/content.dart';
import 'package:m_e/src/screens/drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late List<Content> selectedContent;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedContent = contentData.where((content) {
      return content.month == now.month && content.day == now.day;
    }).toList();

    // temp override for testing purposes
    // set selectedContent to September 10th
    // selectedContent = contentData.where((content) {
    //   return content.month == 9 && content.day == 10;
    // }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isAm = now.hour < 12;
    final contentToShow = selectedContent
        .firstWhere((content) => content.time == (isAm ? 'am' : 'pm'));

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: isAm
              ? const Color.fromARGB(255, 103, 189, 178)
              : const Color.fromARGB(255, 55, 30, 83),
        ),
        elevation: 0,
        title: Text(
          contentToShow.title,
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(isAm
                ? 'lib/src/assets/images/morning_bg.png'
                : 'lib/src/assets/images/evening_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    contentToShow.keyverse,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    contentToShow.body,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
