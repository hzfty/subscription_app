import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_page_state.dart';

/// Cubit для управления навигацией между страницами онбординга
class OnboardingPageCubit extends Cubit<OnboardingPageState> {
  OnboardingPageCubit({required int totalPages})
      : super(OnboardingPageState(currentPage: 0, totalPages: totalPages));

  /// Переход на следующую страницу
  void nextPage() {
    if (!state.isLastPage) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  /// Переход на предыдущую страницу
  void previousPage() {
    if (state.currentPage > 0) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }

  /// Переход на конкретную страницу
  void goToPage(int page) {
    if (page >= 0 && page < state.totalPages) {
      emit(state.copyWith(currentPage: page));
    }
  }
}
