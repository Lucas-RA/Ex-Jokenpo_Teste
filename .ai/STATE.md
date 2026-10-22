# Estado

## Atual
- T-001 — AGUARDANDO_VALIDACAO_CRUZADA (executora: claude). App completo do tutorial + exercícios + placar + README.
- Pendência: validação cruzada pelo Codex (escopo: `lib/`, `test/`, `README.md`, `assets/images/`, `pubspec.yaml`).
- Observação: o commit `c346678` (etapa-16-red) falha de propósito (etapa RED do TDD); todos os outros passam.

### 2026-10-21 22:00 — claude — T-001 — EM_ANDAMENTO
- Objetivo: montar o app do tutorial em commits por etapa e documentar no README.
- Arquivos: `.ai/`, `AGENTS.md`, `CLAUDE.md`.
- Validação: base inicial (template) — `flutter test` passou (1 teste).
- Próximo: commits das etapas do tutorial.

### 2026-10-21 22:20 — claude — T-001 — EM_ANDAMENTO
- Objetivo: etapas 01–14 do tutorial (tela única → service → testes unitários → enum → widget tests → Player/DI → Fake → UI final).
- Arquivos: `lib/main.dart`, `lib/models/jogada.dart`, `lib/services/*`, `lib/screens/jokenpo_screen.dart`, `test/*`, `assets/images/*`, `pubspec.yaml`.
- Validação: `flutter analyze` sem issues e `flutter test` verde em cada commit (18 testes na etapa 14).
- Próximo: exercícios 2–5, desafio do placar via TDD, README.

### 2026-10-21 22:50 — claude — T-001 — AUTOVALIDADA → AGUARDANDO_VALIDACAO_CRUZADA
- Objetivo: exercícios 2–5 (etapa 15), placar via TDD (etapas 16–18) e README com o passo a passo.
- Arquivos: `lib/models/placar.dart`, `lib/screens/jokenpo_screen.dart`, `test/placar_test.dart`, `test/jokenpo_screen_test.dart`, `README.md`.
- Validação: `flutter analyze` — sem issues; `flutter test` — 31 testes passando; `flutter build web` + teste manual no navegador (375x812): jogada, resultado, placar e imagens OK.
- Próximo: validação cruzada (outra IA). Não aprovar pela executora.
