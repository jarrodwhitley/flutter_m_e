import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_e/src/data/sermons.dart';
import 'package:m_e/src/models/sermon.dart';
import 'package:m_e/src/providers/sermon.dart';

class SermonSearchScreen extends ConsumerStatefulWidget {
  const SermonSearchScreen({super.key});

  @override
  ConsumerState<SermonSearchScreen> createState() => _SermonSearchScreenState();
}

class _SermonSearchScreenState extends ConsumerState<SermonSearchScreen> {
  String _searchText = '';
  late List<Sermon> filteredSermons;

  @override
  void initState() {
    super.initState();
    filteredSermons = sermons;
  }

  void searchSermons(String searchText) {
    setState(() {
      _searchText = searchText.toLowerCase();
      filteredSermons = sermons.where((sermon) {
        return sermon.title.toLowerCase().contains(_searchText) ||
            sermon.scripture.toLowerCase().contains(_searchText) ||
            sermon.body.any((element) {
              if (element is String) {
                return element.toLowerCase().contains(_searchText);
              } else if (element is List<String>) {
                return element.any((subElement) =>
                    subElement.toLowerCase().contains(_searchText));
              }
              return false;
            });
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ref = ProviderScope.containerOf(context);
    void onSermonSelected(Sermon sermon) {
      ref.read(sermonProvider.notifier).selectSermon(sermon);
    }

    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
            ),
            onChanged: searchSermons,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredSermons.length,
            itemBuilder: (context, index) {
              final sermon = filteredSermons[index];
              return ListTile(
                title: Text(sermon.title),
                subtitle: Text(
                  sermon.scripture.length > 200
                      ? '${sermon.scripture.substring(0, 200)}...'
                      : sermon.scripture,
                ),
                onTap: () {
                  onSermonSelected(sermon);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
