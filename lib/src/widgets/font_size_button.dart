import 'package:flutter/material.dart';

class FontSizeButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const FontSizeButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.grey),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
