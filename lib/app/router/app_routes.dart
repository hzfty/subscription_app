/// Все маршруты приложения
///
/// Использование:
/// - context.goNamed(AppRoutes.home.name)
/// - AppRoutes.home.path для redirect
enum AppRoutes {
  onboarding('/onboarding'),
  home('/'),
  subscriptions('/subscriptions'),
  subscriptionDetail('/subscription/:id'),
  paywall('/paywall');

  final String path;
  const AppRoutes(this.path);

  String get name => toString().split('.').last;
}
