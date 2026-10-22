class JokenpoService {
  String verificarResultado(String jogador, String computador) {
    if (jogador == computador) {
      return 'Empate';
    }

    if (jogador == 'pedra' && computador == 'tesoura' ||
        jogador == 'papel' && computador == 'pedra' ||
        jogador == 'tesoura' && computador == 'papel') {
      return 'Você venceu!';
    }

    return 'Você perdeu!';
  }
}
