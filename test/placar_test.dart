import 'package:flutter_test/flutter_test.dart';
import 'package:jokenpo_teste/models/placar.dart';

void main() {
  late Placar placar;

  setUp(() {
    placar = Placar();
  });

  test('deve começar zerado', () {
    expect(placar.jogador, 0);
    expect(placar.computador, 0);
    expect(placar.empates, 0);
  });

  test('deve incrementar vitória do jogador', () {
    placar.registrarVitoriaJogador();

    expect(placar.jogador, 1);
    expect(placar.computador, 0);
    expect(placar.empates, 0);
  });

  test('deve incrementar vitória do computador', () {
    placar.registrarVitoriaComputador();

    expect(placar.jogador, 0);
    expect(placar.computador, 1);
    expect(placar.empates, 0);
  });

  test('deve incrementar empate', () {
    placar.registrarEmpate();

    expect(placar.jogador, 0);
    expect(placar.computador, 0);
    expect(placar.empates, 1);
  });

  test('deve resetar o placar', () {
    // Arrange
    placar.registrarVitoriaJogador();
    placar.registrarVitoriaComputador();
    placar.registrarEmpate();

    // Act
    placar.resetar();

    // Assert
    expect(placar.jogador, 0);
    expect(placar.computador, 0);
    expect(placar.empates, 0);
  });
}
