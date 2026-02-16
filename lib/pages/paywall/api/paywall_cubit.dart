import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/models/subscription/subscription_plan.dart';
import 'paywall_state.dart';

/// Cubit для управления выбором плана подписки на экране paywall
class PaywallCubit extends Cubit<PaywallState> {
  PaywallCubit() : super(const PaywallState.initial());

  /// Выбрать план
  void selectPlan(SubscriptionPlan plan) {
    emit(state.copyWith(selectedPlan: plan));
  }

  /// Снять выбор
  void deselectPlan() {
    emit(const PaywallState.initial());
  }
}
