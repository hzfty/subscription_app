import 'package:equatable/equatable.dart';

/// Состояние онбординга
sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

/// Начальное состояние
class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

/// Онбординг завершён
class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}
