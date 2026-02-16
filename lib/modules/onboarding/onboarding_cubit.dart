import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'onboarding_state.dart';

/// Cubit для управления состоянием онбординга
///
/// Использует HydratedCubit для сохранения состояния между сессиями.
/// Онбординг показывается только при первом запуске приложения.
class OnboardingCubit extends HydratedCubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingInitial());

  /// Проверка, был ли показан онбординг
  bool get isCompleted => state is OnboardingCompleted;

  /// Завершить онбординг
  void complete() {
    emit(const OnboardingCompleted());
  }

  /// Сбросить онбординг (для тестирования)
  void reset() {
    emit(const OnboardingInitial());
  }

  @override
  OnboardingState? fromJson(Map<String, dynamic> json) {
    try {
      final completed = json['completed'] as bool? ?? false;
      return completed ? const OnboardingCompleted() : const OnboardingInitial();
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(OnboardingState state) {
    return {
      'completed': state is OnboardingCompleted,
    };
  }
}
