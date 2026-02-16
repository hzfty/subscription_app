# Subscription App

Демонстрационное Flutter-приложение с системой подписок и управлением карточками.

## Архитектура

Проект построен на основе **Plov 2.0** с использованием стека **flutter-cubit**.

### Основные принципы

- **Feature-first architecture** — функции организованы по экранам
- **State Management** — Cubit + HydratedBloc для персистентности
- **Immutable State** — все состояния неизменяемы (Equatable)
- **Fail Fast** — ранний выброс ошибок с контекстом
- **Declarative Navigation** — go_router для маршрутизации

### Технологический стек

- **Flutter** — UI фреймворк
- **flutter_bloc/Cubit** — управление состоянием
- **hydrated_bloc** — персистентность состояния между сессиями
- **go_router** — декларативная навигация
- **equatable** — сравнение состояний
- **path_provider** — доступ к файловой системе

## Структура проекта

```
lib/
├── app/                           # Глобальная конфигурация приложения
│   ├── models/                    # Глобальные модели данных
│   │   ├── cards/                 # Модели карточек
│   │   │   ├── card_type.dart    # Enum типов карточек (normal/plus/premium)
│   │   │   ├── card_item.dart    # Модель карточки
│   │   │   └── models.dart       # Экспорты
│   │   └── subscription/          # Модели подписок
│   │       ├── subscription_type.dart   # Enum типов подписки
│   │       ├── subscription_plan.dart   # Модель тарифного плана
│   │       └── models.dart              # Экспорты
│   ├── router/                    # Конфигурация навигации
│   │   ├── app_router.dart       # GoRouter configuration
│   │   └── app_routes.dart       # Enum маршрутов
│   ├── app.dart                  # Корневой виджет приложения
│   └── providers.dart            # Глобальные BlocProviders
│
├── modules/                       # Глобальная бизнес-логика
│   ├── onboarding/               # Модуль онбординга
│   │   ├── onboarding_cubit.dart
│   │   └── onboarding_state.dart
│   └── subscription/             # Модуль управления подпиской пользователя
│       ├── user_subscription_cubit.dart
│       └── user_subscription_state.dart
│
├── pages/                        # Feature-first структура экранов
│   ├── onboarding/              # Экран онбординга
│   │   ├── api/                 # Локальная бизнес-логика экрана
│   │   │   ├── onboarding_page_cubit.dart
│   │   │   └── onboarding_page_state.dart
│   │   ├── components/          # UI компоненты
│   │   │   ├── buttons/
│   │   │   │   └── onboarding_buttons.dart
│   │   │   ├── onboarding_page.dart
│   │   │   └── page_indicator.dart
│   │   └── onboarding_screen.dart
│   │
│   ├── home/                    # Главный экран с карточками
│   │   ├── api/                # Локальная бизнес-логика
│   │   │   ├── home_cubit.dart
│   │   │   └── home_state.dart
│   │   ├── components/         # UI компоненты
│   │   │   ├── dialoges/
│   │   │   │   ├── create_card_dialog.dart
│   │   │   │   └── delete_card_dialog.dart
│   │   │   ├── inputs/
│   │   │   │   └── card_type_chips.dart
│   │   │   ├── lists/
│   │   │   │   └── cards_list.dart
│   │   │   └── card_item_widget.dart
│   │   └── home_screen.dart
│   │
│   └── paywall/                # Экран выбора подписки
│       ├── api/               # Локальная бизнес-логика
│       │   ├── paywall_cubit.dart
│       │   └── paywall_state.dart
│       ├── components/        # UI компоненты
│       │   ├── buttons/
│       │   │   └── continue_button.dart
│       │   ├── lists/
│       │   │   └── cards/
│       │   │       └── subscription_cards_list.dart
│       │   └── subscription_card.dart
│       └── paywall_screen.dart
│
├── shared/                    # Переиспользуемые компоненты
│   └── components/
│       └── buttons/
│           ├── primary_button.dart
│           ├── secondary_button.dart
│           └── buttons.dart
│
└── main.dart                 # Точка входа

```

## Основные экраны

### 1. Onboarding (Онбординг)
- 2 страницы с приветствием
- Индикатор страниц
- Состояние сохраняется между сессиями (показывается только один раз)

### 2. Home (Главный экран)
- Список карточек с CRUD операциями
- 3 типа карточек: Normal, Plus, Premium
- Доступ к типам ограничен подпиской пользователя
- Переход к экрану подписок

### 3. Paywall (Экран подписок)
- 2 тарифных плана: Plus (месячная), Premium (годовая)
- Визуальный выбор подписки
- Эмуляция покупки с активацией подписки

## State Management

### Глобальные Cubits (HydratedBloc)
- **OnboardingCubit** — состояние прохождения онбординга
- **UserSubscriptionCubit** — активная подписка пользователя

### Локальные Cubits (HydratedBloc)
- **HomeCubit** — список карточек пользователя

### Локальные Cubits (обычные)
- **OnboardingPageCubit** — текущая страница онбординга
- **PaywallCubit** — выбранный тарифный план

## Ключевые особенности

### Персистентность данных
Используется `HydratedBloc` для автоматического сохранения состояния:
- Карточки сохраняются между сессиями
- Подписка пользователя сохраняется
- Состояние онбординга (показан/не показан)

### Subscription-based Access Control
Доступ к функциям ограничен типом подписки:
- **Normal** карточки — доступны всем
- **Plus** карточки — только для Plus и Premium
- **Premium** карточки — только для Premium

### Компонентная архитектура
- Переиспользуемые UI компоненты в `shared/`
- Feature-specific компоненты внутри экранов
- Единый стиль кнопок и элементов управления

## Запуск проекта

```bash
# Установка зависимостей
flutter pub get

# Запуск приложения
flutter run

# Анализ кода
flutter analyze

# Запуск тестов
flutter test
```

## Правила разработки

- Вопросы на **русском** языке
- Комментарии в коде на **русском** языке
- Следовать принципу **Fail Fast**
- Использовать **immutable state**
- Никогда не добавлять `Co-Authored-By` в коммиты
