import 'package:flutter/material.dart';

/// Отдельная страница онбординга
class OnboardingPage extends StatelessWidget {
  final IconData icon;
  final String text;

  const OnboardingPage({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Большая иконка
          Icon(
            icon,
            size: 200,
            color: Colors.blue,
          ),
          const SizedBox(height: 48),
          // Текст под иконкой
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
