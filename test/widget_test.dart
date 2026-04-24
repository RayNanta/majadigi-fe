import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:majadigi_mobile/app/app.dart';
import 'package:majadigi_mobile/core/providers/core_providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('navigates from welcome page to sign up step three', (
    WidgetTester tester,
  ) async {
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

    final daftarButton = find.widgetWithText(FilledButton, 'Daftar');
    await tester.ensureVisible(daftarButton);
    await tester.tap(daftarButton);
    await tester.pumpAndSettle();

    expect(find.text('Langkah 1 dari 2'), findsOneWidget);
    expect(find.text('Nama Lengkap'), findsOneWidget);
    expect(find.text('No HP'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);

    FilledButton nextButton = tester.widget(
      find.widgetWithText(FilledButton, 'Selanjutnya'),
    );
    expect(nextButton.onPressed, isNull);

    await tester.enterText(find.byType(TextField).at(0), 'Ray Nanta');
    await tester.enterText(find.byType(TextField).at(1), '08123456789');
    await tester.enterText(find.byType(TextField).at(2), 'ray@example.com');
    await tester.pump();

    nextButton = tester.widget(
      find.widgetWithText(FilledButton, 'Selanjutnya'),
    );
    expect(nextButton.onPressed, isNotNull);

    final nextButtonFinder = find.widgetWithText(FilledButton, 'Selanjutnya');
    await tester.ensureVisible(nextButtonFinder);
    await tester.tap(nextButtonFinder);
    await tester.pumpAndSettle();

    expect(find.text('Langkah 2 dari 2'), findsOneWidget);
    expect(find.text('Alamat'), findsOneWidget);
    expect(find.text('NIK'), findsOneWidget);
    expect(find.text('Tanggal Lahir'), findsOneWidget);
    expect(find.text('Konfirmasi Kata Sandi'), findsOneWidget);

    FilledButton submitButton = tester.widget(
      find.widgetWithText(FilledButton, 'Daftar'),
    );
    expect(submitButton.onPressed, isNull);

    await tester.enterText(
      find.byType(TextField).at(0),
      'Jl. Majapahit No. 10',
    );
    await tester.enterText(find.byType(TextField).at(1), '3578012345678901');
    final birthDateToggle = find.byIcon(Icons.expand_more_rounded);
    await tester.ensureVisible(birthDateToggle);
    await tester.tap(birthDateToggle);
    await tester.pumpAndSettle();
    await tester.tap(find.text('15').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(3), 'rahasia123');
    await tester.enterText(find.byType(TextField).at(4), 'rahasia123');
    await tester.pump();

    submitButton = tester.widget(find.widgetWithText(FilledButton, 'Daftar'));
    expect(submitButton.onPressed, isNotNull);

    final submitButtonFinder = find.widgetWithText(FilledButton, 'Daftar');
    await tester.ensureVisible(submitButtonFinder);
    await tester.tap(submitButtonFinder);
    await tester.pumpAndSettle();

    expect(find.text('Pilih Layanan'), findsOneWidget);
    expect(find.text('Lewati'), findsOneWidget);
    expect(find.text('Kesehatan'), findsOneWidget);
    expect(find.text('Unduh Layanan'), findsOneWidget);
  });

  testWidgets('navigates from sign in page to sign up step one', (
    WidgetTester tester,
  ) async {
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

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    final masukButton = find.widgetWithText(TextButton, 'Masuk');
    await tester.ensureVisible(masukButton);
    await tester.tap(masukButton);
    await tester.pumpAndSettle();

    expect(find.widgetWithText(FilledButton, 'Masuk'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Kata Sandi'), findsOneWidget);

    final daftarDuluButton = find.widgetWithText(TextButton, 'Daftar dulu');
    await tester.ensureVisible(daftarDuluButton);
    await tester.tap(daftarDuluButton);
    await tester.pumpAndSettle();

    expect(find.text('Daftar'), findsOneWidget);
    expect(find.text('Langkah 1 dari 2'), findsOneWidget);
  });
}
