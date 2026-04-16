import 'package:flutter/material.dart';

class CuteBackground extends StatelessWidget {
  final Widget child;

  const CuteBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF4FA), // blush pink
            Color(0xFFF2EEFF), // lavender
            Color(0xFFEFFFFA), // minty white
          ],
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
