import 'package:flutter/material.dart';
import 'package:m_e/src/data/sermons.dart';
import 'package:m_e/src/models/sermon.dart';
import 'package:m_e/src/widgets/html.dart';

class SermonScreen extends StatelessWidget {
  SermonScreen({super.key});

  // for testing set the selectedSermon to the first sermon in the list
  final Sermon sermon = sermons[1];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                sermon.title,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                sermon.scripture,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ...sermon.body.map((dynamic item) {
                if (item is String) {
                  return Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    child: Html(
                      data: item,
                    ),
                  );
                } else if (item is Map<String, dynamic>) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          item['title'],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          item['body'],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox(height: 16);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
