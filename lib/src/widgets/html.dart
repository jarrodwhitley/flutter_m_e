import 'package:flutter/material.dart';

// the goal of this widget is to parse HTML text and display it as it would appear in a browser
// example usage: Html(data: 'Hello, <em>World</em>! How are you?')
// the above example would display "Hello, World! How are you?" with "World" in italics

class Html extends StatelessWidget {
  const Html({super.key, required this.data});

  final String data;

  // Function that parses the HTML text and returns a list of widgets
  List<Widget> _parseHtml() {
    final List<TextSpan> textSpans = [];
    final List<String> tags = data.split(RegExp(r'<|>'));
    bool addSpace = false;

    for (int i = 0; i < tags.length; i++) {
      final String tag = tags[i];

      if (tag.startsWith('/')) {
        continue;
      }

      if (tag.startsWith('em')) {
        final String text = tags[i + 1];
        textSpans.add(TextSpan(
            text: text, style: const TextStyle(fontStyle: FontStyle.italic)));
        addSpace = true;
        i++; // Skip the next tag as it has been processed
      } else if (tag.startsWith('sup')) {
        final String text = tags[i + 1];
        textSpans.add(TextSpan(
            text: text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)));
        addSpace = true;
        i++; // Skip the next tag as it has been processed
      } else {
        String text = tag;
        if (addSpace) {
          text = ' $text';
          addSpace = false;
        }
        textSpans.add(TextSpan(text: text));
      }
    }

    return [
      RichText(
          text: TextSpan(
              children: textSpans,
              style: const TextStyle(fontSize: 16, color: Colors.black)))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _parseHtml(),
    );
  }
}
