import 'package:equatable/equatable.dart';
import 'card_type.dart';

/// Модель карточки для домашнего экрана
class CardItem extends Equatable {
  final String id;
  final String title;
  final String? description;
  final CardType type;
  final DateTime createdAt;

  const CardItem({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, description, type, createdAt];

  CardItem copyWith({
    String? id,
    String? title,
    String? description,
    CardType? type,
    DateTime? createdAt,
  }) {
    return CardItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Сериализация в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Десериализация из JSON
  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type: CardType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => CardType.normal,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
