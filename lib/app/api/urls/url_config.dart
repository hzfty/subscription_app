/// Конфигурация URL endpoints для API
///
/// ВАЖНО: Замените baseUrl на реальный API endpoint
class UrlConfig {
  UrlConfig._(); // Приватный конструктор

  // ============================================
  // BASE URL
  // ============================================
  static const String baseUrl =
      'https://api.example.com'; // Заменится при копировании шаблона

  // ============================================
  // AUTH ENDPOINTS
  // ============================================
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // ============================================
  // USER ENDPOINTS
  // ============================================
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile/update';

  // ============================================
  // FEATURE ENDPOINTS
  // ============================================
  // TODO: Добавьте endpoints для ваших features здесь
  // static const String items = '/items';
  // static const String itemById = '/items/{id}';

  // ============================================
  // HELPER METHODS
  // ============================================

  /// Получить полный URL
  /// Использование: UrlConfig.fullUrl(UrlConfig.login)
  static String fullUrl(String path) {
    return baseUrl + path;
  }

  /// Заменить параметр в URL
  /// Использование: UrlConfig.replaceParam('/items/{id}', 'id', '123')
  static String replaceParam(String path, String param, String value) {
    return path.replaceAll('{$param}', value);
  }
}
