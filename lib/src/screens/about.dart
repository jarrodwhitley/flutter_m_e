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
      body: const Center(
        child: Text('This is the about screen.'),
      ),
    );
  }
}
