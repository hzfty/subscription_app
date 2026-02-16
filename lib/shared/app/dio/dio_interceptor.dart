import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../modules/auth/auth_cubit.dart';
import '../exceptions/app_exception.dart';

/// Interceptor для добавления токена и обработки ошибок
///
/// ВАЖНО:
/// 1. Требует BuildContext для доступа к AuthCubit
/// 2. Добавляется в app.dart после первого фрейма
/// 3. При 401/403 выполняет forcedLogout()
class DioInterceptor extends Interceptor {
  final BuildContext context;

  DioInterceptor({required this.context});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Получить токен из AuthCubit
    final authCubit = context.read<AuthCubit>();
    final token = authCubit.state.token;

    // Добавить токен в headers если есть
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Проверить бизнес-логику ошибок в ответе
    // Например, если API возвращает { "success": false, "error": "..." }
    if (response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;

      // TODO: Адаптируйте под свой API формат
      if (data.containsKey('success') && data['success'] == false) {
        final error = data['error'] ?? 'Неизвестная ошибка';

        handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: error,
          ),
        );
        return;
      }
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Обработка 401/403 - принудительный logout
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      _handleUnauthorized();
    }

    // Конвертировать DioException в AppException
    final appException = _convertToAppException(err);

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: appException,
      ),
    );
  }

  /// Принудительный выход при 401/403
  void _handleUnauthorized() {
    final authCubit = context.read<AuthCubit>();
    authCubit.logout();

    // TODO: Показать уведомление пользователю
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Сессия истекла. Войдите заново.')),
    // );
  }

  /// Конвертировать DioException в AppException
  AppException _convertToAppException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppException(
          type: AppExceptionType.timeout,
          message: 'Превышено время ожидания',
          originalError: err,
        );

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;

        if (statusCode == 401 || statusCode == 403) {
          return AppException(
            type: AppExceptionType.unauthorized,
            message: 'Необходима авторизация',
            originalError: err,
          );
        }

        if (statusCode == 404) {
          return AppException(
            type: AppExceptionType.notFound,
            message: 'Ресурс не найден',
            originalError: err,
          );
        }

        if (statusCode != null && statusCode >= 500) {
          return AppException(
            type: AppExceptionType.server,
            message: 'Ошибка сервера',
            originalError: err,
          );
        }

        return AppException(
          type: AppExceptionType.network,
          message: err.response?.data?['error'] ?? 'Ошибка сети',
          originalError: err,
        );

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return AppException(
          type: AppExceptionType.network,
          message: 'Нет подключения к интернету',
          originalError: err,
        );

      case DioExceptionType.cancel:
        return AppException(
          type: AppExceptionType.cancelled,
          message: 'Запрос отменён',
          originalError: err,
        );

      default:
        return AppException(
          type: AppExceptionType.unknown,
          message: 'Неизвестная ошибка',
          originalError: err,
        );
    }
  }
}
