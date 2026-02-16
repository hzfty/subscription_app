import 'dart:async';
import 'package:flutter/foundation.dart';

/// Wrapper для Stream, чтобы работал с GoRouter.refreshListenable
///
/// GoRouter требует ChangeNotifier, но Cubit.stream это Stream.
/// Этот класс конвертирует Stream в ChangeNotifier.
///
/// Использование:
/// ```dart
/// refreshListenable: GoRouterRefreshStream(authCubit.stream)
/// ```
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
