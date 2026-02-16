# Requests (API запросы)

Requests — это классы, которые содержат методы для работы с API endpoints.

## Когда использовать Requests

Используйте request классы для:
- HTTP запросов к API
- Группировки связанных endpoints
- Обработки response и errors
- Конвертации JSON в entities

## Flat Structure (для простых проектов)

Для проектов с < 10 endpoints:

```
requests/
├── auth_requests.dart
├── user_requests.dart
└── item_requests.dart
```

Пример:
```dart
// auth_requests.dart
import 'package:dio/dio.dart';
import '../../shared/app/dio/dio_client.dart';
import '../urls/url_config.dart';
import '../entities/i_user.dart';

class AuthRequests {
  final Dio _dio = DioClient.instance.dio;

  /// Логин
  Future<IUser> login(String email, String password) async {
    final response = await _dio.post(
      UrlConfig.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    return IUser.fromJson(response.data['user']);
  }

  /// Регистрация
  Future<IUser> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      UrlConfig.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    return IUser.fromJson(response.data['user']);
  }
}
```

## Domain Organization (для масштабных проектов)

Для проектов с > 10 endpoints, организуйте по доменам:

```
requests/
├── auth/
│   ├── index.dart      # Класс AuthRequests
│   └── types.dart      # DTOs для auth
├── items/
│   ├── index.dart      # Класс ItemsRequests
│   └── types.dart      # DTOs для items
└── README.md
```

Пример `auth/index.dart`:
```dart
import 'package:dio/dio.dart';
import '../../../shared/app/dio/dio_client.dart';
import '../../urls/url_config.dart';
import '../../entities/i_user.dart';
import 'types.dart';

class AuthRequests {
  final Dio _dio = DioClient.instance.dio;

  Future<IUser> login(LoginDTO dto) async {
    final response = await _dio.post(
      UrlConfig.login,
      data: dto.toJson(),
    );
    return IUser.fromJson(response.data['user']);
  }
}
```

Пример `auth/types.dart`:
```dart
/// DTO для логина
class LoginDTO {
  final String email;
  final String password;

  const LoginDTO({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

/// DTO для регистрации
class RegisterDTO {
  final String name;
  final String email;
  final String password;

  const RegisterDTO({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
```

## Выбор структуры

| Критерий | Flat Structure | Domain Organization |
|----------|---------------|---------------------|
| Количество endpoints | < 10 | > 10 |
| Сложность API | Простой | Сложный |
| Команда | 1-2 разработчика | 3+ разработчиков |
| Рост проекта | Нет планов роста | Планируется рост |

См. также: `modules/base/api-structure/domain-organization.md`
