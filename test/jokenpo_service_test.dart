import 'package:flutter_test/flutter_test.dart';
import 'package:jokenpo_teste/services/jokenpo_service.dart';

void main() {
  test('pedra deve vencer tesoura', () {
    // Arrange
    final service = JokenpoService();

    // Act
    final resultado = service.verificarResultado('pedra', 'tesoura');

    // Assert
    expect(resultado, 'Você venceu!');
  });

  test('pedra deve empatar com pedra', () {
    // Arrange
    final service = JokenpoService();

    // Act
    final resultado = service.verificarResultado('pedra', 'pedra');

    // Assert
    expect(resultado, 'Empate');
  });

  test('pedra deve perder para papel', () {
    // Arrange
    final service = JokenpoService();

    // Act
    final resultado = service.verificarResultado('pedra', 'papel');

    // Assert
    expect(resultado, 'Você perdeu!');
  });
}
