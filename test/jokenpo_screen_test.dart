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

  testWidgets('deve apresentar o estado inicial da partida', (tester) async {
    final fakeComputer = FakeComputerPlayer(Jogada.tesoura);

    await tester.pumpWidget(
      MaterialApp(home: JokenpoScreen(computerPlayer: fakeComputer)),
    );

    expect(find.text('Selecione uma opção'), findsOneWidget);
    expect(find.text('Aguardando sua jogada'), findsOneWidget);
    expect(find.text('Escolha sua jogada'), findsOneWidget);
  });

  testWidgets('deve mostrar Pedra como jogada do usuário', (tester) async {
    final fakeComputer = FakeComputerPlayer(Jogada.tesoura);

    await tester.pumpWidget(
      MaterialApp(home: JokenpoScreen(computerPlayer: fakeComputer)),
    );

    await tester.tap(find.byKey(const Key('pedra')));
    await tester.pump();

    expect(find.byKey(const Key('usuario_jogada')), findsOneWidget);
    expect(find.text('Pedra'), findsWidgets);
  });

  testWidgets('deve mostrar Tesoura como jogada do computador', (tester) async {
    final fakeComputer = FakeComputerPlayer(Jogada.tesoura);

    await tester.pumpWidget(
      MaterialApp(home: JokenpoScreen(computerPlayer: fakeComputer)),
    );

    await tester.tap(find.byKey(const Key('pedra')));
    await tester.pump();

    expect(find.byKey(const Key('computador_jogada')), findsOneWidget);
    expect(find.text('Tesoura'), findsWidgets);
  });

  testWidgets('pedra deve vencer tesoura e mostrar as duas jogadas', (
    tester,
  ) async {
    final fakeComputer = FakeComputerPlayer(Jogada.tesoura);

    await tester.pumpWidget(
      MaterialApp(home: JokenpoScreen(computerPlayer: fakeComputer)),
    );

    await tester.tap(find.byKey(const Key('pedra')));
    await tester.pump();

    final usuario = tester.widget<Text>(
      find.byKey(const Key('usuario_jogada')),
    );
    final computador = tester.widget<Text>(
      find.byKey(const Key('computador_jogada')),
    );

    expect(usuario.data, 'Pedra');
    expect(computador.data, 'Tesoura');
    expect(find.text('Você venceu!'), findsOneWidget);
  });

  group('Exercícios', () {
    // Exercício 2
    testWidgets('inicialmente deve apresentar "Escolha sua jogada"', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JokenpoScreen(computerPlayer: FakeComputerPlayer(Jogada.pedra)),
        ),
      );

      final resultado = tester.widget<Text>(find.byKey(const Key('resultado')));

      expect(resultado.data, 'Escolha sua jogada');
    });

    // Exercício 3 (os botões da interface final são FilledButton)
    testWidgets('deve existir exatamente três botões na tela', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JokenpoScreen(computerPlayer: FakeComputerPlayer(Jogada.pedra)),
        ),
      );

      expect(find.byType(FilledButton), findsNWidgets(3));
    });

    // Exercício 4: computador sempre escolhe pedra
    testWidgets('pedra x pedra deve empatar', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JokenpoScreen(computerPlayer: FakeComputerPlayer(Jogada.pedra)),
        ),
      );

      await tester.tap(find.byKey(const Key('pedra')));
      await tester.pump();

      expect(find.text('Empate'), findsOneWidget);
    });

    testWidgets('papel x pedra deve vencer', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JokenpoScreen(computerPlayer: FakeComputerPlayer(Jogada.pedra)),
        ),
      );

      await tester.tap(find.byKey(const Key('papel')));
      await tester.pump();

      expect(find.text('Você venceu!'), findsOneWidget);
    });

    testWidgets('tesoura x pedra deve perder', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JokenpoScreen(computerPlayer: FakeComputerPlayer(Jogada.pedra)),
        ),
      );

      await tester.tap(find.byKey(const Key('tesoura')));
      await tester.pump();

      expect(find.text('Você perdeu!'), findsOneWidget);
    });

    // Exercício 5
    testWidgets('deve mostrar "Você escolheu" e "Computador escolheu"', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JokenpoScreen(
            computerPlayer: FakeComputerPlayer(Jogada.tesoura),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('pedra')));
      await tester.pump();

      expect(find.text('Você escolheu: Pedra'), findsOneWidget);
      expect(find.text('Computador escolheu: Tesoura'), findsOneWidget);
    });
  });

  group('Placar na tela', () {
    testWidgets('deve contar as vitórias do jogador', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JokenpoScreen(
            computerPlayer: FakeComputerPlayer(Jogada.tesoura),
          ),
        ),
      );

      expect(find.text('Jogador: 0'), findsOneWidget);

      await tester.tap(find.byKey(const Key('pedra')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('pedra')));
      await tester.pump();

      expect(find.text('Jogador: 2'), findsOneWidget);
      expect(find.text('Computador: 0'), findsOneWidget);
      expect(find.text('Empates: 0'), findsOneWidget);
    });

    testWidgets('deve zerar o placar ao tocar em resetar', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JokenpoScreen(
            computerPlayer: FakeComputerPlayer(Jogada.tesoura),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('papel')));
      await tester.pump();

      expect(find.text('Computador: 1'), findsOneWidget);

      await tester.tap(find.byKey(const Key('resetar')));
      await tester.pump();

      expect(find.text('Computador: 0'), findsOneWidget);
      expect(find.text('Escolha sua jogada'), findsOneWidget);
    });
  });
}
