import 'package:flutter/material.dart';

import 'screens/jokenpo_screen.dart';

void main() {
  runApp(const JokenpoApp());
}

class JokenpoApp extends StatelessWidget {
  const JokenpoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JokenpoScreen(),
    );
  }
}
