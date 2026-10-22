import 'dart:math';

import 'package:flutter/material.dart';

import '../models/jogada.dart';
import '../services/jokenpo_service.dart';

class JokenpoScreen extends StatefulWidget {
  const JokenpoScreen({super.key});

  @override
  State<JokenpoScreen> createState() => _JokenpoScreenState();
}

class _JokenpoScreenState extends State<JokenpoScreen> {
  final service = JokenpoService();

  String resultado = 'Escolha sua jogada';

  void jogar(Jogada jogador) {
    final jogadas = Jogada.values;

    final computador = jogadas[Random().nextInt(jogadas.length)];

    setState(() {
      resultado = service.verificarResultado(jogador, computador);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jokenpô')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            resultado,
            key: const Key('resultado'),
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                key: const Key('pedra'),
                onPressed: () => jogar(Jogada.pedra),
                child: const Text('Pedra'),
              ),
              ElevatedButton(
                key: const Key('papel'),
                onPressed: () => jogar(Jogada.papel),
                child: const Text('Papel'),
              ),
              ElevatedButton(
                key: const Key('tesoura'),
                onPressed: () => jogar(Jogada.tesoura),
                child: const Text('Tesoura'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
