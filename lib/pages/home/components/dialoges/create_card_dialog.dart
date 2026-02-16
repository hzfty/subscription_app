import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/models/cards/card_type.dart';
import '../../../../shared/components/buttons/primary_button.dart';
import '../../../../shared/components/buttons/secondary_button.dart';
import '../../../../modules/subscription/user_subscription_cubit.dart';
import '../inputs/card_type_chips.dart';

/// Диалог для создания новой карточки
class CreateCardDialog extends StatefulWidget {
  const CreateCardDialog({super.key});

  @override
  State<CreateCardDialog> createState() => _CreateCardDialogState();
}

class _CreateCardDialogState extends State<CreateCardDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  CardType _selectedType = CardType.normal;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _isTypeEnabled(CardType type) {
    final subscription = context.read<UserSubscriptionCubit>().state;

    switch (type) {
      case CardType.normal:
        return true; // Доступен всем
      case CardType.plus:
        return subscription
            .type
            .hasPlus; // Доступен Плюс и Премиум пользователям
      case CardType.premium:
        return subscription
            .type
            .hasPremium; // Доступен только Премиум пользователям
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        'type': _selectedType,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Создать карточку'),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Поле "Название"
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Название',
                  hintText: 'Введите название карточки',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Название обязательно';
                  }
                  return null;
                },
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: 16),

              // Поле "Описание"
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Описание (необязательно)',
                  hintText: 'Введите описание',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: 24),

              // Выбор типа карточки
              const Text(
                'Тип карточки:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 12),

              // Чипы для выбора типа
              CardTypeChips(
                selectedType: _selectedType,
                onTypeSelected: (type) {
                  setState(() {
                    _selectedType = type;
                  });
                },
                isTypeEnabled: _isTypeEnabled,
              ),
            ],
          ),
        ),
      ),
      actions: [
        SecondaryButton(
          text: 'Отмена',
          onPressed: () => Navigator.of(context).pop(),
        ),
        PrimaryButton(text: 'Создать', onPressed: _submit, height: 48),
      ],
    );
  }
}
