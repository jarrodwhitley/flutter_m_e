import 'package:flutter/material.dart';
// import 'package:m_e/src/screens/settings.dart';
import 'package:m_e/src/screens/notifications.dart';
import 'package:m_e/src/screens/about.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  final coffeeUrl = 'https://buymeacoffee.com/jarrodwhitley';

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isAm = now.hour < 12;

    return Drawer(
      child: Column(
        children: [
          AppBar(
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
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: const Text('Settings'),
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return const SettingsScreen();
          //         },
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const NotificationsScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share App'),
            onTap: () {
              const appLink =
                  'https://example.com'; // Replace with your app's link
              Share.share(
                'Check out the Morning & Evening Devotional App! Download it here: $appLink',
                subject: 'Morning & Evening Devotional',
              );
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
