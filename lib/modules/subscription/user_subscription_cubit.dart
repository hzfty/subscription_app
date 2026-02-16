import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../app/models/subscription/subscription_type.dart';
import 'user_subscription_state.dart';

/// Cubit для управления подпиской пользователя
///
/// Использует HydratedCubit для сохранения подписки между сессиями
class UserSubscriptionCubit extends HydratedCubit<UserSubscriptionState> {
  UserSubscriptionCubit() : super(const UserSubscriptionState.initial());

  /// Активировать подписку
  void activateSubscription(SubscriptionType type) {
    final DateTime expiresAt;

    // Вычисляем дату истечения в зависимости от типа
    switch (type) {
      case SubscriptionType.plus:
        // Месячная подписка
        expiresAt = DateTime.now().add(const Duration(days: 30));
        break;
      case SubscriptionType.premium:
        // Годовая подписка
        expiresAt = DateTime.now().add(const Duration(days: 365));
        break;
      case SubscriptionType.none:
        // Нет подписки
        emit(const UserSubscriptionState.initial());
        return;
    }

    emit(UserSubscriptionState(
      type: type,
      expiresAt: expiresAt,
    ));
  }

  /// Отменить подписку
  void cancelSubscription() {
    emit(const UserSubscriptionState.initial());
  }

  /// Проверка истечения подписки
  bool get isExpired {
    if (state.expiresAt == null) return true;
    return DateTime.now().isAfter(state.expiresAt!);
  }

  @override
  UserSubscriptionState? fromJson(Map<String, dynamic> json) {
    try {
      return UserSubscriptionState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(UserSubscriptionState state) {
    try {
      return state.toJson();
    } catch (_) {
      return null;
    }
  }
}
