class Placar {
  int jogador = 0;
  int computador = 0;
  int empates = 0;

  void registrarVitoriaJogador() {
    jogador++;
  }

  void registrarVitoriaComputador() {
    computador++;
  }

  void registrarEmpate() {
    empates++;
  }

  void resetar() {
    jogador = 0;
    computador = 0;
    empates = 0;
  }
}
