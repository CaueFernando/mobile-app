# StepToStop - Flutter Edition 🐕

Um aplicativo mobile para ajudar pessoas a parar de fumar/vape com a ajuda de um pet virtual chamado **Puff**.

## 📋 Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── models/                   # Modelos de dados
│   ├── pet_model.dart       # Modelo do pet
│   ├── user_model.dart      # Modelo do usuário
│   └── event_model.dart     # Modelo de eventos
├── providers/               # Gerenciamento de estado (Provider)
│   ├── pet_provider.dart    # Estado do pet
│   ├── user_provider.dart   # Estado do usuário
│   └── theme_provider.dart  # Estado do tema
├── screens/                 # Telas principais
│   ├── dashboard_screen.dart
│   ├── statistics_screen.dart
│   ├── shop_screen.dart
│   ├── history_screen.dart
│   └── profile_screen.dart
├── widgets/                 # Widgets reutilizáveis
│   ├── stat_card.dart
│   ├── action_button.dart
│   └── bottom_nav_bar.dart
├── services/               # Serviços (storage, API, etc)
├── themes/                 # Temas e estilos
│   └── app_theme.dart
└── utils/                  # Utilitários
    ├── constants.dart
    └── ...
```

## 🚀 Como Rodaar

### Pré-requisitos
- Flutter 3.x instalado
- Dart 3.x
- Emulador Android/iOS ou dispositivo físico

### Instalação

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/seu-usuario/steptostop.git
   cd steptostop
   ```

2. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

3. **Rode a aplicação:**
   ```bash
   flutter run
   ```

### Em Desenvolvimento

Para rodas com hot reload:
```bash
flutter run -v
```

## 📱 Funcionalidades

- ✅ **Dashboard** - Tela principal com pet interativo
- ✅ **Estatísticas** - Acompanhar progresso
- ✅ **Pet Shop** - Comprar itens com VCoins
- ✅ **Histórico** - Log de eventos
- ✅ **Perfil** - Dados do usuário
- 🔄 **Animação com Flame** - Em desenvolvimento

## 🎮 Tecnologias Usadas

- **Flutter** - Framework mobile
- **Provider** - State management
- **Flame** - Engine para animação do pet
- **Hive** - Local storage
- **Material 3** - Design system

## 📝 Próximos Passos

1. [ ] Integrar Flame para animação do pet
2. [ ] Implementar persistência de dados (Hive)
3. [ ] Criar telas de estatísticas
4. [ ] Adicionar sons e notificações
5. [ ] Testes unitários

## 👨‍💻 Desenvolvedor

Desenvolvido com ❤️ para ajudar as pessoas a parar de fumar.

## 📄 Licença

MIT License
