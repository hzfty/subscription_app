import 'package:flutter/material.dart';

/// Глобальные BlocProviders для всего приложения
///
/// Для демо-приложения без авторизации
/// Пока провайдеры не нужны, возвращаем просто child
class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // TODO: Когда добавятся cubits, обернуть в MultiBlocProvider
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: (_) => SubscriptionsCubit()),
    //   ],
    //   child: child,
    // );

    return child;
  }
}
