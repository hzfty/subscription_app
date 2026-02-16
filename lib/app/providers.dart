import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/onboarding/onboarding_cubit.dart';
import '../modules/subscription/user_subscription_cubit.dart';

/// Глобальные BlocProviders для всего приложения
class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Cubit для управления онбордингом (сохраняется между сессиями)
        BlocProvider(create: (_) => OnboardingCubit()),

        // Cubit для управления подпиской пользователя (сохраняется между сессиями)
        BlocProvider(create: (_) => UserSubscriptionCubit()),
      ],
      child: child,
    );
  }
}
