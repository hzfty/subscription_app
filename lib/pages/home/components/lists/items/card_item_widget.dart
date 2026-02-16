import 'package:flutter/material.dart';
import '../../../../../app/models/cards/card_item.dart';

/// Виджет для отображения карточки
class CardItemWidget extends StatelessWidget {
  final CardItem card;
  final VoidCallback onLongPress;

  const CardItemWidget({
    super.key,
    required this.card,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: card.type.borderColor, width: 2),
      ),
      child: InkWell(
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок и тип
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      card.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Чип с типом карточки
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: card.type.borderColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: card.type.borderColor,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      card.type.displayName,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: card.type.borderColor,
                      ),
                    ),
                  ),
                ],
              ),

              // Описание (если есть)
              if (card.description != null && card.description!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  card.description!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
