import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../app/models/cards/card_item.dart';
import '../../../app/models/cards/card_type.dart';
import 'home_state.dart';

/// Cubit для управления списком карточек на домашнем экране
///
/// Использует HydratedCubit для сохранения списка карточек между сессиями
class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit() : super(const HomeState.initial());

  /// Добавить новую карточку
  void addCard({
    required String title,
    String? description,
    required CardType type,
  }) {
    final newCard = CardItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      type: type,
      createdAt: DateTime.now(),
    );

    emit(state.copyWith(cards: [...state.cards, newCard]));
  }

  /// Удалить карточку по ID
  void deleteCard(String id) {
    final updatedCards = state.cards.where((card) => card.id != id).toList();
    emit(state.copyWith(cards: updatedCards));
  }

  /// Обновить карточку
  void updateCard(CardItem updatedCard) {
    final updatedCards = state.cards.map((card) {
      return card.id == updatedCard.id ? updatedCard : card;
    }).toList();

    emit(state.copyWith(cards: updatedCards));
  }

  /// Очистить все карточки
  void clearCards() {
    emit(const HomeState.initial());
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    try {
      return HomeState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    try {
      return state.toJson();
    } catch (_) {
      return null;
    }
  }
}
