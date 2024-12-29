import 'package:flutter/material.dart';
import 'src/screens/home.dart';

// set up theme
final theme = ThemeData().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 103, 189, 178),
  ),
);

// dark theme
final darkTheme = ThemeData.dark().copyWith(
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
      home: MainScreen(),
    );
  }
}
