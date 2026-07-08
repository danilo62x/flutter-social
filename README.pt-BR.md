# Flutter Social

[Read in English](./README.md)

[![Licença: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE) ![Grátis](https://img.shields.io/badge/price-free-brightgreen)

O Flutter Social é um template gratuito de rede social (estilo Instagram, o app de demonstração se chama "Pulse") feito com Flutter 3.44 e Material 3. São 8 telas: feed com stories e posts, detalhe do post, thread de comentários, perfil com estatísticas e grade de posts, página de explorar, compositor de post, notificações agrupadas e caixa de mensagens diretas. A interface é desenhada só com gradientes e ícones, sem imagens de rede, então tudo renderiza offline. Os dados vêm de repositórios mockados; as classes de serviço indicam onde uma API real se encaixa.

## Telas

8 telas. Cinco delas são branches da navegação inferior; mensagens, detalhe do post e comentários são rotas empilhadas do go_router:

- Feed (`/`): faixa de stories e cards de post com curtidas e comentários.
- Explorar (`/explore`): grade de descobertas.
- Criar post (`/create`): compositor de post.
- Notificações (`/notifications`): notificações agrupadas por tipo.
- Perfil (`/profile`): estatísticas do usuário e grade de posts.
- Mensagens (`/messages`): caixa de mensagens diretas.
- Post (`/post/:id`): detalhe de um post.
- Comentários (`/post/:id/comments`): thread de comentários de um post.

## Capturas de tela

A pasta `screenshots/` contém 16 PNGs: uma captura clara e uma escura de cada tela, geradas por `test/print_test.dart`. Uma amostra:

![Feed](screenshots/social.png)
![Post](screenshots/social-2.png)
![Perfil](screenshots/social-3.png)
![Explorar](screenshots/social-4.png)
![Criar post](screenshots/social-5.png)
![Notificações](screenshots/social-6.png)

## Stack

| Pacote | Versão |
| --- | --- |
| Flutter | 3.44 (stable) |
| Dart SDK | `^3.12.2` |
| go_router | `^17.3.0` |
| provider | `^6.1.5+1` |
| http | `^1.6.0` |
| intl | `^0.20.3` |
| cupertino_icons | `^1.0.8` |
| flutter_lints (dev) | `^6.0.0` |

O Material 3 é habilitado via `useMaterial3: true` com esquema de cores baseado em seed.

## Requisitos

- Flutter SDK, canal stable. O template foi construído com Flutter 3.44; o `pubspec.lock` resolve com Flutter 3.38.0 ou mais novo e Dart `>=3.12.2 <4.0.0`.
- Sem backend, chaves de API ou variáveis de ambiente.
- As toolchains de cada plataforma que você for compilar: Android SDK para APKs, Xcode no macOS para iOS, Chrome para web, Visual Studio com o workload de C++ para Windows. O repositório inclui as pastas `android/`, `ios/`, `web/` e `windows/`.

## Como rodar

```bash
flutter pub get
flutter run
```

O `flutter run` usa o dispositivo conectado. Liste os alvos com `flutter devices` e escolha um com `-d`, por exemplo `flutter run -d chrome` para web ou `flutter run -d windows` para desktop.

## Builds

```bash
flutter build apk        # Android
flutter build ipa        # iOS (requer macOS e Xcode)
flutter build web        # saída web em build/web
flutter build windows    # desktop Windows
```

## Testes

`flutter test` executa os testes de widget em `test/widget_test.dart`. O `test/print_test.dart` (com utilitários em `test/golden_utils.dart`) renderiza cada tela nos dois temas e grava os PNGs em `screenshots/`.

## Estrutura do projeto

```
lib/
  main.dart                 # ponto de entrada
  app.dart                  # MaterialApp.router, monta o router com um PostRepository
  core/
    router.dart             # tabela de rotas do go_router (5 branches + rotas empilhadas)
    theme.dart              # AppTheme: cor seed e temas de componentes
    format.dart             # helpers de formatação (contagens, timestamps)
  data/
    models/                 # modelos de API (post, comment) com fromJson/toJson
    services/               # serviços de API de post e comentário via http (mockados)
    repositories/           # repositórios de post, comentário, mensagem, notificação e perfil
  domain/
    models/                 # Post, Comment, Profile, Conversation, NotificationItem, ExploreTile
  ui/
    core/widgets/           # widgets compartilhados, incluindo SocialBottomNav
    features/<feature>/
      views/                # uma tela por feature
      view_models/          # view models ChangeNotifier (MVVM)
```

## Arquitetura e gerenciamento de estado

O código segue arquitetura em camadas (data, domain, ui) com MVVM. Cada tela tem um view model `ChangeNotifier` injetado via `provider`. Diferente dos templates desta série que usam um repositório único, este divide a camada de dados em cinco repositórios (post, comentário, mensagem, notificação, perfil); o `app.dart` monta o router com uma instância de `PostRepository`. A navegação é declarativa com go_router: cinco branches na navegação inferior mais `/messages` e `/post/:id` com a rota aninhada `comments`.

## Tema e customização

O tema está centralizado em `lib/core/theme.dart`. As cores derivam de uma única cor seed (`AppTheme.seed`, `0xFFE1306C`, um magenta no estilo do Instagram); troque essa cor e o `ColorScheme.fromSeed` regenera as paletas clara e escura. O mesmo arquivo define a fonte (Roboto) e os temas de componentes de botões e inputs. Os anéis de story e os placeholders de post são gradientes, sem assets de imagem. O app segue o brilho do sistema porque o `app.dart` passa `theme` e `darkTheme` ao `MaterialApp.router`.

## Mais templates

Este template faz parte do catálogo em https://template.dev.br, que lista os templates gratuitos e pagos com previews.

## Apoie o projeto

As doações mantêm os templates gratuitos atualizados e compatíveis com as novas versões do Flutter. Se este template foi útil para você, contribua com qualquer valor em https://template.dev.br/doar?template=flutter-social.

## Licença

MIT, veja [LICENSE](./LICENSE). Copyright 2026 Danilo Quinelato.
