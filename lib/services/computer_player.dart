import 'dart:math';

import '../models/jogada.dart';

class ComputerPlayer {
  Jogada jogar() {
    final jogadas = Jogada.values;

    return jogadas[Random().nextInt(jogadas.length)];
  }
}
