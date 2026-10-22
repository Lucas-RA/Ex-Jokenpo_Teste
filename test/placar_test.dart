import 'package:flutter_test/flutter_test.dart';
import 'package:jokenpo_teste/models/placar.dart';

void main() {
  test('deve incrementar vitória do jogador', () {
    // Arrange
    final placar = Placar();

    // Act
    placar.registrarVitoriaJogador();

    // Assert
    expect(placar.jogador, 1);
    expect(placar.computador, 0);
    expect(placar.empates, 0);
  });
}
