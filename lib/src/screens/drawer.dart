import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_e/src/screens/settings.dart';
import 'package:m_e/src/screens/about.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:m_e/src/providers/is_am.dart';
import 'package:m_e/src/screens/bookmarks.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});
  final coffeeUrl = 'https://buymeacoffee.com/jarrodwhitley';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAm = ref.read(isAmProvider);

    return Drawer(
      child: Column(
        children: [
          AppBar(
            centerTitle: false,
            title: const Text(
              'M&E',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: isAm
                ? const Color.fromARGB(255, 103, 189, 178)
                : const Color.fromARGB(255, 55, 30, 83),
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const AboutScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Bookmarks'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const BookmarksScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share App'),
            onTap: () {
              // share app , should work for apple android or whatever platform
            },
          ),
          ListTile(
            leading: const Icon(Icons.coffee),
            title: const Text('Buy me a coffee'),
            onTap: () async {
              if (await canLaunchUrl(Uri.parse(coffeeUrl))) {
                await launchUrl(Uri.parse(coffeeUrl),
                    mode: LaunchMode.inAppWebView);
              } else {
                throw 'Could not launch $coffeeUrl';
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.bug_report),
            title: const Text('Found a bug?'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
