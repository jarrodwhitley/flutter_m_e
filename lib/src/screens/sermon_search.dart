import 'package:flutter/material.dart';
import 'package:m_e/src/data/sermons.dart';
import 'package:m_e/src/models/sermon.dart';
import 'package:m_e/src/screens/sermon.dart';

// The purpose of this screen is to list all available sermons and provide a search feature that allows the user to search by title, scripture, or body content
class SermonSearchScreen extends StatefulWidget {
  const SermonSearchScreen({super.key, required this.onSermonSelected});
  final Function(Sermon) onSermonSelected;
  @override
  State<SermonSearchScreen> createState() => _SermonSearchScreenState();
}

class _SermonSearchScreenState extends State<SermonSearchScreen> {
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
                  widget.onSermonSelected(sermon);
                  //   Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return SermonScreen(sermon: sermon);
                  //     },
                  //   ),
                  // );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
