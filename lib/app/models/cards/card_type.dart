import 'package:flutter/material.dart';

/// Тип карточки с разными уровнями доступа
enum CardType {
  /// Обычная карточка (серый цвет) - доступна всем
  normal,

  /// Плюс карточка (фиолетовый цвет) - доступна пользователям с Плюс и Премиум подписками
  plus,

  /// Премиум карточка (золотой цвет) - доступна только пользователям с Премиум подпиской
  premium;

  /// Цвет обводки карточки
  Color get borderColor {
    switch (this) {
      case CardType.normal:
        return Colors.grey;
      case CardType.plus:
        return Colors.purple;
      case CardType.premium:
        return Colors.amber;
    }
  }

  /// Название типа для отображения
  String get displayName {
    switch (this) {
      case CardType.normal:
        return 'Обычный';
      case CardType.plus:
        return 'Плюс';
      case CardType.premium:
        return 'Премиум';
    }
  }
}
