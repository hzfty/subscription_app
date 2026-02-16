import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/auth/auth_cubit.dart';

/// Глобальные BlocProviders для всего приложения
///
/// ВАЖНО: Порядок имеет значение!
/// 1. Сначала cubits без зависимостей (AuthCubit)
/// 2. Потом cubits которые зависят от других
class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // ============================================
        // КРИТИЧНЫЕ CUBITS (lazy: false)
        // ============================================

        // AuthCubit - всегда первый, нужен для роутинга
        BlocProvider(
          create: (_) => AuthCubit(),
          lazy: false, // Загрузить сразу для восстановления сессии
        ),

        // ============================================
        // FEATURE CUBITS (lazy: true по умолчанию)
        // ============================================

        // TODO: Добавить cubits для features здесь
        // Пример:
        // BlocProvider(
        //   create: (context) => ItemsCubit(
        //     authCubit: context.read<AuthCubit>(),
        //   ),
        // ),
      ],
      child: child,
    );
  }
}
