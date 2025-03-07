import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import 'package:m_e/src/screens/home.dart';
import 'package:m_e/src/providers/settings_provider.dart';
import 'package:m_e/src/providers/is_am.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAm = ref.watch(isAmProvider.notifier);
    final Color? appBarColor;
    final int themeOverride = ref.watch(settingsProvider).themeOverride;
    final Color? themeOverrideBackground =
        ref.watch(settingsProvider).themeOverrideBackground;

    // Check if theme is being overridden
    if (themeOverride != 0) {
      appBarColor = isAm.getBackgroundColor();
    } else {
      appBarColor = themeOverrideBackground;
    }

    final ThemeData theme = ThemeData(
      textTheme: GoogleFonts.latoTextTheme(),
    ).copyWith(
      textTheme: GoogleFonts.latoTextTheme().copyWith(),
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
      ),
    );
    return MaterialApp(
      title: 'M&E',
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
