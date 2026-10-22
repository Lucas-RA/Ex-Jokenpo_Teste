import 'package:flutter/material.dart';

import '../models/jogada.dart';
import '../services/jokenpo_service.dart';
import '../services/player.dart';

class JokenpoScreen extends StatefulWidget {
  final Player computerPlayer;

  const JokenpoScreen({super.key, required this.computerPlayer});

  @override
  State<JokenpoScreen> createState() => _JokenpoScreenState();
}

class _JokenpoScreenState extends State<JokenpoScreen> {
  final JokenpoService service = JokenpoService();

  Jogada? jogadaUsuario;
  Jogada? jogadaComputador;

  String resultado = 'Escolha sua jogada';

  void jogar(Jogada jogador) {
    final computador = widget.computerPlayer.jogar();

    setState(() {
      jogadaUsuario = jogador;
      jogadaComputador = computador;

      resultado = service.verificarResultado(jogador, computador);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jokenpô'), centerTitle: true),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _JogadaSelecionada(
                        titulo: 'Sua jogada',
                        jogada: jogadaUsuario,
                        placeholder: 'Selecione uma opção',
                        keyPrefix: 'usuario',
                      ),

                      const SizedBox(height: 32),

                      _JogadaSelecionada(
                        titulo: 'Computador',
                        jogada: jogadaComputador,
                        placeholder: 'Aguardando sua jogada',
                        keyPrefix: 'computador',
                      ),

                      const SizedBox(height: 32),

                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              resultado,
                              key: const Key('resultado'),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: _JogadaButton(
                  key: const Key('pedra'),
                  jogada: Jogada.pedra,
                  onPressed: () => jogar(Jogada.pedra),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _JogadaButton(
                  key: const Key('papel'),
                  jogada: Jogada.papel,
                  onPressed: () => jogar(Jogada.papel),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _JogadaButton(
                  key: const Key('tesoura'),
                  jogada: Jogada.tesoura,
                  onPressed: () => jogar(Jogada.tesoura),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JogadaSelecionada extends StatelessWidget {
  final String titulo;
  final Jogada? jogada;
  final String placeholder;
  final String keyPrefix;

  const _JogadaSelecionada({
    required this.titulo,
    required this.jogada,
    required this.placeholder,
    required this.keyPrefix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(titulo, style: Theme.of(context).textTheme.titleLarge),

        const SizedBox(height: 12),

        if (jogada != null) ...[
          Image.asset(
            jogada!.imagem,
            key: Key('${keyPrefix}_imagem'),
            width: 120,
            height: 120,
          ),

          const SizedBox(height: 8),

          Text(
            jogada!.titulo,
            key: Key('${keyPrefix}_jogada'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ] else
          Text(placeholder, key: Key('${keyPrefix}_placeholder')),
      ],
    );
  }
}

class _JogadaButton extends StatelessWidget {
  final Jogada jogada;
  final VoidCallback onPressed;

  const _JogadaButton({
    super.key,
    required this.jogada,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(jogada.imagem, width: 40, height: 40),

          const SizedBox(height: 6),

          Text(jogada.titulo, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
