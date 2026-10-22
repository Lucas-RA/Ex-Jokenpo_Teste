import '../models/jogada.dart';

class JokenpoService {
  String verificarResultado(Jogada jogador, Jogada computador) {
    if (jogador == computador) {
      return 'Empate';
    }

    if (_jogadorVence(jogador, computador)) {
      return 'Você venceu!';
    }

    return 'Você perdeu!';
  }

  bool _jogadorVence(Jogada jogador, Jogada computador) {
    return jogador == Jogada.pedra && computador == Jogada.tesoura ||
        jogador == Jogada.papel && computador == Jogada.pedra ||
        jogador == Jogada.tesoura && computador == Jogada.papel;
  }
}
