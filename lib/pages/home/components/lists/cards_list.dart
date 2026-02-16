import 'package:flutter/material.dart';
import '../../../../app/models/cards/card_item.dart';
import 'items/card_item_widget.dart';

/// Список карточек
class CardsList extends StatelessWidget {
  final List<CardItem> cards;
  final void Function(String cardId) onCardLongPress;

  const CardsList({
    super.key,
    required this.cards,
    required this.onCardLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CardItemWidget(
            card: card,
            onLongPress: () => onCardLongPress(card.id),
          ),
        );
      },
    );
  }
}
