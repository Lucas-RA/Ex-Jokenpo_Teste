import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokenpo_teste/models/jogada.dart';
import 'package:jokenpo_teste/screens/jokenpo_screen.dart';
import 'package:jokenpo_teste/services/player.dart';

class FakeComputerPlayer implements Player {
  final Jogada jogada;

  FakeComputerPlayer(this.jogada);

  @override
  Jogada jogar() {
    return jogada;
  }
}

void main() {
  testWidgets('deve apresentar o título Jokenpô', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: JokenpoScreen(computerPlayer: FakeComputerPlayer(Jogada.pedra)),
      ),
    );

    expect(find.text('Jokenpô'), findsOneWidget);
  });

  testWidgets('deve apresentar as três opções do jogo', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: JokenpoScreen(computerPlayer: FakeComputerPlayer(Jogada.pedra)),
      ),
    );

    expect(find.byKey(const Key('pedra')), findsOneWidget);
    expect(find.byKey(const Key('papel')), findsOneWidget);
    expect(find.byKey(const Key('tesoura')), findsOneWidget);
  });

  testWidgets('jogador deve vencer quando escolher pedra '
      'e computador escolher tesoura', (tester) async {
    final fakeComputer = FakeComputerPlayer(Jogada.tesoura);

    await tester.pumpWidget(
      MaterialApp(home: JokenpoScreen(computerPlayer: fakeComputer)),
    );

    await tester.tap(find.byKey(const Key('pedra')));
    await tester.pump();

    expect(find.text('Você venceu!'), findsOneWidget);
  });

  testWidgets('jogador deve perder quando escolher pedra '
      'e computador escolher papel', (tester) async {
    final fakeComputer = FakeComputerPlayer(Jogada.papel);

    await tester.pumpWidget(
      MaterialApp(home: JokenpoScreen(computerPlayer: fakeComputer)),
    );

    await tester.tap(find.byKey(const Key('pedra')));
    await tester.pump();

    expect(find.text('Você perdeu!'), findsOneWidget);
  });

  testWidgets('deve empatar quando jogador e computador '
      'escolherem pedra', (tester) async {
    final fakeComputer = FakeComputerPlayer(Jogada.pedra);

    await tester.pumpWidget(
      MaterialApp(home: JokenpoScreen(computerPlayer: fakeComputer)),
    );

    await tester.tap(find.byKey(const Key('pedra')));
    await tester.pump();

    expect(find.text('Empate'), findsOneWidget);
  });
}
