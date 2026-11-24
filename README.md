# Gerenciador de Tarefas

Aplicativo mobile desenvolvido em Flutter para a disciplina de Programação Mobile, como parte da avaliação prática P2 do curso de Engenharia de Software.

## Objetivo

Desenvolver um aplicativo para gerenciamento de tarefas pessoais, permitindo que o usuário organize suas atividades, acompanhe prazos e controle o andamento das tarefas.

## Funcionalidades

- Cadastro de usuário com nome, e-mail e senha
- Login e logout com Firebase Authentication
- Persistência da sessão do usuário
- Tela inicial com resumo das tarefas
- Menu lateral Drawer para navegação
- Cadastro, consulta, edição e exclusão de tarefas
- Visualização dos detalhes de uma tarefa
- Definição de título, descrição, data de vencimento e prioridade
- Prioridades baixa, média e alta
- Marcação de tarefas como concluídas ou pendentes
- Listagem de tarefas utilizando ListView
- Atualização da listagem em tempo real
- Tarefas vinculadas ao usuário autenticado
- Tema claro e tema escuro
- Preferência de tema salva no dispositivo

## Tecnologias utilizadas

- Flutter
- Dart
- Firebase Core
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
5. Configure o projeto Firebase e gere o arquivo `lib/firebase_options.dart` utilizando o FlutterFire CLI.
6. Ative o método de autenticação por e-mail e senha no Firebase Authentication.
7. Configure o Firebase Realtime Database e suas regras de segurança.
8. Execute o aplicativo com `flutter run`.

## Configuração do Firebase

O aplicativo utiliza Firebase Authentication para autenticação dos usuários e Firebase Realtime Database para armazenar as tarefas.

Cada usuário possui suas tarefas organizadas individualmente, utilizando seu UID como identificador no banco de dados.

As tarefas são armazenadas no caminho:

```text
users/
└── UID_DO_USUARIO/
    └── tasks/
        └── ID_DA_TAREFA/
```

O Firebase Realtime Database é utilizado para salvar, recuperar e acompanhar alterações nas tarefas em tempo real.

O arquivo `firebase_options.dart` é gerado pela ferramenta FlutterFire CLI durante a configuração do Firebase.

As regras de segurança do banco devem permitir que cada usuário autenticado acesse somente os próprios dados.

## Models

O projeto utiliza classes para representar as principais entidades:

- **Usuario:** representa o usuário autenticado, contendo UID, nome e e-mail.
- **Tarefa:** representa uma tarefa, contendo ID, título, descrição, data de vencimento, prioridade e situação.

## Preferências e temas

O aplicativo permite alternar entre tema claro e tema escuro.

A preferência selecionada é armazenada localmente utilizando SharedPreferences e recuperada quando o aplicativo é iniciado novamente.

Os temas são definidos utilizando ThemeData e ThemeMode.

## Autor

## Capturas de tela

### Tela de login
![Tela de login](screenshots/login.png)

### Tela inicial
![Tela inicial com resumo das tarefas](screenshots/inicio.png)

### Listagem e detalhes das tarefas
![Listagem e detalhes das tarefas](screenshots/tarefas.png)

### Configurações de tema
![Configurações do tema](screenshots/configuracoes.png)

Estudante de Engenharia de Software
