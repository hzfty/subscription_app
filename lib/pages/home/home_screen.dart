import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../app/models/cards/card_type.dart';
import 'api/home_cubit.dart';
import 'api/home_state.dart';
import 'components/lists/cards_list.dart';
import 'components/dialoges/create_card_dialog.dart';
import 'components/dialoges/delete_card_dialog.dart';

/// Главный экран приложения со списком карточек
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const _HomeScreenContent(),
    );
  }
}

/// Контент домашнего экрана
class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  Future<void> _showCreateCardDialog(BuildContext context) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const CreateCardDialog(),
    );

    if (result != null && context.mounted) {
      context.read<HomeCubit>().addCard(
        title: result['title'] as String,
        description: result['description'] as String?,
        type: result['type'] as CardType,
      );
    }
  }

  Future<void> _showDeleteCardDialog(
    BuildContext context,
    String cardId,
  ) async {
    final card = context.read<HomeCubit>().state.cards.firstWhere(
      (card) => card.id == cardId,
    );

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteCardDialog(card: card),
    );

    if (shouldDelete == true && context.mounted) {
      context.read<HomeCubit>().deleteCard(cardId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваш список'),
        actions: [
          // Кнопка перехода к экрану подписок
          IconButton(
            icon: const Icon(Icons.subscriptions),
            tooltip: 'Подписки',
            onPressed: () {
              context.go('/subscriptions');
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          // Плейсхолдер если карточек нет
          if (state.cards.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Список пуст',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Нажмите "+" чтобы создать карточку',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }

          // Список карточек
          return CardsList(
            cards: state.cards,
            onCardLongPress: (cardId) => _showDeleteCardDialog(context, cardId),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateCardDialog(context),
        tooltip: 'Создать карточку',
        child: const Icon(Icons.add),
      ),
    );
  }
}
