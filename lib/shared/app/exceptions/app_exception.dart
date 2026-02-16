/// Типизированные исключения приложения
///
/// Использование:
/// ```dart
/// throw AppException(
///   type: AppExceptionType.network,
///   message: 'Нет подключения к интернету',
/// );
/// ```
class AppException implements Exception {
  final AppExceptionType type;
  final String message;
  final dynamic originalError;
  final StackTrace? stackTrace;

  AppException({
    required this.type,
    required this.message,
    this.originalError,
    this.stackTrace,
  });

  /// Получить локализованное сообщение для UI
  String getLocalizedMessage() {
    switch (type) {
      case AppExceptionType.network:
        return 'Ошибка сети. Проверьте подключение к интернету.';
      case AppExceptionType.timeout:
        return 'Превышено время ожидания. Попробуйте позже.';
      case AppExceptionType.server:
        return 'Ошибка сервера. Попробуйте позже.';
      case AppExceptionType.unauthorized:
        return 'Необходима авторизация.';
      case AppExceptionType.forbidden:
        return 'Доступ запрещён.';
      case AppExceptionType.notFound:
        return 'Ресурс не найден.';
      case AppExceptionType.validation:
        return message; // Используем исходное сообщение
      case AppExceptionType.cancelled:
        return 'Операция отменена.';
      case AppExceptionType.unknown:
        return 'Неизвестная ошибка. Попробуйте позже.';
    }
  }

  @override
  String toString() {
    return 'AppException($type): $message';
  }
}

/// Типы ошибок приложения
enum AppExceptionType {
  /// Ошибка сети (нет интернета, DNS проблемы)
  network,

  /// Превышено время ожидания
  timeout,

  /// Ошибка сервера (5xx)
  server,

  /// Не авторизован (401)
  unauthorized,

  /// Доступ запрещён (403)
  forbidden,

  /// Ресурс не найден (404)
  notFound,

  /// Ошибка валидации данных
  validation,

  /// Операция отменена пользователем
  cancelled,

  /// Неизвестная ошибка
  unknown,
}
