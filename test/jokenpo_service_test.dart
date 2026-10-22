import 'package:flutter_test/flutter_test.dart';
import 'package:jokenpo_teste/services/jokenpo_service.dart';

void main() {
  test('pedra deve vencer tesoura', () {
    final service = JokenpoService();

    final resultado = service.verificarResultado('pedra', 'tesoura');

    expect(resultado, 'Você venceu!');
  });
}
