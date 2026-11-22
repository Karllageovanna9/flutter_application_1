
# Gerenciador de Tarefas

Aplicativo mobile desenvolvido em Flutter para a disciplina de Programação Mobile, como parte da avaliação prática P2 do curso de Engenharia de Software.

## Objetivo

Desenvolver um aplicativo para gerenciamento de tarefas pessoais, permitindo que o usuário organize suas atividades, acompanhe prazos e controle o andamento das tarefas.

## Funcionalidades

- Cadastro de usuário com nome, e-mail e senha
- Login e logout
- Persistência da sessão do usuário
- Tela inicial com resumo das tarefas
- Cadastro, edição e exclusão de tarefas
- Visualização dos detalhes de uma tarefa
- Definição de título, descrição, data de vencimento e prioridade
- Prioridades baixa, média e alta
- Marcação de tarefas como concluídas ou pendentes
- Listagem de tarefas em tempo real
- Tema claro e tema escuro
- Preferência de tema salva no dispositivo

## Tecnologias utilizadas

- Flutter
- Dart
- Firebase Authentication
- Firebase Realtime Database
- SharedPreferences

## Estrutura do projeto

```text
lib/
├── main.dart
├── models/
│   ├── usuario.dart
│   └── tarefa.dart
├── screens/
│   ├── login_screen.dart
│   ├── cadastro_usuario_screen.dart
│   ├── home_screen.dart
│   ├── tarefas_screen.dart
│   ├── cadastro_tarefa_screen.dart
│   └── configuracoes_screen.dart
├── services/
│   ├── auth_service.dart
│   ├── firebase_service.dart
│   └── preferences_service.dart
├── themes/
│   └── app_theme.dart
└── widgets/
    └── drawer_menu.dart
```

## Como executar

1. Instale o Flutter e configure o ambiente de desenvolvimento.
2. Clone este repositório.
3. Abra a pasta do projeto no VS Code.
4. Execute `flutter pub get` no terminal.
5. Configure o projeto Firebase e gere o arquivo `lib/firebase_options.dart`.
6. Configure o Firebase Authentication e o Realtime Database.
7. Execute o aplicativo com `flutter run`.

## Configuração do Firebase

O aplicativo utiliza Firebase Authentication para autenticação dos usuários e Firebase Realtime Database para armazenar as tarefas.

Cada usuário possui seus dados organizados de forma individual, utilizando seu UID como identificador.

O arquivo `firebase_options.dart` é gerado pela ferramenta FlutterFire CLI durante a configuração do Firebase.

## Autor

Estudante de Engenharia de Software