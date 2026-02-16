import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../pages/home/home_screen.dart';
import '../../modules/onboarding/onboarding_cubit.dart';
import '../../pages/onboarding/onboarding_screen.dart';
import 'app_routes.dart';

/// Конфигурация GoRouter для приложения
///
/// Демо-приложение без авторизации
class AppRouter {
  late final GoRouter router;
  final OnboardingCubit onboardingCubit;

  AppRouter({required this.onboardingCubit}) {
    router = GoRouter(
      initialLocation: AppRoutes.onboarding.path,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        // Если онбординг завершён и пользователь на странице онбординга - редирект на главную
        final isOnboarding = state.matchedLocation == AppRoutes.onboarding.path;
        final isCompleted = onboardingCubit.isCompleted;

        if (isOnboarding && isCompleted) {
          return AppRoutes.home.path;
        }

        // Если онбординг не завершён и пользователь не на онбординге - редирект на онбординг
        if (!isOnboarding && !isCompleted) {
          return AppRoutes.onboarding.path;
        }

        return null;
      },
      refreshListenable: _CubitRefreshNotifier(onboardingCubit.stream),
      routes: [
        // ============================================
        // ГЛАВНАЯ СТРАНИЦА
        // ============================================
        GoRoute(
          path: AppRoutes.home.path,
          name: AppRoutes.home.name,
          builder: (context, state) => const HomeScreen(),
        ),

        // ============================================
        // ОНБОРДИНГ
        // ============================================
        GoRoute(
          path: AppRoutes.onboarding.path,
          name: AppRoutes.onboarding.name,
          builder: (context, state) => const OnboardingScreen(),
        ),

        // ============================================
        // ПОДПИСКИ
        // ============================================
        GoRoute(
          path: AppRoutes.subscriptions.path,
          name: AppRoutes.subscriptions.name,
          builder: (context, state) => const Placeholder(
            // TODO: Заменить на SubscriptionsScreen()
          ),
        ),

        // ============================================
        // ДЕТАЛИ ПОДПИСКИ
        // ============================================
        GoRoute(
          path: AppRoutes.subscriptionDetail.path,
          name: AppRoutes.subscriptionDetail.name,
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            return Placeholder(
              // TODO: Заменить на SubscriptionDetailScreen(id: id)
              child: Center(child: Text('Subscription ID: $id')),
            );
          },
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Ошибка 404')),
        body: Center(child: Text('Страница не найдена: ${state.uri}')),
      ),
    );
  }
}

/// Helper для обновления GoRouter при изменении состояния Cubit
class _CubitRefreshNotifier extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  _CubitRefreshNotifier(Stream<dynamic> stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
