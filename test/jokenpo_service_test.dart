import 'package:flutter_test/flutter_test.dart';
import 'package:jokenpo_teste/models/jogada.dart';
import 'package:jokenpo_teste/services/jokenpo_service.dart';

void main() {
  late JokenpoService service;

  setUp(() {
    service = JokenpoService();
  });

  group('Empates', () {
    test('pedra x pedra', () {
      expect(service.verificarResultado(Jogada.pedra, Jogada.pedra), 'Empate');
    });

    test('papel x papel', () {
      expect(service.verificarResultado(Jogada.papel, Jogada.papel), 'Empate');
    });

    test('tesoura x tesoura', () {
      expect(
        service.verificarResultado(Jogada.tesoura, Jogada.tesoura),
        'Empate',
      );
    });
  });

  group('Vitórias', () {
    test('pedra vence tesoura', () {
      expect(
        service.verificarResultado(Jogada.pedra, Jogada.tesoura),
        'Você venceu!',
      );
    });

    test('papel vence pedra', () {
      expect(
        service.verificarResultado(Jogada.papel, Jogada.pedra),
        'Você venceu!',
      );
    });

    test('tesoura vence papel', () {
      expect(
        service.verificarResultado(Jogada.tesoura, Jogada.papel),
        'Você venceu!',
      );
    });
  });

  group('Derrotas', () {
    test('pedra perde para papel', () {
      expect(
        service.verificarResultado(Jogada.pedra, Jogada.papel),
        'Você perdeu!',
      );
    });

    test('papel perde para tesoura', () {
      expect(
        service.verificarResultado(Jogada.papel, Jogada.tesoura),
        'Você perdeu!',
      );
    });

    test('tesoura perde para pedra', () {
      expect(
        service.verificarResultado(Jogada.tesoura, Jogada.pedra),
        'Você perdeu!',
      );
    });
  });
}
