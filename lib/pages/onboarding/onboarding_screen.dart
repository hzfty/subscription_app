import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../modules/onboarding/onboarding_cubit.dart';
import 'api/onboarding_page_cubit.dart';
import 'api/onboarding_page_state.dart';
import 'components/onboarding_buttons.dart';
import 'components/onboarding_page.dart';
import 'components/page_indicator.dart';

/// Экран онбординга с двумя страницами
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  // Данные для страниц онбординга
  static const List<_PageData> _pages = [
    _PageData(icon: Icons.list_alt, text: 'Создавайте элементы списка'),
    _PageData(
      icon: Icons.rocket_launch,
      text: 'Получайте доступ к новым функциям',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingPageCubit(totalPages: _pages.length),
      child: const _OnboardingScreenContent(),
    );
  }
}

/// Контент экрана онбординга
class _OnboardingScreenContent extends StatefulWidget {
  const _OnboardingScreenContent();

  @override
  State<_OnboardingScreenContent> createState() =>
      _OnboardingScreenContentState();
}

class _OnboardingScreenContentState extends State<_OnboardingScreenContent> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    context.read<OnboardingPageCubit>().goToPage(page);
  }

  void _nextPage() {
    final cubit = context.read<OnboardingPageCubit>();
    cubit.nextPage();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _completeOnboarding() {
    context.read<OnboardingCubit>().complete();
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<OnboardingPageCubit, OnboardingPageState>(
          builder: (context, state) {
            return Column(
              children: [
                // PageView с контентом
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: OnboardingScreen._pages.length,
                    itemBuilder: (context, index) {
                      final page = OnboardingScreen._pages[index];
                      return OnboardingPage(icon: page.icon, text: page.text);
                    },
                  ),
                ),

                // Индикатор страниц
                PageIndicator(
                  currentPage: state.currentPage,
                  pageCount: state.totalPages,
                ),

                const SizedBox(height: 32),

                // Кнопки навигации
                OnboardingButtons(
                  isLastPage: state.isLastPage,
                  onNext: _nextPage,
                  onComplete: _completeOnboarding,
                ),

                const SizedBox(height: 40),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Данные для одной страницы онбординга
class _PageData {
  final IconData icon;
  final String text;

  const _PageData({required this.icon, required this.text});
}
