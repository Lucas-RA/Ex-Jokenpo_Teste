import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokenpo_teste/screens/jokenpo_screen.dart';
import 'package:jokenpo_teste/services/computer_player.dart';

void main() {
  testWidgets('deve apresentar o título Jokenpô', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: JokenpoScreen(computerPlayer: ComputerPlayer())),
    );

    expect(find.text('Jokenpô'), findsOneWidget);
  });

  testWidgets('deve apresentar as três opções do jogo', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: JokenpoScreen(computerPlayer: ComputerPlayer())),
    );

    expect(find.byKey(const Key('pedra')), findsOneWidget);
    expect(find.byKey(const Key('papel')), findsOneWidget);
    expect(find.byKey(const Key('tesoura')), findsOneWidget);
  });
}
