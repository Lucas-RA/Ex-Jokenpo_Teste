# Estado

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
