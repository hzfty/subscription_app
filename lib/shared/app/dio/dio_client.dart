import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Singleton Dio клиент для всех HTTP запросов
///
/// ВАЖНО:
/// 1. Используйте DioClient.instance.dio для запросов
/// 2. Добавляйте interceptors через addInterceptor()
/// 3. DioInterceptor добавляется в app.dart после получения context
class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() => _instance;
  static DioClient get instance => _instance;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        // TODO: Заменить на реальный baseUrl из UrlConfig
        baseUrl: 'https://api.example.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Логирование в debug режиме
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  /// Добавить interceptor (например, DioInterceptor для auth)
  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

  /// Удалить interceptor
  void removeInterceptor(Interceptor interceptor) {
    dio.interceptors.remove(interceptor);
  }

  /// Очистить все interceptors (кроме logger)
  void clearInterceptors() {
    dio.interceptors.clear();
    // Вернуть logger
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }
}
