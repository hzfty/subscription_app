import 'package:flutter/material.dart';
import '../../../../app/models/subscription/subscription_plan.dart';
import '../../../../shared/components/buttons/primary_button.dart';

/// Кнопка "Продолжить" для экрана paywall
class ContinueButton extends StatelessWidget {
  final SubscriptionPlan? selectedPlan;
  final VoidCallback onPressed;

  const ContinueButton({
    super.key,
    required this.selectedPlan,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: PrimaryButton(
          text: 'Продолжить',
          onPressed: selectedPlan != null ? onPressed : null,
          backgroundColor: selectedPlan?.color ?? Colors.grey,
          width: double.infinity,
        ),
      ),
    );
  }
}
