import 'package:flutter/material.dart';
import '../../../../shared/components/buttons/primary_button.dart';

/// Кнопки навигации для онбординга
class OnboardingButtons extends StatelessWidget {
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onComplete;

  const OnboardingButtons({
    super.key,
    required this.isLastPage,
    required this.onNext,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: PrimaryButton(
        text: isLastPage ? 'Начать' : 'Далее',
        onPressed: isLastPage ? onComplete : onNext,
        width: double.infinity,
      ),
    );
  }
}
