import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../app/models/subscription/subscription_plan.dart';
import '../../modules/subscription/user_subscription_cubit.dart';
import 'api/paywall_cubit.dart';
import 'api/paywall_state.dart';
import 'components/buttons/continue_button.dart';
import 'components/lists/cards/subscription_cards_list.dart';

/// Экран выбора подписки (paywall)
class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaywallCubit(),
      child: const _PaywallScreenContent(),
    );
  }
}

/// Контент экрана paywall
class _PaywallScreenContent extends StatelessWidget {
  const _PaywallScreenContent();

  void _onPurchase(BuildContext context) {
    final selectedPlan = context.read<PaywallCubit>().state.selectedPlan;

    if (selectedPlan == null) return;

    // Эмулируем покупку - активируем подписку
    context.read<UserSubscriptionCubit>().activateSubscription(
      selectedPlan.type,
    );

    // Показываем сообщение об успехе
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Подписка "${selectedPlan.title}" успешно активирована!'),
        backgroundColor: selectedPlan.color,
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Возвращаемся на главный экран
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подписки'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).colorScheme.onPrimary,
          onPressed: () => context.go('/'),
        ),
      ),
      body: BlocBuilder<PaywallCubit, PaywallState>(
        builder: (context, state) {
          return Column(
            children: [
              // Список карточек подписок
              Expanded(
                child: SubscriptionCardsList(
                  plans: SubscriptionPlan.availablePlans,
                  selectedPlanId: state.selectedPlan?.id,
                  onPlanSelected: (plan) {
                    context.read<PaywallCubit>().selectPlan(plan);
                  },
                ),
              ),

              // Кнопка "Продолжить"
              ContinueButton(
                selectedPlan: state.selectedPlan,
                onPressed: () => _onPurchase(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
