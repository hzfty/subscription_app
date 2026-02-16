import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../modules/auth/auth_cubit.dart';
import '../../pages/home/home_screen.dart';
import 'app_routes.dart';
import 'go_router_refresh_stream.dart';

/// Конфигурация GoRouter для приложения
///
/// ВАЖНО:
/// 1. AuthCubit должен быть доступен через context.read<AuthCubit>()
/// 2. refreshListenable автоматически вызывает redirect при изменении состояния
/// 3. Не используйте context.go() внутри Cubit - только в UI
class AppRouter {
  final BuildContext context;
  late final GoRouter router;

  AppRouter(this.context) {
    final authCubit = context.read<AuthCubit>();

    router = GoRouter(
      initialLocation: AppRoutes.home.path,
      debugLogDiagnostics: true,

      // Автоматический редирект при изменении состояния Auth
      refreshListenable: GoRouterRefreshStream(authCubit.stream),

      redirect: (context, state) {
        final isAuthenticated = authCubit.state.isAuthenticated;
        final isGoingToAuth = state.matchedLocation == AppRoutes.auth.path;

        // Если не авторизован и идёт не на auth -> редирект на auth
        if (!isAuthenticated && !isGoingToAuth) {
          return AppRoutes.auth.path;
        }

        // Если авторизован и идёт на auth -> редирект на home
        if (isAuthenticated && isGoingToAuth) {
          return AppRoutes.home.path;
        }

        // Всё ок, редирект не нужен
        return null;
      },

      routes: [
        // ============================================
        // PUBLIC ROUTES (без авторизации)
        // ============================================
        GoRoute(
          path: AppRoutes.auth.path,
          name: AppRoutes.auth.name,
          builder: (context, state) => const Placeholder(
            // TODO: Заменить на AuthScreen()
            // color: Colors.blue,
          ),
        ),

        // ============================================
        // PROTECTED ROUTES (требуют авторизации)
        // ============================================
        GoRoute(
          path: AppRoutes.home.path,
          name: AppRoutes.home.name,
          builder: (context, state) => const HomeScreen(),
        ),

        GoRoute(
          path: AppRoutes.profile.path,
          name: AppRoutes.profile.name,
          builder: (context, state) => const Placeholder(
            // TODO: Заменить на ProfileScreen()
            // color: Colors.green,
          ),
        ),

        GoRoute(
          path: AppRoutes.settings.path,
          name: AppRoutes.settings.name,
          builder: (context, state) => const Placeholder(
            // TODO: Заменить на SettingsScreen()
            // color: Colors.orange,
          ),
        ),
      ],

      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Ошибка 404')),
        body: Center(child: Text('Страница не найдена: ${state.uri}')),
      ),
    );
  }
}
