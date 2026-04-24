import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:majadigi_mobile/app/app.dart';
import 'package:majadigi_mobile/core/providers/core_providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders app shell', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final sharedPreferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
        ],
        child: const MajadigiApp(),
      ),
    );
    await tester.pump();

    expect(find.text('Powered by'), findsOneWidget);
    expect(find.text('Pemerintah Provinsi Jawa Timur'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Selamat Datang di'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Daftar'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Masuk'), findsOneWidget);

    final masukButton = find.widgetWithText(TextButton, 'Masuk');
    await tester.ensureVisible(masukButton);
    await tester.tap(masukButton);
    await tester.pumpAndSettle();

    expect(find.widgetWithText(FilledButton, 'Masuk'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Kata Sandi'), findsOneWidget);
  });
}
