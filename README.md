# Jokenpô com Testes em Flutter

Exercício de **Pedra, Papel e Tesoura** feito para aprender testes em Flutter: testes unitários, testes de widget, TDD, injeção de dependência e Fake.

Baseado no tutorial do professor Heider Lopes: [Testes em Flutter com Jokenpô (TDD)](https://www.heiderlopes.com.br/flutter/tutoriais/flutter-testes-jokenpo-com-tdd-v2).

A ideia é **começar simples (tudo dentro da tela) e ir melhorando aos poucos**. Cada etapa abaixo é **um commit**, então dá para ver exatamente o que mudou em cada passo.

---

## Sumário

- [Como rodar](#como-rodar)
- [Como navegar pelos commits](#como-navegar-pelos-commits)
- [Conceitos básicos antes de começar](#conceitos-básicos-antes-de-começar)
- [Passo a passo](#passo-a-passo)
  - [Etapa 0 — Criando o projeto](#etapa-0--criando-o-projeto)
  - [Etapa 1 — Tudo dentro da tela](#etapa-1--tudo-dentro-da-tela)
  - [Etapa 2 — Separando a regra do jogo](#etapa-2--separando-a-regra-do-jogo)
  - [Etapa 3 — Primeiro teste unitário](#etapa-3--primeiro-teste-unitário)
  - [Etapa 4 — Arrange, Act e Assert](#etapa-4--arrange-act-e-assert)
  - [Etapa 5 — As 9 combinações com group() e setUp()](#etapa-5--as-9-combinações-com-group-e-setup)
  - [Etapa 6 — Trocando String por enum](#etapa-6--trocando-string-por-enum)
  - [Etapa 7 — TDD: Red, Green, Refactor](#etapa-7--tdd-red-green-refactor)
  - [Etapa 8 — Imagens e propriedades no enum](#etapa-8--imagens-e-propriedades-no-enum)
  - [Etapa 9 — Tela em arquivo próprio e Keys](#etapa-9--tela-em-arquivo-próprio-e-keys)
  - [Etapa 10 — Primeiros testes de widget](#etapa-10--primeiros-testes-de-widget)
  - [Etapa 11 — O problema do Random e o ComputerPlayer](#etapa-11--o-problema-do-random-e-o-computerplayer)
  - [Etapa 12 — Abstração Player e injeção de dependência](#etapa-12--abstração-player-e-injeção-de-dependência)
  - [Etapa 13 — Fake: testes previsíveis](#etapa-13--fake-testes-previsíveis)
  - [Etapa 14 — Interface final](#etapa-14--interface-final)
  - [Etapa 15 — Exercícios do tutorial](#etapa-15--exercícios-do-tutorial)
  - [Etapas 16 a 18 — Desafio: placar com TDD](#etapas-16-a-18--desafio-placar-com-tdd)
- [Estrutura final](#estrutura-final)
- [Resumo: evolução da arquitetura](#resumo-evolução-da-arquitetura)
- [Colinha de testes](#colinha-de-testes)

---

## Como rodar

```bash
flutter pub get
```

```bash
flutter run
```

```bash
flutter test
```

`flutter test` roda todos os testes da pasta `test/` (ao final são 31 testes).

## Como navegar pelos commits

Ver a lista de etapas:

```bash
git log --oneline --reverse
```

Voltar o projeto para uma etapa (troque o código pelo da tabela):

```bash
git checkout 2f701ca
```

Voltar para a versão final:

```bash
git checkout main
```

| Etapa | Commit | O que acontece |
|---|---|---|
| 1 | `ebd8e27` | App funcionando, tudo dentro da tela |
| 2 | `2f701ca` | Regra do jogo vai para `JokenpoService` |
| 3 | `5bd7601` | Primeiro teste unitário |
| 4 | `532d5c3` | Padrão Arrange / Act / Assert |
| 5 | `a4aa319` | 9 combinações com `group()` e `setUp()` |
| 6 | `d6cb0d4` | `String` → `enum Jogada` |
| 7 | `31a48f5` | Refactor do TDD: `_jogadorVence()` |
| 8 | `1a87cb3` | Imagens + `titulo`/`imagem` no enum |
| 9 | `2b7e948` | Tela em `screens/` + `Key`s |
| 10 | `617bb02` | Primeiros testes de widget |
| 11 | `aa51cb6` | `ComputerPlayer` (Random sai da tela) |
| 12 | `1fefb69` | `Player` + injeção de dependência |
| 13 | `9c9b552` | `FakeComputerPlayer` + testes de partida |
| 14 | `82317b9` | Interface final |
| 15 | `3ed1e1b` | Exercícios 2 a 5 |
| 16 | `c346678` | **RED**: teste do placar (falha de propósito) |
| 16 | `294dbe9` | **GREEN**: `Placar` mínimo |
| 17 | `40cfd52` | Placar completo via TDD |
| 18 | `0dd44c3` | Placar na tela |

> Os commits `chore:` só mexem na pasta `.ai/` (anotações do projeto) e podem ser ignorados.

---

## Conceitos básicos antes de começar

| Conceito | Em uma frase |
|---|---|
| **Widget** | Tudo na tela do Flutter é um widget (texto, botão, coluna, a tela inteira). |
| **StatelessWidget** | Widget que **não muda** depois de desenhado. |
| **StatefulWidget** | Widget que **guarda estado** (valores que mudam, como o resultado do jogo). |
| **setState()** | Avisa o Flutter: "mudei o estado, desenhe a tela de novo". |
| **Teste unitário** | Testa um pedaço pequeno de código (uma classe, um método) sem abrir a tela. |
| **Teste de widget** | Monta a tela "de mentira" na memória, clica nos botões e confere o que aparece. |
| **TDD** | Escrever o teste **antes** do código. |

**Por que testar?** Para ter certeza, de forma automática, que a regra está certa — e que continua certa depois de mexer no código.

---

## Passo a passo

### Etapa 0 — Criando o projeto

```bash
flutter create jokenpo_teste
```

Isso cria a estrutura básica. O que importa para nós:

```
lib/main.dart          ← código do app
test/widget_test.dart  ← teste de exemplo (vamos apagar)
pubspec.yaml           ← dependências e assets
```

Apagamos `test/widget_test.dart`, porque ele testa o app contador de exemplo, e vamos escrever os nossos testes.

> No tutorial o projeto se chama `jokenpo_tests`. Aqui se chama `jokenpo_teste`, então os imports ficam `package:jokenpo_teste/...`.

---

### Etapa 1 — Tudo dentro da tela

**Objetivo:** fazer o jogo funcionar, do jeito mais simples possível.

**Lógica do jogo (algoritmo):**

1. O jogador escolhe uma jogada (clicando no botão).
2. O computador sorteia uma jogada.
3. Compara:
   - Se forem **iguais** → **empate**.
   - Se for uma das **3 combinações de vitória** → **venceu**.
   - **Qualquer outro caso** → **perdeu**.

As 3 combinações de vitória são:

```
pedra   vence tesoura   (pedra quebra a tesoura)
papel   vence pedra     (papel embrulha a pedra)
tesoura vence papel     (tesoura corta o papel)
```

> **Dica de lógica:** não precisamos listar as 9 combinações. Primeiro tratamos o empate, depois as 3 vitórias. O que sobrar **só pode ser derrota**.

**Sorteio do computador:**

```dart
final jogadas = ['pedra', 'papel', 'tesoura'];
final computador = jogadas[Random().nextInt(jogadas.length)];
```

- `Random().nextInt(3)` devolve `0`, `1` ou `2`.
- Usamos esse número como **índice** da lista → `jogadas[0]` é `'pedra'`, e assim por diante.
- `Random` vem de `import 'dart:math';`.

**A regra dentro da tela:**

```dart
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
```

- `&&` = **E** (as duas coisas precisam ser verdade).
- `||` = **OU** (basta uma ser verdade).
- O `&&` é avaliado antes do `||`, então cada linha vira um "par" de condições.
- `setState(() {})` redesenha a tela com o novo `resultado`.

**A tela:** um `Scaffold` (estrutura com barra de título), uma `Column` com o texto do resultado e uma `Row` com 3 `ElevatedButton`. Cada botão chama `jogar('pedra')`, `jogar('papel')` ou `jogar('tesoura')`.

**O problema:** a tela faz **tudo** — interface, estado, sorteio e regra. Para testar "pedra vence tesoura?" teríamos que abrir a tela e torcer para o Random ajudar. Por isso vamos separar.

```
JokenpoScreen
├── Interface
├── Estado da tela
├── Random
└── Regra do jogo     ← vamos tirar daqui
```

---

### Etapa 2 — Separando a regra do jogo

**Objetivo:** tirar a regra da tela e colocar numa classe só dela.

Arquivo `lib/services/jokenpo_service.dart`:

```dart
class JokenpoService {
  String verificarResultado(String jogador, String computador) {
    if (jogador == computador) {
      return 'Empate';
    }

    if (jogador == 'pedra' && computador == 'tesoura' ||
        jogador == 'papel' && computador == 'pedra' ||
        jogador == 'tesoura' && computador == 'papel') {
      return 'Você venceu!';
    }

    return 'Você perdeu!';
  }
}
```

**O que mudou:**

- A classe **recebe** as duas jogadas e **devolve** o resultado. Ela não sabe nada de tela, botão ou Random.
- Usamos `return` logo que achamos a resposta ("retorno antecipado"). Por isso não precisa de `else`.

Na tela, o `jogar` fica só com o sorteio e a chamada do serviço:

```dart
final service = JokenpoService();

void jogar(String jogador) {
  final jogadas = ['pedra', 'papel', 'tesoura'];
  final computador = jogadas[Random().nextInt(jogadas.length)];

  setState(() {
    resultado = service.verificarResultado(jogador, computador);
  });
}
```

Agora a regra pode ser testada **sem abrir a tela**.

---

### Etapa 3 — Primeiro teste unitário

Arquivo `test/jokenpo_service_test.dart` (arquivos de teste terminam com `_test.dart`):

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:jokenpo_teste/services/jokenpo_service.dart';

void main() {
  test('pedra deve vencer tesoura', () {
    final service = JokenpoService();

    final resultado = service.verificarResultado('pedra', 'tesoura');

    expect(resultado, 'Você venceu!');
  });
}
```

- **`test('descrição', () { ... })`** → um cenário de teste. A descrição diz **o que o teste garante**.
- **`expect(valorObtido, valorEsperado)`** → compara. Lê-se: "espero que `resultado` seja `'Você venceu!'`". Se não for, o teste falha.

Rode `flutter test` → `+1: All tests passed!`

---

### Etapa 4 — Arrange, Act e Assert

Um jeito simples de organizar qualquer teste em 3 partes:

| Parte | Significado | No exemplo |
|---|---|---|
| **Arrange** | Preparar | criar o `JokenpoService` |
| **Act** | Agir | chamar `verificarResultado` |
| **Assert** | Conferir | `expect(...)` |

```dart
test('pedra deve vencer tesoura', () {
  // Arrange
  final service = JokenpoService();

  // Act
  final resultado = service.verificarResultado('pedra', 'tesoura');

  // Assert
  expect(resultado, 'Você venceu!');
});
```

Nessa etapa também foram criados os testes de **empate** (pedra x pedra) e **derrota** (pedra x papel).

---

### Etapa 5 — As 9 combinações com group() e setUp()

O jogo tem **3 × 3 = 9 combinações**:

| Jogador | Computador | Resultado |
|---|---|---|
| Pedra | Pedra | Empate |
| Pedra | Papel | Derrota |
| Pedra | Tesoura | Vitória |
| Papel | Pedra | Vitória |
| Papel | Papel | Empate |
| Papel | Tesoura | Derrota |
| Tesoura | Pedra | Derrota |
| Tesoura | Papel | Vitória |
| Tesoura | Tesoura | Empate |

Para testar todas sem bagunça:

- **`group('nome', () { ... })`** → junta testes parecidos (Empates, Vitórias, Derrotas). No resultado do teste aparece `Vitórias pedra vence tesoura`.
- **`setUp(() { ... })`** → roda **antes de cada teste**. Usamos para criar um `JokenpoService` novo toda vez, sem repetir código.
- **`late`** → "essa variável vai receber valor depois" (no `setUp`).

```dart
void main() {
  late JokenpoService service;

  setUp(() {
    service = JokenpoService();
  });

  group('Vitórias', () {
    test('pedra vence tesoura', () {
      expect(service.verificarResultado('pedra', 'tesoura'), 'Você venceu!');
    });
    // papel vence pedra, tesoura vence papel...
  });

  // group('Empates', ...) e group('Derrotas', ...)
}
```

---

### Etapa 6 — Trocando String por enum

**Problema:** com `String`, nada impede de escrever errado: `'pedraa'`, `'PEDRA'`, `'Pedra'`. O código compila e a regra dá resultado errado.

**Solução:** um `enum` — uma lista fechada de opções.

`lib/models/jogada.dart`:

```dart
enum Jogada { pedra, papel, tesoura }
```

Agora só existem `Jogada.pedra`, `Jogada.papel` e `Jogada.tesoura`. Se você digitar errado, **o código nem compila** — o erro aparece na hora, não durante o jogo.

Mudanças:

- `JokenpoService.verificarResultado(Jogada jogador, Jogada computador)`.
- Testes: `service.verificarResultado(Jogada.pedra, Jogada.tesoura)`.
- Tela: `jogar(Jogada.pedra)` e o sorteio vira:

```dart
final jogadas = Jogada.values; // [pedra, papel, tesoura]
final computador = jogadas[Random().nextInt(jogadas.length)];
```

`Jogada.values` é a lista com todos os valores do enum — não precisamos mais escrever a lista na mão.

---

### Etapa 7 — TDD: Red, Green, Refactor

**TDD (Test-Driven Development)** = escrever o teste **antes** do código.

```
RED       → escreve um teste que FALHA (a funcionalidade ainda não existe)
GREEN     → escreve o MÍNIMO de código para o teste passar
REFACTOR  → melhora o código, sem mudar o comportamento (os testes continuam verdes)
```

E repete, **um requisito por vez** (não é "escrever todos os testes primeiro").

**Como a regra do Jokenpô seria construída com TDD:**

| Ciclo | Teste novo (RED) | Código mínimo (GREEN) |
|---|---|---|
| 1 | pedra vence tesoura | `return 'Você venceu!';` (sempre!) |
| 2 | pedra x pedra = empate | `if (jogador == computador) return 'Empate';` |
| 3 | pedra perde para papel | `if (pedra && tesoura) return 'Você venceu!'; return 'Você perdeu!';` |
| 4 | papel vence pedra | adiciona `\|\| papel && pedra` |
| 5 | tesoura vence papel | adiciona `\|\| tesoura && papel` |

> Parece estranho no ciclo 1 retornar sempre "Você venceu!", mas é isso mesmo: só existe **um** teste, e ele passa. O próximo teste é que obriga o código a evoluir.

**O REFACTOR (o que este commit faz):** com todos os testes verdes, deixamos o código mais legível separando a condição de vitória num método:

```dart
class JokenpoService {
  String verificarResultado(Jogada jogador, Jogada computador) {
    if (jogador == computador) {
      return 'Empate';
    }

    if (_jogadorVence(jogador, computador)) {
      return 'Você venceu!';
    }

    return 'Você perdeu!';
  }

  bool _jogadorVence(Jogada jogador, Jogada computador) {
    return jogador == Jogada.pedra && computador == Jogada.tesoura ||
        jogador == Jogada.papel && computador == Jogada.pedra ||
        jogador == Jogada.tesoura && computador == Jogada.papel;
  }
}
```

- O `_` no começo do nome deixa o método **privado** (só usado dentro desse arquivo).
- Ele devolve `bool` (`true`/`false`): "o jogador venceu?".
- Rodamos `flutter test` de novo → continua tudo verde. É assim que sabemos que o refactor não quebrou nada.

---

### Etapa 8 — Imagens e propriedades no enum

1. Crie `assets/images/` com `pedra.png`, `papel.png` e `tesoura.png`.
2. Registre no `pubspec.yaml` (atenção à indentação):

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/
```

3. Rode `flutter pub get`.

Para não espalhar `if`s de texto e imagem pela tela, colocamos isso **no próprio enum**:

```dart
enum Jogada {
  pedra,
  papel,
  tesoura;   // ← ponto e vírgula, porque vêm métodos depois

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
    switch (this) { /* 'assets/images/pedra.png' ... */ }
  }
}
```

- **`get`** cria uma propriedade calculada: usamos `jogada.titulo` e `jogada.imagem` sem parênteses.
- **`this`** é a própria jogada (`Jogada.pedra`, por exemplo).
- O `switch` cobre todos os casos do enum; se faltar um, o Dart avisa.

> As imagens deste repositório são desenhos simples gerados para o exercício. Pode trocar por qualquer PNG com o mesmo nome.

---

### Etapa 9 — Tela em arquivo próprio e Keys

- A tela vai para `lib/screens/jokenpo_screen.dart`.
- O `main.dart` fica só com o `JokenpoApp` (um `StatelessWidget` com o `MaterialApp`).

**Key** é uma "etiqueta" que colocamos no widget para o teste achá-lo com facilidade:

```dart
ElevatedButton(
  key: const Key('pedra'),
  onPressed: () => jogar(Jogada.pedra),
  child: const Text('Pedra'),
),
```

Também ganharam Key o texto do resultado (`'resultado'`) e os botões `'papel'` e `'tesoura'`.

---

### Etapa 10 — Primeiros testes de widget

`test/jokenpo_screen_test.dart`:

```dart
testWidgets('deve apresentar o título Jokenpô', (tester) async {
  await tester.pumpWidget(const MaterialApp(home: JokenpoScreen()));

  expect(find.text('Jokenpô'), findsOneWidget);
});
```

| Comando | O que faz |
|---|---|
| `testWidgets(...)` | Igual ao `test`, mas dá um `tester` para mexer na tela. |
| `tester.pumpWidget(...)` | **Monta** a tela no teste. Precisa do `MaterialApp` em volta. |
| `find.text('Pedra')` | Procura pelo texto. |
| `find.byKey(const Key('pedra'))` | Procura pela Key. |
| `find.byType(ElevatedButton)` | Procura pelo tipo do widget. |
| `findsOneWidget` | Espera achar **exatamente 1**. |
| `findsNothing` / `findsWidgets` / `findsNWidgets(3)` | Nenhum / pelo menos 1 / exatamente 3. |

- `async` / `await`: os comandos do `tester` levam um tempinho; `await` espera cada um terminar.

O segundo teste confere se os 3 botões existem usando `find.byKey`.

---

### Etapa 11 — O problema do Random e o ComputerPlayer

Queríamos testar o clique:

```dart
await tester.tap(find.byKey(const Key('pedra')));  // clica
await tester.pump();                               // redesenha a tela

expect(find.text('Você venceu!'), findsOneWidget);
```

- **`tap`** simula o clique → chama `jogar` → `setState`.
- **`pump`** faz o Flutter redesenhar a tela (sem ele, a tela do teste não atualiza).

**Mas esse teste não é confiável:** o computador sorteia. Às vezes dá vitória, às vezes empate, às vezes derrota. Um teste precisa dar **sempre o mesmo resultado** (ser *determinístico*).

Primeiro passo: tirar o Random da tela.

`lib/services/computer_player.dart`:

```dart
class ComputerPlayer {
  Jogada jogar() {
    final jogadas = Jogada.values;
    return jogadas[Random().nextInt(jogadas.length)];
  }
}
```

Na tela: `final computerPlayer = ComputerPlayer();` e `final computador = computerPlayer.jogar();`.

Ainda há um problema: **a própria tela cria** o `ComputerPlayer()`, então o teste não consegue trocá-lo.

---

### Etapa 12 — Abstração Player e injeção de dependência

**1. Uma abstração (o "contrato"):** `lib/services/player.dart`

```dart
abstract class Player {
  Jogada jogar();
}
```

- `abstract class` não tem implementação; só diz: "todo `Player` sabe `jogar()` e devolve uma `Jogada`".
- `ComputerPlayer implements Player` → cumpre esse contrato usando Random (`@override` marca o método que veio do contrato).

**2. A tela recebe o jogador pronto (injeção de dependência):**

```dart
class JokenpoScreen extends StatefulWidget {
  final Player computerPlayer;

  const JokenpoScreen({super.key, required this.computerPlayer});
  ...
}
```

No `State`, acessamos com `widget.computerPlayer.jogar()`.

**3. Quem cria é o `main.dart`:**

```dart
home: JokenpoScreen(computerPlayer: ComputerPlayer()),
```

```
ANTES:  JokenpoScreen ──cria──► ComputerPlayer()
DEPOIS: main.dart ──cria──► ComputerPlayer ──entrega──► JokenpoScreen
```

**Injeção de dependência** = a classe **não cria** aquilo de que precisa; ela **recebe pronto**. Assim, no teste, podemos entregar outra coisa.

---

### Etapa 13 — Fake: testes previsíveis

No teste criamos um jogador **falso** que sempre joga o que mandarmos:

```dart
class FakeComputerPlayer implements Player {
  final Jogada jogada;

  FakeComputerPlayer(this.jogada);

  @override
  Jogada jogar() {
    return jogada;
  }
}
```

Como ele também é um `Player`, a tela aceita. Agora o teste é previsível:

```dart
testWidgets('jogador deve vencer quando escolher pedra '
    'e computador escolher tesoura', (tester) async {
  final fakeComputer = FakeComputerPlayer(Jogada.tesoura);

  await tester.pumpWidget(
    MaterialApp(home: JokenpoScreen(computerPlayer: fakeComputer)),
  );

  await tester.tap(find.byKey(const Key('pedra')));
  await tester.pump();

  expect(find.text('Você venceu!'), findsOneWidget);
});
```

```
No app:   ComputerPlayer     → Random        → resultado imprevisível
No teste: FakeComputerPlayer → Jogada fixa   → resultado previsível
```

Também foram criados os testes de **derrota** (computador = papel) e **empate** (computador = pedra).

---

### Etapa 14 — Interface final

A tela passa a mostrar a jogada do usuário, a do computador e o resultado, com os 3 botões fixos no rodapé.

**Novo estado:**

```dart
Jogada? jogadaUsuario;
Jogada? jogadaComputador;
String resultado = 'Escolha sua jogada';
```

- O **`?`** quer dizer "pode ser `null`". Antes da primeira partida ainda não existe jogada.
- Um único `setState` atualiza as três coisas de uma vez.

**Widgets novos (privados, com `_`):**

- **`_JogadaSelecionada`**: título + imagem + nome da jogada. Se `jogada == null`, mostra um texto de espera (`'Selecione uma opção'` / `'Aguardando sua jogada'`).
  - `if (jogada != null) ...[ ... ] else ...` dentro da lista de `children` escolhe o que desenhar.
  - O `!` em `jogada!.titulo` diz ao Dart "aqui eu garanto que não é null".
  - As Keys são montadas com um prefixo: `Key('${keyPrefix}_jogada')` → `usuario_jogada` e `computador_jogada`.
- **`_JogadaButton`**: um `FilledButton` com imagem e texto, usando `jogada.imagem` e `jogada.titulo`.

**Layout:** `Scaffold` com `body` (conteúdo rolável com `SingleChildScrollView`) e `bottomNavigationBar` (a linha dos botões). `Expanded` faz cada botão ocupar 1/3 da largura. `SafeArea` evita a área do entalhe/barra do celular.

**Testes novos:**

- Estado inicial (textos de espera).
- Jogada do usuário aparece (`usuario_jogada`).
- Jogada do computador aparece (`computador_jogada`).
- Partida completa: lê o widget e confere o texto dele:

```dart
final usuario = tester.widget<Text>(find.byKey(const Key('usuario_jogada')));
expect(usuario.data, 'Pedra');
```

> `findsWidgets` foi usado para `find.text('Pedra')` porque "Pedra" aparece **duas vezes**: no botão e na jogada escolhida.

---

### Etapa 15 — Exercícios do tutorial

| Exercício | Como foi resolvido |
|---|---|
| 1. Os 9 testes unitários | Já feitos na etapa 5. |
| 2. Texto inicial "Escolha sua jogada" | Lê o `Text` da Key `resultado` e confere `data`. |
| 3. Exatamente 3 botões | `expect(find.byType(FilledButton), findsNWidgets(3))`. Na interface final os botões são `FilledButton`, não `ElevatedButton`. |
| 4. Fake sempre joga pedra | 3 testes: pedra → Empate, papel → Vitória, tesoura → Derrota. |
| 5. "Você escolheu: Pedra" | Dois `Text` novos no card do resultado + teste conferindo os textos. |

Todos estão no `group('Exercícios', ...)` de `test/jokenpo_screen_test.dart`.

---

### Etapas 16 a 18 — Desafio: placar com TDD

O desafio é criar um placar (`Jogador`, `Computador`, `Empates`) **começando pelo teste**.

**Etapa 16 — RED** (`c346678`): só o teste. A classe `Placar` nem existe, então o teste **falha** (erro de compilação). Esse commit está vermelho **de propósito**, para mostrar a etapa RED.

```dart
test('deve incrementar vitória do jogador', () {
  // Arrange
  final placar = Placar();

  // Act
  placar.registrarVitoriaJogador();

  // Assert
  expect(placar.jogador, 1);
  expect(placar.computador, 0);
  expect(placar.empates, 0);
});
```

> Repare: ao escrever o teste primeiro, **decidimos como a classe vai ser usada** (nome dos métodos e campos) antes de escrevê-la.

**Etapa 16 — GREEN** (`294dbe9`): o mínimo para passar.

```dart
class Placar {
  int jogador = 0;
  int computador = 0;
  int empates = 0;

  void registrarVitoriaJogador() {
    jogador++;
  }
}
```

**Etapa 17** (`40cfd52`): mais ciclos, um teste por vez — `registrarVitoriaComputador()`, `registrarEmpate()` e `resetar()`. No REFACTOR, a criação do `Placar` foi para o `setUp()`.

**Etapa 18** (`0dd44c3`): o placar aparece na tela.

```dart
resultado = service.verificarResultado(jogador, computador);

if (resultado == 'Empate') {
  placar.registrarEmpate();
} else if (resultado == 'Você venceu!') {
  placar.registrarVitoriaJogador();
} else {
  placar.registrarVitoriaComputador();
}
```

- Um `IconButton` (Key `resetar`) na barra de título zera o placar e volta a tela ao estado inicial.
- Testes de widget: duas vitórias seguidas → `'Jogador: 2'`; tocar em resetar → `'Computador: 0'`.

---

## Estrutura final

```
lib/
├── main.dart                     ← cria o app e injeta o ComputerPlayer
├── models/
│   ├── jogada.dart               ← enum Jogada (+ titulo e imagem)
│   └── placar.dart               ← contagem de vitórias/empates
├── screens/
│   └── jokenpo_screen.dart       ← interface
└── services/
    ├── computer_player.dart      ← jogador do computador (Random)
    ├── jokenpo_service.dart      ← regra do jogo
    └── player.dart               ← abstração (contrato) Player

test/
├── jokenpo_service_test.dart     ← testes unitários da regra (9)
├── jokenpo_screen_test.dart      ← testes de widget (17)
└── placar_test.dart              ← testes unitários do placar (5)

assets/images/                    ← pedra.png, papel.png, tesoura.png
```

## Resumo: evolução da arquitetura

```
1) Tudo na tela            2) Regra separada          3) Random separado
JokenpoScreen              JokenpoScreen              JokenpoScreen
├── UI                     ├── UI                     ├──► JokenpoService (regra)
├── regra                  ├── Random                 └──► ComputerPlayer (Random)
└── Random                 └──► JokenpoService

4) Final: injeção de dependência + Fake

                Player (abstração)
                  ▲            ▲
       ComputerPlayer      FakeComputerPlayer
         (Random)            (jogada fixa)
           │  no app            │  no teste
           └───────┐   ┌────────┘
                   ▼   ▼
               JokenpoScreen ──► JokenpoService
```

**A grande lição:** a vontade de testar nos obrigou a organizar melhor o código. Testes não servem só para achar erros — eles mostram onde o design pode melhorar.

## Colinha de testes

```dart
// Teste unitário
test('descrição', () {
  expect(obtido, esperado);
});

// Agrupar e preparar
group('nome', () { ... });
setUp(() { ... });          // roda antes de cada teste

// Teste de widget
testWidgets('descrição', (tester) async {
  await tester.pumpWidget(MaterialApp(home: MinhaTela()));  // monta
  await tester.tap(find.byKey(const Key('botao')));          // clica
  await tester.pump();                                       // redesenha
  expect(find.text('Texto'), findsOneWidget);                // confere
});
```

| Unit Test | Widget Test |
|---|---|
| Testa uma classe/método | Testa a tela e a interação |
| `test()` | `testWidgets()` |
| Não precisa de tela | Monta a tela com `pumpWidget` |
| Ex.: `verificarResultado(pedra, tesoura)` | Ex.: clicar em Pedra e ver "Você venceu!" |

**Próximos passos sugeridos pelo tutorial:** ViewModel, UiState, Repository e bibliotecas de mock como `mocktail` ou `mockito`.
