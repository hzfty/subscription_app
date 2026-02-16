import 'package:equatable/equatable.dart';
import '../../../app/models/cards/card_item.dart';

/// Состояние домашнего экрана
class HomeState extends Equatable {
  final List<CardItem> cards;

  const HomeState({required this.cards});

  /// Начальное состояние с пустым списком карточек
  const HomeState.initial() : cards = const [];

  @override
  List<Object?> get props => [cards];

  HomeState copyWith({List<CardItem>? cards}) {
    return HomeState(cards: cards ?? this.cards);
  }

  /// Сериализация в JSON
  Map<String, dynamic> toJson() {
    return {'cards': cards.map((card) => card.toJson()).toList()};
  }

  /// Десериализация из JSON
  factory HomeState.fromJson(Map<String, dynamic> json) {
    return HomeState(
      cards:
          (json['cards'] as List<dynamic>?)
              ?.map((item) => CardItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
