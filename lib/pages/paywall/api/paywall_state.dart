import 'package:equatable/equatable.dart';
import '../../../app/models/subscription/subscription_plan.dart';

/// Состояние экрана paywall
class PaywallState extends Equatable {
  final SubscriptionPlan? selectedPlan;

  const PaywallState({this.selectedPlan});

  /// Начальное состояние без выбранного плана
  const PaywallState.initial() : selectedPlan = null;

  @override
  List<Object?> get props => [selectedPlan];

  PaywallState copyWith({
    SubscriptionPlan? selectedPlan,
  }) {
    return PaywallState(
      selectedPlan: selectedPlan ?? this.selectedPlan,
    );
  }
}
