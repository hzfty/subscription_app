import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../pages/home/home_screen.dart';
import 'app_routes.dart';

/// Конфигурация GoRouter для приложения
///
/// Демо-приложение без авторизации
class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: AppRoutes.home.path,
      debugLogDiagnostics: true,
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
          builder: (context, state) => const Placeholder(
            // TODO: Заменить на OnboardingScreen()
          ),
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
