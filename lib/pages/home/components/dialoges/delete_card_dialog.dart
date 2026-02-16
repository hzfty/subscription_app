import 'package:flutter/material.dart';
import '../../../../app/models/cards/card_item.dart';

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
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Удалить'),
        ),
      ],
    );
  }
}
