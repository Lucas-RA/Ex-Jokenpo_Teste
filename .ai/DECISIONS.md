# Decisões

- **D-001 — Nome do pacote mantido como `jokenpo_teste`.** Motivo: o projeto já foi criado com esse nome. Alternativa: renomear para `jokenpo_tests` (como no tutorial) — descartada para não mexer em android/ios. Impacto: imports usam `package:jokenpo_teste/...`.
- **D-002 — Imagens das jogadas geradas localmente (PNG simples).** Motivo: o tutorial pede `assets/images/{pedra,papel,tesoura}.png` sem fornecê-las. Impacto: podem ser trocadas por quaisquer PNGs com o mesmo nome.
