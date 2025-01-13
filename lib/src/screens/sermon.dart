import 'package:flutter/material.dart';
import 'package:m_e/src/models/sermon.dart';
import 'package:m_e/src/widgets/html.dart';

class SermonScreen extends StatelessWidget {
  const SermonScreen({super.key, required this.sermon});
  final Sermon sermon;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Title
              Text(
                sermon.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              // icon divider to separate title and scripture
              const Icon(Icons.remove, size: 30),
              const SizedBox(height: 16),
              // Scripture
              Text(
                sermon.scripture,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Html(
                        data: item,
                      ),
                    );
                  } else if (item is List<String>) {
                    return Column(
                      children: item
                          .map((string) => Html(
                                data: string,
                                textAlign: TextAlign.center,
                              ))
                          .toList(),
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
