import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: JokenpoScreen()),
  );
}

class JokenpoScreen extends StatefulWidget {
  const JokenpoScreen({super.key});

  @override
  State<JokenpoScreen> createState() => _JokenpoScreenState();
}

class _JokenpoScreenState extends State<JokenpoScreen> {
  String resultado = 'Escolha sua jogada';

  void jogar(String jogador) {
    final jogadas = ['pedra', 'papel', 'tesoura'];

    final computador = jogadas[Random().nextInt(jogadas.length)];

    if (jogador == computador) {
      resultado = 'Empate';
    } else if (jogador == 'pedra' && computador == 'tesoura' ||
        jogador == 'papel' && computador == 'pedra' ||
        jogador == 'tesoura' && computador == 'papel') {
      resultado = 'Você venceu!';
    } else {
      resultado = 'Você perdeu!';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jokenpô')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(resultado, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => jogar('pedra'),
                child: const Text('Pedra'),
              ),
              ElevatedButton(
                onPressed: () => jogar('papel'),
                child: const Text('Papel'),
              ),
              ElevatedButton(
                onPressed: () => jogar('tesoura'),
                child: const Text('Tesoura'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
