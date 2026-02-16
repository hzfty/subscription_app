import 'package:flutter/material.dart';
import '../../../../app/models/cards/card_item.dart';
import '../../../../shared/components/buttons/primary_button.dart';
import '../../../../shared/components/buttons/secondary_button.dart';

/// Диалог для подтверждения удаления карточки
class DeleteCardDialog extends StatelessWidget {
  final CardItem card;

  const DeleteCardDialog({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить карточку?'),
      content: Text('Вы уверены, что хотите удалить карточку "${card.title}"?'),
      actions: [
        SecondaryButton(
          text: 'Отмена',
          onPressed: () => Navigator.of(context).pop(false),
        ),
        PrimaryButton(
          text: 'Удалить',
          onPressed: () => Navigator.of(context).pop(true),
          backgroundColor: Colors.red,
          height: 48,
        ),
      ],
    );
  }
}
