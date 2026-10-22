import 'dart:math';

import '../models/jogada.dart';
import 'player.dart';

class ComputerPlayer implements Player {
  @override
  Jogada jogar() {
    final jogadas = Jogada.values;

    return jogadas[Random().nextInt(jogadas.length)];
  }
}
