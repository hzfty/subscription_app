import 'package:flutter/material.dart';
import '../../../../../app/models/subscription/subscription_plan.dart';
import '../../subscription_card.dart';

/// Список карточек подписок
class SubscriptionCardsList extends StatelessWidget {
  final List<SubscriptionPlan> plans;
  final String? selectedPlanId;
  final void Function(SubscriptionPlan) onPlanSelected;

  const SubscriptionCardsList({
    super.key,
    required this.plans,
    required this.selectedPlanId,
    required this.onPlanSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: plans.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final plan = plans[index];
        final isSelected = selectedPlanId == plan.id;

        return SubscriptionCard(
          plan: plan,
          isSelected: isSelected,
          onTap: () => onPlanSelected(plan),
        );
      },
    );
  }
}
