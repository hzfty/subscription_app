import 'package:equatable/equatable.dart';
import '../../app/models/subscription/subscription_type.dart';

/// Состояние подписки пользователя
class UserSubscriptionState extends Equatable {
  final SubscriptionType type;
  final DateTime? expiresAt;

  const UserSubscriptionState({
    required this.type,
    this.expiresAt,
  });

  /// Начальное состояние без подписки
  const UserSubscriptionState.initial()
      : type = SubscriptionType.none,
        expiresAt = null;

  @override
  List<Object?> get props => [type, expiresAt];

  UserSubscriptionState copyWith({
    SubscriptionType? type,
    DateTime? expiresAt,
  }) {
    return UserSubscriptionState(
      type: type ?? this.type,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  /// Сериализация в JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }

  /// Десериализация из JSON
  factory UserSubscriptionState.fromJson(Map<String, dynamic> json) {
    return UserSubscriptionState(
      type: SubscriptionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => SubscriptionType.none,
      ),
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'] as String)
          : null,
    );
  }
}
