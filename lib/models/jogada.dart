enum Jogada {
  pedra,
  papel,
  tesoura;

  String get titulo {
    switch (this) {
      case Jogada.pedra:
        return 'Pedra';
      case Jogada.papel:
        return 'Papel';
      case Jogada.tesoura:
        return 'Tesoura';
    }
  }

  String get imagem {
    switch (this) {
      case Jogada.pedra:
        return 'assets/images/pedra.png';
      case Jogada.papel:
        return 'assets/images/papel.png';
      case Jogada.tesoura:
        return 'assets/images/tesoura.png';
    }
  }
}
