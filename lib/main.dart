import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_e/src/screens/home.dart';

// set up theme
final theme = ThemeData(
  textTheme: GoogleFonts.latoTextTheme(),
).copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 103, 189, 178),
  ),
);

// dark theme
final darkTheme = ThemeData.dark().copyWith(
  textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 55, 30, 83),
  ),
);

void main() {
  runApp(
    MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
