import 'package:flutter/material.dart';
import '../../../../app/models/cards/card_type.dart';

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

  // Уровень доступа пользователя (для демо используем обычный доступ)
  // TODO: В будущем получать из UserCubit или AuthCubit
  static const bool _hasPlus = false;
  static const bool _hasPremium = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _isTypeEnabled(CardType type) {
    switch (type) {
      case CardType.normal:
        return true; // Доступен всем
      case CardType.plus:
        return _hasPlus || _hasPremium; // Доступен Плюс и Премиум пользователям
      case CardType.premium:
        return _hasPremium; // Доступен только Премиум пользователям
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
              Wrap(
                spacing: 8,
                children: CardType.values.map((type) {
                  final isEnabled = _isTypeEnabled(type);
                  final isSelected = _selectedType == type;

                  return ChoiceChip(
                    label: Text(type.displayName),
                    selected: isSelected,
                    onSelected: isEnabled
                        ? (selected) {
                            if (selected) {
                              setState(() {
                                _selectedType = type;
                              });
                            }
                          }
                        : null,
                    selectedColor: type.borderColor.withValues(alpha: 0.3),
                    backgroundColor: isEnabled
                        ? type.borderColor.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.1),
                    side: BorderSide(
                      color: isSelected
                          ? type.borderColor
                          : (isEnabled
                                ? type.borderColor.withValues(alpha: 0.5)
                                : Colors.grey),
                      width: isSelected ? 2 : 1,
                    ),
                    labelStyle: TextStyle(
                      color: isEnabled ? type.borderColor : Colors.grey,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                    showCheckmark: false,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Создать')),
      ],
    );
  }
}
