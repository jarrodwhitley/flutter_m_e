import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isAm = now.hour < 12;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About',
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: isAm
            ? const Color.fromARGB(255, 103, 189, 178)
            : const Color.fromARGB(255, 55, 30, 83),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'lib/src/assets/images/spurgeon_icon.png',
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          const Text(
            'Morning & Evening',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Text('by Charles H. Spurgeon'),
          const SizedBox(height: 10),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Text(
                    '    Charles Haddon Spurgeon (1834-1892) was a British Baptist minister and renowned author who is considered one of the most influential figures in Christian history. Known as the "Prince of Preachers," Spurgeon delivered powerful sermons that attracted thousands of people every week, filling London\'s a collection of daily devotionals that Spurgeon wrote to provide readers with a daily reminder of God\'s presence and grace.\n\n    The devotionals are organized into morning and evening entries for each day of the year, offering timeless insights and encouragement that are still relevant to readers today.\n\n    With its eloquent language and profound spiritual truths, "Morning and Evening" is a beloved classic in Christian literature that continues to encourage and challenge readers around the world.'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
