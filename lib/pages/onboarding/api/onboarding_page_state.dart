import 'package:equatable/equatable.dart';

/// Состояние текущей страницы онбординга
class OnboardingPageState extends Equatable {
  final int currentPage;
  final int totalPages;

  const OnboardingPageState({
    required this.currentPage,
    required this.totalPages,
  });

  /// Проверка, является ли текущая страница последней
  bool get isLastPage => currentPage == totalPages - 1;

  @override
  List<Object?> get props => [currentPage, totalPages];

  OnboardingPageState copyWith({
    int? currentPage,
    int? totalPages,
  }) {
    return OnboardingPageState(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
