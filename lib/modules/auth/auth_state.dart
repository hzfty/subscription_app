/// Состояние авторизации
///
/// Использует enum + copyWith pattern для простоты
class AuthState {
  final AuthStatus status;
  final String? token;
  final int? userId;
  final String? userName;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.token,
    this.userId,
    this.userName,
    this.errorMessage,
  });

  // ============================================
  // NAMED CONSTRUCTORS
  // ============================================

  /// Не авторизован
  const AuthState.unauthenticated()
    : status = AuthStatus.unauthenticated,
      token = null,
      userId = null,
      userName = null,
      errorMessage = null;

  /// Загрузка (логин/регистрация в процессе)
  const AuthState.loading()
    : status = AuthStatus.loading,
      token = null,
      userId = null,
      userName = null,
      errorMessage = null;

  /// Авторизован
  const AuthState.authenticated({
    required this.token,
    required this.userId,
    required this.userName,
  }) : status = AuthStatus.authenticated,
       errorMessage = null;

  /// Ошибка
  const AuthState.error({required String message})
    : status = AuthStatus.error,
      token = null,
      userId = null,
      userName = null,
      errorMessage = message;

  // ============================================
  // GETTERS
  // ============================================

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLoading => status == AuthStatus.loading;
  bool get hasError => status == AuthStatus.error;

  // ============================================
  // COPY WITH
  // ============================================

  AuthState copyWith({
    AuthStatus? status,
    String? token,
    int? userId,
    String? userName,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      token: token ?? this.token,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // ============================================
  // SERIALIZATION (для HydratedCubit)
  // ============================================

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(
      status: AuthStatus.values[json['status'] as int],
      token: json['token'] as String?,
      userId: json['userId'] as int?,
      userName: json['userName'] as String?,
      errorMessage: json['errorMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.index,
      'token': token,
      'userId': userId,
      'userName': userName,
      'errorMessage': errorMessage,
    };
  }
}

/// Статусы авторизации
enum AuthStatus {
  /// Не авторизован
  unauthenticated,

  /// Загрузка (логин/регистрация в процессе)
  loading,

  /// Авторизован
  authenticated,

  /// Ошибка
  error,
}
