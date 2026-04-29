# StepToStop - Estrutura do Projeto Flutter

## 📱 Visão Geral
Aplicação mobile para ajudar viciados em vape/cigarro a parar de fumar. O usuário cuida de um pet virtual (Puff) que evolui conforme o usuário não fuma.

---

## 🏗️ Arquitetura do Projeto

```
lib/
├── main.dart                          # Entry point
│
├── models/
│   ├── pet_model.dart                 # Pet data (name, stage, health)
│   ├── user_model.dart                # User profile data
│   ├── achievement_model.dart         # Achievements/conquistas
│   └── craving_event_model.dart       # Registro de vontades
│
├── services/
│   ├── pet_service.dart               # Lógica do pet (evolution, happiness)
│   ├── progress_service.dart          # Cálculo de dias/dinheiro/VCoins
│   ├── storage_service.dart           # Local storage (hive/sqflite)
│   ├── notification_service.dart      # Notificações locais
│   └── sharing_service.dart           # Compartilhar progresso
│
├── providers/                         # State management (Provider)
│   ├── pet_provider.dart              # Gerencia estado do pet
│   ├── user_provider.dart             # Gerencia dados do usuário
│   ├── progress_provider.dart         # Gerencia progresso
│   └── theme_provider.dart            # Light/Dark mode
│
├── screens/
│   ├── dashboard_screen.dart          # Tela principal com pet
│   ├── statistics_screen.dart         # Gráficos de progresso
│   ├── pet_shop_screen.dart           # Loja para comprar itens
│   ├── history_screen.dart            # Log de eventos
│   ├── profile_screen.dart            # Perfil do usuário
│   ├── craving_screen.dart            # Registrar vontade
│   └── emergency_screen.dart          # Ajuda de emergência
│
├── widgets/
│   ├── pet_animator_widget.dart       # Widget do pet com Flame
│   ├── bottom_nav_bar.dart            # Bottom navigation
│   ├── stat_card.dart                 # Card de estatísticas
│   ├── action_button.dart             # Botões customizados
│   ├── pet_evolution_modal.dart       # Modal de evolução
│   └── vcoins_display.dart            # Display de VCoins
│
├── games/                             # Flame game components
│   └── pet_game.dart                  # Game logic com Flame
│
├── themes/
│   ├── app_theme.dart                 # Tema geral (cores, fonts)
│   ├── light_theme.dart               # Tema claro
│   └── dark_theme.dart                # Tema escuro
│
├── utils/
│   ├── constants.dart                 # Constantes (cores, textos)
│   ├── pet_stages.dart                # Dados dos estágios do pet
│   ├── date_formatter.dart            # Formatação de datas
│   └── validators.dart                # Validações
│
└── assets/                            # Assets locais
    ├── dog_sprites/
    │   ├── idle/
    │   ├── happy/
    │   ├── sad/
    │   └── eating/
    ├── images/
    │   ├── bg_day.png
    │   └── bg_night.png
    └── sounds/ (opcional)

```

---

## 🎮 Fluxo Principal

### 1. Dashboard (Home)
- [x] Exibir pet animado (Flame)
- [x] Mostrar dias sem nicotina
- [x] Mostrar dinheiro economizado ($)
- [x] Mostrar VCoins
- [x] Botões: +1 Puff, +1 Cigarro
- [x] Botões secundários: Tive vontade, Emergência
- [x] Botão compartilhar (roxo)

### 2. Estatísticas
- [ ] Gráfico de dias consecutivos
- [ ] Gráfico de dinheiro economizado
- [ ] Gráfico de VCoins ganhos
- [ ] Metas atingidas

### 3. Pet Shop
- [ ] Lista de itens disponíveis
- [ ] Preço em VCoins
- [ ] Compra com animação
- [ ] Inventário do usuário

### 4. Histórico
- [ ] Log de eventos (Puff, Cigarro, Vontade)
- [ ] Filtrar por tipo
- [ ] Timeline visual

### 5. Perfil
- [ ] Dados do usuário
- [ ] Pet atual e histórico
- [ ] Achievements/Troféus
- [ ] Configurações (tema, notificações)

---

## 🐕 Sistema de Pet

### Estágios de Evolução
| Dias | Estágio | Descrição |
|------|---------|-----------|
| 0 | Recém-nascido | Pequeno e frágil |
| 3 | Filhote | Brincalhão e cheio de energia |
| 7 | Jovem | Cada vez mais forte e confiante |
| 30 | Adulto | Forte, saudável e determinado |
| 90 | Maduro | Experiente e equilibrado |
| 365 | Idoso | Sábio e grato por cada conquista |

### Atributos do Pet
- `name`: string (Puff)
- `stage`: enum (newborn, puppy, young, adult, mature, elderly)
- `happiness`: 0-100
- `health`: 0-100
- `daysWithoutNicotine`: int
- `inventory`: List<Item>

---

## 💰 Sistema de VCoins

### Ganho
- +1 VCoin a cada 1 hora sem fumar
- +5 VCoins ao atingir 1 dia
- +10 VCoins ao atingir 7 dias
- +50 VCoins ao atingir 30 dias

### Uso
- Comprar itens para o pet (comida, brinquedos)
- Customização (colares, acessórios)

---

## 🎯 Funcionalidades Principais

### 1. Acompanhamento
- Contador de dias em tempo real
- Histórico de eventos
- Estatísticas visuais

### 2. Motivação
- Pet evolui conforme progresso
- Desbloqueamento de estágios
- Achievements

### 3. Gatilhos
- Registrar "Tive vontade"
- Botão de emergência
- Alertas e notificações

### 4. Social
- Compartilhar progresso
- Badge social (#StepToStop)

---

## 🛠️ Tecnologias Recomendadas

### Core
- Flutter 3.x
- Dart 3.x
- Provider (state management)

### UI/Animação
- Flame (game/animation)
- Flutter Animate
- Lottie (animações lottie)

### Dados
- Hive ou SQLite (local storage)
- SharedPreferences (prefs simples)

### Extras
- local_notifications (notificações)
- share (compartilhar)
- intl (tradução/i18n)

---

## 📊 Dados Persistidos

```dart
// Estrutura local storage
{
  user: {
    name: string,
    email: string,
    createdAt: datetime,
    lastUpdate: datetime
  },
  pet: {
    name: string,
    stage: int,
    happiness: int,
    health: int,
    createdAt: datetime
  },
  progress: {
    daysWithoutNicotine: int,
    totalMoneySaved: float,
    totalVCoinsEarned: int,
    totalVCoinsSpent: int,
    puffCount: int,
    cigaretteCount: int
  },
  events: [
    { type: 'puff', timestamp, notes },
    { type: 'cigarette', timestamp, notes },
    { type: 'craving', timestamp, notes }
  ]
}
```

---

## 🚀 Próximos Passos

1. [ ] Setup inicial do Flutter
2. [ ] Criar modelos de dados
3. [ ] Implementar Provider para state management
4. [ ] Criar telas básicas (stub)
5. [ ] Integrar Flame para pet animator
6. [ ] Implementar lógica de progresso
7. [ ] Adicionar persistência (storage)
8. [ ] Testes

---

## 📝 Notas

- Prioridade: Dashboard com pet animado
- Segunda prioridade: Sistema de progresso e VCoins
- Terceira: Telas complementares
- Testes e polish por último
