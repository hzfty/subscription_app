# Entities (Модели данных)

Entities — это классы, которые представляют данные, получаемые от API или отправляемые в API.

## Naming Convention

**ВАЖНО**: Используйте **I-prefix** для всех entity классов:

```dart
class IUser { }       // ✅ Правильно
class User { }        // ❌ Неправильно

class IItem { }       // ✅ Правильно
class Item { }        // ❌ Неправильно

class IFeature { }    // ✅ Правильно
class Feature { }     // ❌ Неправильно
```

## Структура Entity

Каждый entity должен содержать:
1. Поля данных
2. `fromJson()` конструктор для десериализации
3. `toJson()` метод для сериализации
4. `copyWith()` для immutable updates (опционально)

## Пример

```dart
class IUser {
  final int id;
  final String name;
  final String email;
  final DateTime? createdAt;

  const IUser({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
  });

  /// Десериализация из JSON
  factory IUser.fromJson(Map<String, dynamic> json) {
    return IUser(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  /// Сериализация в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  /// Immutable update
  IUser copyWith({
    int? id,
    String? name,
    String? email,
    DateTime? createdAt,
  }) {
    return IUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
```

## Организация файлов

Для небольших проектов:
```
entities/
├── i_user.dart
├── i_item.dart
└── i_feature.dart
```

Для масштабных проектов (domain organization):
```
entities/
├── auth/
│   ├── i_user.dart
│   └── i_token.dart
├── items/
│   ├── i_item.dart
│   └── i_category.dart
└── README.md
```

См. также: `modules/base/arch/naming-conventions.md`
