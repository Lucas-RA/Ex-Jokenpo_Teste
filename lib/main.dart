import 'package:flutter/material.dart';

import 'screens/jokenpo_screen.dart';
import 'services/computer_player.dart';

void main() {
  runApp(const JokenpoApp());
}

class JokenpoApp extends StatelessWidget {
  const JokenpoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JokenpoScreen(computerPlayer: ComputerPlayer()),
    );
  }
}
