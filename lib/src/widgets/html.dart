import 'package:flutter/material.dart';

class Html extends StatelessWidget {
  const Html({super.key, required this.data, this.style, this.textAlign});

  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;

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
            text: text,
            style: style?.copyWith(fontStyle: FontStyle.italic) ??
                const TextStyle(fontStyle: FontStyle.italic)));
        addSpace = true;
        i++; // Skip the next tag as it has been processed
      } else if (tag.startsWith('sup')) {
        final String text = tags[i + 1];
        textSpans.add(TextSpan(
            text: text,
            style: style?.copyWith(fontSize: 12, fontWeight: FontWeight.bold) ??
                const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)));
        addSpace = true;
        i++; // Skip the next tag as it has been processed
      } else {
        String text = tag;
        if (addSpace) {
          text = ' $text';
          addSpace = false;
        }
        textSpans.add(TextSpan(text: text, style: style));
      }
    }

    return [
      RichText(
        textAlign: textAlign ?? TextAlign.start,
        text: TextSpan(
          children: textSpans,
          style: style ?? const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _parseHtml(),
    );
  }
}
