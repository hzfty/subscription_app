import 'package:flutter/material.dart';

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
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: isLastPage ? onComplete : onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            isLastPage ? 'Начать' : 'Далее',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
