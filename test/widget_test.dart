import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:subscription_app/app/app.dart';

void main() {
  setUpAll(() async {
    // Мок для HydratedBloc storage в тестах
    HydratedBloc.storage = _MockStorage();
  });

  testWidgets('App smoke test', (WidgetTester tester) async {
    // Запуск приложения
    await tester.pumpWidget(const MyApp());

    // Проверка, что приложение запустилось
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

// Мок для HydratedBloc storage
class _MockStorage implements Storage {
  final Map<String, dynamic> _storage = {};

  @override
  dynamic read(String key) => _storage[key];

  @override
  Future<void> write(String key, dynamic value) async {
    _storage[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _storage.remove(key);
  }

  @override
  Future<void> clear() async {
    _storage.clear();
  }

  @override
  Future<void> close() async {}
}
