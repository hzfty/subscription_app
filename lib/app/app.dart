import 'package:flutter/material.dart';
import 'providers.dart';
import 'router/app_router.dart';
import 'styles/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();

    // Инициализация после первого фрейма
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // TODO: Добавить DioInterceptor когда нужен (требует context)
      // final dioClient = DioClient.instance;
      // dioClient.addInterceptor(DioInterceptor(context: context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: Builder(
        builder: (context) {
          _appRouter = AppRouter(context);

          return MaterialApp.router(
            title: 'subscription_app',
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: ThemeMode.system,
            routerConfig: _appRouter.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
