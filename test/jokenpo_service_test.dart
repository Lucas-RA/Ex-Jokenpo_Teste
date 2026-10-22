import 'package:flutter_test/flutter_test.dart';
import 'package:jokenpo_teste/services/jokenpo_service.dart';

void main() {
  late JokenpoService service;

  setUp(() {
    service = JokenpoService();
  });

  group('Empates', () {
    test('pedra x pedra', () {
      expect(service.verificarResultado('pedra', 'pedra'), 'Empate');
    });

    test('papel x papel', () {
      expect(service.verificarResultado('papel', 'papel'), 'Empate');
    });

    test('tesoura x tesoura', () {
      expect(service.verificarResultado('tesoura', 'tesoura'), 'Empate');
    });
  });

  group('Vitórias', () {
    test('pedra vence tesoura', () {
      expect(service.verificarResultado('pedra', 'tesoura'), 'Você venceu!');
    });

    test('papel vence pedra', () {
      expect(service.verificarResultado('papel', 'pedra'), 'Você venceu!');
    });

    test('tesoura vence papel', () {
      expect(service.verificarResultado('tesoura', 'papel'), 'Você venceu!');
    });
  });

  group('Derrotas', () {
    test('pedra perde para papel', () {
      expect(service.verificarResultado('pedra', 'papel'), 'Você perdeu!');
    });

    test('papel perde para tesoura', () {
      expect(service.verificarResultado('papel', 'tesoura'), 'Você perdeu!');
    });

    test('tesoura perde para pedra', () {
      expect(service.verificarResultado('tesoura', 'pedra'), 'Você perdeu!');
    });
  });
}
