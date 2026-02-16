import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'auth_state.dart';

/// AuthCubit - управление состоянием авторизации
///
/// ВАЖНО:
/// 1. Используйте HydratedCubit для персистентности
/// 2. Всегда lazy: false в providers.dart
/// 3. Первый в списке providers (для router)
class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(const AuthState.unauthenticated());

  // ============================================
  // PUBLIC METHODS
  // ============================================

  /// Логин
  Future<void> login({required String email, required String password}) async {
    emit(const AuthState.loading());

    try {
      // TODO: Выполнить реальный запрос к API
      // final user = await AuthRequests().login(email, password);
      // final token = user.token;

      // Временная заглушка для примера
      await Future.delayed(const Duration(seconds: 1));

      emit(
        AuthState.authenticated(
          token: 'fake_token_12345',
          userId: 1,
          userName: 'John Doe',
        ),
      );
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
      emit(const AuthState.unauthenticated());
    }
  }

  /// Регистрация
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());

    try {
      // TODO: Выполнить реальный запрос к API
      // final user = await AuthRequests().register(
      //   name: name,
      //   email: email,
      //   password: password,
      // );
      // final token = user.token;

      // Временная заглушка для примера
      await Future.delayed(const Duration(seconds: 1));

      emit(
        AuthState.authenticated(
          token: 'fake_token_12345',
          userId: 1,
          userName: name,
        ),
      );
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
      emit(const AuthState.unauthenticated());
    }
  }

  /// Выход
  Future<void> logout() async {
    try {
      // TODO: Выполнить реальный запрос к API
      // await AuthRequests().logout();

      emit(const AuthState.unauthenticated());
    } catch (e) {
      // Всё равно выходим даже при ошибке
      emit(const AuthState.unauthenticated());
    }
  }

  /// Восстановление сессии (вызывается автоматически при запуске)
  Future<void> restoreSession() async {
    // HydratedCubit автоматически восстановит состояние
    // Можно добавить дополнительную логику здесь
    if (state.isAuthenticated && state.token != null) {
      // TODO: Проверить валидность токена
      // final isValid = await AuthRequests().validateToken(state.token!);
      // if (!isValid) {
      //   emit(const AuthState.unauthenticated());
      // }
    }
  }

  // ============================================
  // HYDRATED BLOC SERIALIZATION
  // ============================================

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    try {
      return AuthState.fromJson(json);
    } catch (e) {
      return const AuthState.unauthenticated();
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
