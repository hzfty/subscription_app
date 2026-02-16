/// Тип подписки пользователя
enum SubscriptionType {
  /// Нет активной подписки (базовый доступ)
  none,

  /// Плюс подписка (месячная) - доступ к плюс-функциям
  plus,

  /// Премиум подписка (годовая) - доступ ко всем функциям
  premium;

  /// Отображаемое название
  String get displayName {
    switch (this) {
      case SubscriptionType.none:
        return 'Нет подписки';
      case SubscriptionType.plus:
        return 'Плюс';
      case SubscriptionType.premium:
        return 'Премиум';
    }
  }

  /// Проверка доступа к плюс-функциям
  bool get hasPlus => this == SubscriptionType.plus || this == SubscriptionType.premium;

  /// Проверка доступа к премиум-функциям
  bool get hasPremium => this == SubscriptionType.premium;
}
