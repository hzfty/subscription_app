import 'package:flutter/material.dart';
import '../../../../app/models/cards/card_type.dart';

/// Чипы для выбора типа карточки
class CardTypeChips extends StatelessWidget {
  final CardType selectedType;
  final Function(CardType) onTypeSelected;
  final bool Function(CardType) isTypeEnabled;

  const CardTypeChips({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
    required this.isTypeEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: CardType.values.map((type) {
        final isEnabled = isTypeEnabled(type);
        final isSelected = selectedType == type;

        // Улучшенная контрастность для обычного типа
        final Color chipColor = type == CardType.normal
            ? Colors.grey[800]!
            : type.borderColor;

        return ChoiceChip(
          label: Text(type.displayName),
          selected: isSelected,
          onSelected: isEnabled
              ? (selected) {
                  if (selected) {
                    onTypeSelected(type);
                  }
                }
              : null,
          selectedColor: chipColor.withValues(alpha: 0.2),
          backgroundColor: isEnabled
              ? chipColor.withValues(alpha: 0.08)
              : Colors.grey.withValues(alpha: 0.05),
          disabledColor: Colors.grey.withValues(alpha: 0.05),
          side: BorderSide(
            color: isSelected
                ? chipColor
                : (isEnabled
                    ? chipColor.withValues(alpha: 0.5)
                    : Colors.grey.withValues(alpha: 0.2)),
            width: isSelected ? 2 : 1,
          ),
          labelStyle: TextStyle(
            color: isEnabled
                ? (isSelected ? chipColor : chipColor.withValues(alpha: 0.8))
                : Colors.grey.withValues(alpha: 0.4),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
          showCheckmark: false,
        );
      }).toList(),
    );
  }
}
