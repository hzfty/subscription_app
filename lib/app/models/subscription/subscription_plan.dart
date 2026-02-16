import 'package:flutter/material.dart';
import 'subscription_type.dart';

/// Модель плана подписки
class SubscriptionPlan {
  final String id;
  final String title;
  final String description;
  final double price;
  final String period;
  final SubscriptionType type;
  final Color color;
  final IconData icon;

  const SubscriptionPlan({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.period,
    required this.type,
    required this.color,
    required this.icon,
  });

  /// Форматированная цена
  String get formattedPrice => '${price.toInt()} ₽/$period';

  /// Доступные планы подписок
  static const List<SubscriptionPlan> availablePlans = [
    SubscriptionPlan(
      id: 'monthly_plus',
      title: 'Месяц',
      description: 'Месячная подписка, открывающая доступ к плюс-функциям',
      price: 300,
      period: 'мес',
      type: SubscriptionType.plus,
      color: Colors.purple,
      icon: Icons.star,
    ),
    SubscriptionPlan(
      id: 'yearly_premium',
      title: 'Год',
      description: 'Годовая подписка, открывающая доступ к премиум-функциям',
      price: 2500,
      period: 'год',
      type: SubscriptionType.premium,
      color: Colors.amber,
      icon: Icons.workspace_premium,
    ),
  ];
}
