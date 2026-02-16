/// Все маршруты приложения
///
/// Использование:
/// - context.goNamed(AppRoutes.home.name)
/// - AppRoutes.home.path для redirect
enum AppRoutes {
  auth('/auth'),
  home('/'),
  profile('/profile'),
  settings('/settings');

  final String path;
  const AppRoutes(this.path);

  String get name => toString().split('.').last;
}
