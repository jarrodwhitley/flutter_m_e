import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:m_e/src/models/sermon.dart';
import 'package:m_e/src/providers/bookmarks.dart';
import 'package:m_e/src/providers/is_am_provider.dart';
import 'package:m_e/src/providers/sermon.dart';
import 'package:m_e/src/providers/settings_provider.dart';

class MeAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const MeAppBar(
      {super.key,
      this.sermon,
      required this.activeScreenTitle,
      required this.isBookmarked,
      required this.bookmarkToggle});

  final Sermon? sermon;
  final String activeScreenTitle;
  final bool isBookmarked;
  final void Function(Sermon) bookmarkToggle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  MeAppBarState createState() => MeAppBarState();
}

class MeAppBarState extends ConsumerState<MeAppBar> {
  @override
  Widget build(BuildContext context) {
    final sermon = ref.watch(sermonProvider);
    var isBookmarked =
        sermon != null && ref.watch(bookmarksProvider).contains(sermon.id);
    final isAm = ref.watch(isAmProvider.notifier);
    final int colorThemeOverride =
        ref.watch(settingsProvider).colorThemeOverride;
    final Color? colorThemeOverrideBackground =
        ref.watch(settingsProvider).colorThemeOverrideBackground;

    return AppBar(
      actions: widget.sermon != null
          ? [
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                ),
                onPressed: () {
                  widget.bookmarkToggle(widget.sermon!);
                },
              ),
            ]
          : null,
      flexibleSpace: Container(
        color: colorThemeOverride > 0
            ? colorThemeOverrideBackground
            : isAm.getBackgroundColor(),
      ),
      elevation: 0,
      title: Text(
        widget.activeScreenTitle,
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(color: Colors.white),
      ),
      iconTheme: const IconThemeData(
        color: Colors
            .white, // Set the color of the drawer icon and back arrow to white
      ),
      backgroundColor: colorThemeOverride > 0
          ? colorThemeOverrideBackground
          : isAm.getBackgroundColor(),
    );
  }
}
