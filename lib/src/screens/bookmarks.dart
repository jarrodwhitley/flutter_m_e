// this screen will show all bookmarked sermons in a list view
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:m_e/src/data/sermons.dart';
import 'package:m_e/src/providers/bookmarks.dart';
import 'package:m_e/src/providers/sermon.dart';
import 'package:m_e/src/models/sermon.dart';
import 'package:m_e/src/providers/is_am.dart';
import 'package:flutter/cupertino.dart';

class BookmarksScreen extends ConsumerStatefulWidget {
  const BookmarksScreen({super.key});

  @override
  BookmarksScreenState createState() => BookmarksScreenState();
}

class BookmarksScreenState extends ConsumerState<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    final isAm = ref.read(isAmProvider);
    final bookmarkedSermonIds = ref.watch(bookmarksProvider);
    final List<Sermon> sermonData = sermons;
    print('bookmarkedSermonIds $bookmarkedSermonIds');
    final List<Sermon> bookmarkedSermons = bookmarkedSermonIds
        .map((id) => sermonData.firstWhere(
              (sermon) => sermon.id == id.toString(),
              orElse: () => Sermon(
                id: '',
                title: '',
                scripture: '',
                source: '',
                sourceLink: '',
                body: [],
              ),
            ))
        .toList();
    print('bookmarkedSermons $bookmarkedSermons');

    void onSermonSelected(Sermon sermon) {
      // TODO: I'd love to do this a better way eventually
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      ref.read(sermonProvider.notifier).selectSermon(sermon);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookmarks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: const Text('Delete all bookmarks'),
                    content: const Text(
                        'Are you sure you want to delete all bookmarks?'),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        isDefaultAction: true,
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.grey)),
                      ),
                      CupertinoDialogAction(
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          setState(() {
                            ref
                                .read(bookmarksProvider.notifier)
                                .clearBookmarks();
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
        flexibleSpace: Container(
          color: isAm
              ? const Color.fromARGB(255, 103, 189, 178)
              : const Color.fromARGB(255, 55, 30, 83),
        ),
        iconTheme: const IconThemeData(
          color: Colors
              .white, // Set the color of the drawer icon and back arrow to white
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: bookmarkedSermons.length,
              itemBuilder: (context, index) {
                final sermon = bookmarkedSermons[index];
                return Dismissible(
                  key: Key(sermon.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    ref
                        .read(bookmarksProvider.notifier)
                        .removeBookmark(sermon.id);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(sermon.title),
                    subtitle: Text(
                      sermon.scripture.length > 200
                          ? '${sermon.scripture.substring(0, 200)}...'
                          : sermon.scripture,
                    ),
                    onTap: () {
                      onSermonSelected(sermon);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
