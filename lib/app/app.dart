import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/onboarding/onboarding_cubit.dart';
import 'providers.dart';
import 'router/app_router.dart';
import 'styles/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: Builder(
        builder: (context) {
          // Получаем OnboardingCubit из провайдера для передачи в роутер
          final onboardingCubit = context.read<OnboardingCubit>();
          final appRouter = AppRouter(onboardingCubit: onboardingCubit);

          return MaterialApp.router(
            title: 'subscription_app',
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: ThemeMode.system,
            routerConfig: appRouter.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
