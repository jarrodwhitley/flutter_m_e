import 'package:flutter/material.dart';
import 'package:m_e/src/data/sermons.dart';
import 'package:m_e/src/models/sermon.dart';
import 'package:m_e/src/widgets/html.dart';

class SermonScreen extends StatelessWidget {
  SermonScreen({super.key});

  // for testing set the selectedSermon to the first sermon in the list
  final Sermon sermon = sermons
      .firstWhere((sermon) => sermon.title == 'Christ the Conqueror of Satan');

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
              // Title
              Text(
                sermon.title,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              // Scripture
              Text(
                sermon.scripture,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              // Body
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sermon.body.length,
                itemBuilder: (context, index) {
                  final item = sermon.body[index];
                  if (item is String) {
                    return Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      child: Html(
                        data: item,
                      ),
                    );
                  } else if (item is List<String>) {
                    return Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        children: [
                          for (String string in item)
                            Html(
                              data: string,
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
