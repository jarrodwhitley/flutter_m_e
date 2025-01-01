import 'package:flutter/material.dart';
import 'package:m_e/src/models/devotion.dart';

class DevotionScreen extends StatelessWidget {
  const DevotionScreen({super.key, required this.isAm, required this.devotion});

  final Devotion devotion;
  final bool isAm;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  devotion.keyverse,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  devotion.body,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
