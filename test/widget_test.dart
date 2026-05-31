import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:majadigi_mobile/app/app.dart';
import 'package:majadigi_mobile/core/providers/core_providers.dart';
import 'package:majadigi_mobile/features/home/routes.dart';

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

    final daftarButton = find.text('Daftar').first;
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

  testWidgets('opens daftar layanan saya from home layanan saya lainnya tile', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Layanan Saya'), findsOneWidget);

    final lainnyaLabel = find.text('Lainnya').first;
    await tester.dragUntilVisible(
      lainnyaLabel,
      find.byType(CustomScrollView),
      const Offset(0, -280),
    );
    await tester.pumpAndSettle();
    await tester.tap(lainnyaLabel);
    await tester.pumpAndSettle();

    expect(find.text('Daftar Layanan Saya'), findsOneWidget);
    expect(find.text('Badan Pendapatan Daerah'), findsOneWidget);
  });

  testWidgets('opens skrining tbc page from home layanan saya tile', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final skriningTile = find.text('Skrining\nTBC');
    await tester.dragUntilVisible(
      skriningTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(skriningTile);
    await tester.pumpAndSettle();

    expect(find.text('Skrining TBC Mandiri'), findsOneWidget);
    expect(find.text('Unduh Layanan'), findsOneWidget);
    expect(find.text('Manfaat'), findsOneWidget);
  });

  testWidgets('opens rsud saiful anwar page from home layanan saya tile', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final rsudTile = find.text('RSUD Saiful\nAnwar');
    await tester.dragUntilVisible(
      rsudTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(rsudTile);
    await tester.pumpAndSettle();

    expect(find.text('RSUD SAIFUL ANWAR'), findsWidgets);
    expect(find.text('Pembaruan Real-time'), findsOneWidget);
    expect(find.text('Lihat Hitungan Real-time'), findsOneWidget);
  });

  testWidgets('opens bapenda jatim page from home layanan saya tile', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final bapendaTile = find.text('Bapenda\nJatim');
    await tester.dragUntilVisible(
      bapendaTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(bapendaTile);
    await tester.pumpAndSettle();

    expect(find.text('BAPENDA JATIM'), findsWidgets);
    expect(find.text('Manfaat'), findsOneWidget);
    expect(find.text('Masukan No. Polisi'), findsOneWidget);
  });

  testWidgets(
    'opens rsud saiful anwar main page from overview download button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.path,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final rsudTile = find.text('RSUD Saiful\nAnwar');
      await tester.dragUntilVisible(
        rsudTile,
        find.byType(CustomScrollView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(rsudTile);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      expect(find.text('Terakhir Diperbarui'), findsOneWidget);
      expect(find.text('Senin, 24 Mei 2024'), findsOneWidget);
      expect(find.text('Ketersediaan Ruang'), findsOneWidget);
      expect(find.text('R. SEMERU'), findsOneWidget);
      expect(find.text('R. ICU KAPUAS B'), findsOneWidget);
    },
  );

  testWidgets('opens bapenda jatim main page from overview download button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final bapendaTile = find.text('Bapenda\nJatim');
    await tester.dragUntilVisible(
      bapendaTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(bapendaTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    expect(find.text('Fitur Utama'), findsOneWidget);
    expect(
      find.text('Informasi Pajak Kendaraan Bermotor (PKB)'),
      findsOneWidget,
    );
    final njkbTitle = find.textContaining('Info Nilai Jual Kendaraan Bermotor');
    await tester.dragUntilVisible(
      njkbTitle,
      find.byType(Scrollable).first,
      const Offset(0, -240),
    );
    await tester.pumpAndSettle();

    expect(njkbTitle, findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Selengkapnya'), findsWidgets);
  });

  testWidgets('opens informasi pkb form from bapenda main page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final bapendaTile = find.text('Bapenda\nJatim');
    await tester.dragUntilVisible(
      bapendaTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(bapendaTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final pkbButton = find.widgetWithText(FilledButton, 'Selengkapnya').first;
    await tester.dragUntilVisible(
      pkbButton,
      find.byType(Scrollable).first,
      const Offset(0, -180),
    );
    await tester.pumpAndSettle();
    await tester.tap(pkbButton);
    await tester.pumpAndSettle();

    expect(find.text('Informasi PKB'), findsWidgets);
    expect(find.text('Data Kendaraan'), findsOneWidget);
    expect(find.text('Plat Nomor Kendaraan'), findsOneWidget);
    expect(find.text('5 Digit Terakhir Nomor Rangka'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'N 3315 TAK');
    await tester.enterText(find.byType(TextField).at(1), '12345');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Cari Data'));
    await tester.pumpAndSettle();

    expect(find.text('Identitas Kendaraan'), findsOneWidget);
    expect(find.text('Biaya Penul Tahunan'), findsOneWidget);
    expect(find.text('Biaya Penul 5 Tahunan'), findsOneWidget);
    expect(find.text('N 3315 TAK'), findsWidgets);
    expect(find.text('AKTIF'), findsOneWidget);
  });

  testWidgets('opens informasi njkb form from bapenda main page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final bapendaTile = find.text('Bapenda\nJatim');
    await tester.dragUntilVisible(
      bapendaTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(bapendaTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final njkbTitle = find.textContaining('Info Nilai Jual Kendaraan Bermotor');
    await tester.dragUntilVisible(
      njkbTitle,
      find.byType(Scrollable).first,
      const Offset(0, -240),
    );
    await tester.pumpAndSettle();

    final njkbButton = find.widgetWithText(FilledButton, 'Selengkapnya').last;
    await tester.tap(njkbButton);
    await tester.pumpAndSettle();

    expect(find.text('Informasi NJKB'), findsWidgets);
    expect(find.text('Jenis Kendaraan'), findsOneWidget);
    expect(find.text('Merk Kendaraan'), findsOneWidget);
    expect(find.text('Tahun Kendaraan'), findsOneWidget);
    expect(find.text('Model Kendaraan'), findsOneWidget);
    expect(find.text('Tipe Kendaraan'), findsOneWidget);

    Future<void> selectNjkbDropdown(int index, String itemText) async {
      final dropdown = find.byType(DropdownButtonFormField<String>).at(index);

      await tester.ensureVisible(dropdown);
      await tester.pumpAndSettle();
      await tester.tap(dropdown, warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.tap(find.text(itemText).last);
      await tester.pumpAndSettle();
    }

    await selectNjkbDropdown(0, 'Sepeda Motor');
    await selectNjkbDropdown(1, 'Honda');
    await selectNjkbDropdown(2, '2025');
    await selectNjkbDropdown(3, 'Beat');
    await selectNjkbDropdown(4, 'CBS');

    await tester.tap(find.widgetWithText(FilledButton, 'Cari Data'));
    await tester.pumpAndSettle();

    expect(find.text('Informasi NJKB'), findsWidgets);
    expect(find.text('Identitas Kendaraan'), findsOneWidget);
    expect(find.text('Penerimaan Negara Bukan Pajak'), findsOneWidget);
    expect(find.text('SEPEDA MOTOR'), findsOneWidget);
    expect(find.text('HONDA'), findsOneWidget);
    expect(find.text('110CC'), findsOneWidget);
  });

  testWidgets('installs and opens sidita page from layanan grid', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final siditaTile = find.text('SIDITA');
    await tester.ensureVisible(siditaTile);
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();

    expect(find.text('✓ Terpasang'), findsWidgets);

    await tester.tap(siditaTile);
    await tester.pumpAndSettle();

    expect(find.text('SIDITA'), findsWidgets);
    expect(find.text('Unduh Layanan'), findsOneWidget);
    expect(find.text('Data dan informasi valid'), findsOneWidget);
    expect(find.text('Pilih Destinasi'), findsOneWidget);
  });

  testWidgets('installs and opens islamic center page from layanan grid', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final islamicCenterTile = find.text('Islamic\nCenter');
    await tester.ensureVisible(islamicCenterTile);
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();

    expect(find.text('✓ Terpasang'), findsWidgets);

    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();

    expect(find.text('ISLAMIC CENTER JAWA TIMUR'), findsOneWidget);
    expect(find.text('Booking Instan'), findsOneWidget);
    expect(find.text('Konfirmasi Pembayaran'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Unduh Layanan'), findsOneWidget);
  });

  testWidgets('opens islamic center main page from overview download button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final islamicCenterTile = find.text('Islamic\nCenter');
    await tester.ensureVisible(islamicCenterTile);
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    expect(find.text('Pilih Fasilitas Sesuai Kebutuhan Anda'), findsOneWidget);
    expect(find.text('Aula'), findsOneWidget);
    final asramaText = find.text('Asrama');
    await tester.dragUntilVisible(
      asramaText,
      find.byType(Scrollable),
      const Offset(0, -240),
    );
    await tester.pumpAndSettle();
    expect(asramaText, findsOneWidget);

    final ruanganMasjidText = find.text('Ruangan Masjid');
    await tester.dragUntilVisible(
      ruanganMasjidText,
      find.byType(Scrollable),
      const Offset(0, -240),
    );
    await tester.pumpAndSettle();
    expect(ruanganMasjidText, findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Lihat Detail'), findsWidgets);
  });

  testWidgets('opens islamic center aula detail page from main page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final islamicCenterTile = find.text('Islamic\nCenter');
    await tester.ensureVisible(islamicCenterTile);
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Aula'));
    await tester.pumpAndSettle();

    expect(find.text('Aula'), findsWidgets);
    expect(find.text('Pilihan Ruangan'), findsOneWidget);
    expect(find.text('Hall Utama'), findsOneWidget);
    expect(find.text('Beri Ulasan'), findsOneWidget);
    expect(find.text('Ulasan'), findsOneWidget);
  });

  testWidgets('opens islamic center asrama detail page from main page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final islamicCenterTile = find.text('Islamic\nCenter');
    await tester.ensureVisible(islamicCenterTile);
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final asramaButton = find.byKey(const ValueKey('facility-detail-Asrama'));
    await tester.dragUntilVisible(
      asramaButton,
      find.byType(Scrollable).first,
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    await tester.tap(asramaButton);
    await tester.pumpAndSettle();

    expect(find.text('Asrama'), findsWidgets);
    expect(find.text('Pilihan Ruangan'), findsOneWidget);
    expect(find.text('Kamar 2 Bed'), findsOneWidget);
    expect(find.text('Beri Ulasan'), findsOneWidget);
    expect(find.text('Ulasan'), findsOneWidget);
  });

  testWidgets('opens islamic center masjid detail page from main page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final islamicCenterTile = find.text('Islamic\nCenter');
    await tester.ensureVisible(islamicCenterTile);
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final masjidButton = find.byKey(
      const ValueKey('facility-detail-Ruangan Masjid'),
    );
    await tester.dragUntilVisible(
      masjidButton,
      find.byType(Scrollable).first,
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    await tester.tap(masjidButton);
    await tester.pumpAndSettle();

    expect(find.text('Masjid'), findsWidgets);
    expect(find.text('Pilihan Ruangan'), findsOneWidget);
    expect(find.text('Ruang VIP Masjid'), findsOneWidget);
    expect(find.text('Beri Ulasan'), findsOneWidget);
    expect(find.text('Ulasan'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Kirim Ulasan'), findsOneWidget);
  });

  testWidgets('opens islamic center masjid room list from lihat semua button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final islamicCenterTile = find.text('Islamic\nCenter');
    await tester.ensureVisible(islamicCenterTile);
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final masjidButton = find.byKey(
      const ValueKey('facility-detail-Ruangan Masjid'),
    );
    await tester.dragUntilVisible(
      masjidButton,
      find.byType(Scrollable).first,
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    await tester.tap(masjidButton);
    await tester.pumpAndSettle();

    final seeAllButton = find.widgetWithText(TextButton, 'Lihat Semua').first;
    await tester.ensureVisible(seeAllButton);
    await tester.tap(seeAllButton);
    await tester.pumpAndSettle();

    expect(find.text('Ruangan Masjid'), findsWidgets);
    expect(find.text('Pilihan Ruangan'), findsOneWidget);
    expect(find.text('Ruang VIP Masjid'), findsOneWidget);

    final akadNikahPetugas = find.textContaining('Akad Nikah');
    await tester.dragUntilVisible(
      akadNikahPetugas,
      find.byType(Scrollable).first,
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();

    expect(akadNikahPetugas, findsOneWidget);

    final areaLuarMasjid = find.text('Area Luar Masjid');
    await tester.dragUntilVisible(
      areaLuarMasjid,
      find.byType(Scrollable).first,
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();

    expect(areaLuarMasjid, findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Detail Pemesanan'), findsWidgets);
  });

  testWidgets(
    'opens islamic center masjid booking form from room detail pemesanan button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.servicesPath,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final islamicCenterTile = find.text('Islamic\nCenter');
      await tester.ensureVisible(islamicCenterTile);
      await tester.tap(islamicCenterTile);
      await tester.pumpAndSettle();
      await tester.tap(islamicCenterTile);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      final masjidButton = find.byKey(
        const ValueKey('facility-detail-Ruangan Masjid'),
      );
      await tester.dragUntilVisible(
        masjidButton,
        find.byType(Scrollable).first,
        const Offset(0, -260),
      );
      await tester.pumpAndSettle();
      await tester.tap(masjidButton);
      await tester.pumpAndSettle();

      final seeAllButton = find.widgetWithText(TextButton, 'Lihat Semua').first;
      await tester.ensureVisible(seeAllButton);
      await tester.tap(seeAllButton);
      await tester.pumpAndSettle();

      final detailButton = find
          .widgetWithText(FilledButton, 'Detail Pemesanan')
          .first;
      await tester.dragUntilVisible(
        detailButton,
        find.byType(Scrollable).first,
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(detailButton);
      await tester.pumpAndSettle();

      expect(find.text('Booking Masjid'), findsOneWidget);
      expect(find.text('Data Pemesanan'), findsOneWidget);
      expect(find.text('Nama Lengkap'), findsOneWidget);
      expect(find.text('Tanggal'), findsOneWidget);
      expect(find.text('Sesi'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Pesan'), findsOneWidget);

      await tester.enterText(find.byType(TextField).first, 'Ray Nanta');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('24 Mei 2026').last);
      await tester.pumpAndSettle();

      final sesiLabel = find.text('Sesi');
      await tester.dragUntilVisible(
        sesiLabel,
        find.byType(Scrollable).first,
        const Offset(0, -180),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pagi').last);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Pesan'));
      await tester.pump();

      expect(
        find.textContaining('Data pemesanan Ruang VIP Masjid siap diproses.'),
        findsOneWidget,
      );
    },
  );

  testWidgets('opens islamic center asrama room list from lihat semua button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final islamicCenterTile = find.text('Islamic\nCenter');
    await tester.ensureVisible(islamicCenterTile);
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final asramaButton = find.byKey(const ValueKey('facility-detail-Asrama'));
    await tester.dragUntilVisible(
      asramaButton,
      find.byType(Scrollable).first,
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    await tester.tap(asramaButton);
    await tester.pumpAndSettle();

    final seeAllButton = find.widgetWithText(TextButton, 'Lihat Semua').first;
    await tester.ensureVisible(seeAllButton);
    await tester.tap(seeAllButton);
    await tester.pumpAndSettle();

    expect(find.text('Pilihan Ruangan'), findsOneWidget);
    expect(find.text('Kamar 2 Bed'), findsOneWidget);

    final kamar4Bed = find.text('Kamar 4 Bed');
    await tester.dragUntilVisible(
      kamar4Bed,
      find.byType(Scrollable).first,
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    expect(kamar4Bed, findsOneWidget);

    final kamar6Bed = find.text('Kamar 6 Bed');
    await tester.dragUntilVisible(
      kamar6Bed,
      find.byType(Scrollable).first,
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();

    expect(kamar6Bed, findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Detail Pemesanan'), findsWidgets);
  });

  testWidgets(
    'opens islamic center asrama booking form from room detail pemesanan button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.servicesPath,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final islamicCenterTile = find.text('Islamic\nCenter');
      await tester.ensureVisible(islamicCenterTile);
      await tester.tap(islamicCenterTile);
      await tester.pumpAndSettle();
      await tester.tap(islamicCenterTile);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      final asramaButton = find.byKey(const ValueKey('facility-detail-Asrama'));
      await tester.dragUntilVisible(
        asramaButton,
        find.byType(Scrollable).first,
        const Offset(0, -260),
      );
      await tester.pumpAndSettle();
      await tester.tap(asramaButton);
      await tester.pumpAndSettle();

      final seeAllButton = find.widgetWithText(TextButton, 'Lihat Semua').first;
      await tester.ensureVisible(seeAllButton);
      await tester.tap(seeAllButton);
      await tester.pumpAndSettle();

      final detailButton = find
          .widgetWithText(FilledButton, 'Detail Pemesanan')
          .first;
      await tester.dragUntilVisible(
        detailButton,
        find.byType(Scrollable).first,
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(detailButton);
      await tester.pumpAndSettle();

      expect(find.text('Booking Asrama'), findsOneWidget);
      expect(find.text('Data Pemesanan'), findsOneWidget);
      expect(find.text('Nama Lengkap'), findsOneWidget);
      expect(find.text('Tanggal'), findsOneWidget);
      expect(find.text('Fasilitas'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Pesan'), findsOneWidget);

      await tester.enterText(find.byType(TextField).first, 'Ray Nanta');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('24 Mei 2026').last);
      await tester.pumpAndSettle();

      final karpetText = find.text('Karpet');
      await tester.dragUntilVisible(
        karpetText,
        find.byType(Scrollable).first,
        const Offset(0, -180),
      );
      await tester.pumpAndSettle();
      await tester.tap(karpetText);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Pesan'));
      await tester.pump();

      expect(
        find.textContaining('Data pemesanan Kamar 2 Bed siap diproses.'),
        findsOneWidget,
      );
    },
  );

  testWidgets('opens islamic center aula room list from lihat semua button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final islamicCenterTile = find.text('Islamic\nCenter');
    await tester.ensureVisible(islamicCenterTile);
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();
    await tester.tap(islamicCenterTile);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Aula'));
    await tester.pumpAndSettle();

    final seeAllButton = find.widgetWithText(TextButton, 'Lihat Semua').first;
    await tester.ensureVisible(seeAllButton);
    await tester.tap(seeAllButton);
    await tester.pumpAndSettle();

    expect(find.text('Pilihan Ruangan'), findsOneWidget);
    expect(find.text('Hall Utama'), findsOneWidget);

    final ruangRapatText = find.text('Ruang Rapat');
    await tester.dragUntilVisible(
      ruangRapatText,
      find.byType(Scrollable).first,
      const Offset(0, -240),
    );
    await tester.pumpAndSettle();
    expect(ruangRapatText, findsOneWidget);

    final ruangVipText = find.text('Ruang VIP');
    await tester.dragUntilVisible(
      ruangVipText,
      find.byType(Scrollable).first,
      const Offset(0, -240),
    );
    await tester.pumpAndSettle();
    expect(ruangVipText, findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Detail Pemesanan'), findsWidgets);
  });

  testWidgets(
    'opens islamic center booking form from room detail pemesanan button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.servicesPath,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final islamicCenterTile = find.text('Islamic\nCenter');
      await tester.ensureVisible(islamicCenterTile);
      await tester.tap(islamicCenterTile);
      await tester.pumpAndSettle();
      await tester.tap(islamicCenterTile);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Aula'));
      await tester.pumpAndSettle();

      final seeAllButton = find.widgetWithText(TextButton, 'Lihat Semua').first;
      await tester.ensureVisible(seeAllButton);
      await tester.tap(seeAllButton);
      await tester.pumpAndSettle();

      final detailButton = find
          .widgetWithText(FilledButton, 'Detail Pemesanan')
          .first;
      await tester.dragUntilVisible(
        detailButton,
        find.byType(Scrollable).first,
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(detailButton);
      await tester.pumpAndSettle();

      expect(find.text('Booking Aula'), findsOneWidget);
      expect(find.text('Data Pemesanan'), findsOneWidget);
      expect(find.text('Nama Lengkap'), findsOneWidget);
      expect(find.text('Tanggal'), findsOneWidget);
      expect(find.text('Sesi'), findsOneWidget);
      expect(find.text('Fasilitas'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Pesan'), findsOneWidget);

      await tester.enterText(find.byType(TextField).first, 'Ray Nanta');
      await tester.pumpAndSettle();

      final karpetText = find.text('Karpet');
      await tester.dragUntilVisible(
        karpetText,
        find.byType(Scrollable).first,
        const Offset(0, -180),
      );
      await tester.pumpAndSettle();
      await tester.tap(karpetText);
      await tester.pumpAndSettle();
      expect(find.text('Ray Nanta'), findsOneWidget);
    },
  );

  testWidgets('opens sidita main page from overview download button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final siditaTile = find.text('SIDITA');
    await tester.ensureVisible(siditaTile);
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    expect(find.text('Apa yang Anda Perlukan?'), findsOneWidget);
    expect(find.text('Destinasi\nWisata'), findsOneWidget);
    expect(find.text('Akomodasi'), findsOneWidget);
    expect(find.text('Event'), findsOneWidget);
    expect(find.text('Wisatawan'), findsOneWidget);
  });

  testWidgets('opens khas jatim page from services catalog tile', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final khasJatimTile = find.text('Khas\nJatim');
    await tester.ensureVisible(khasJatimTile);
    await tester.tap(khasJatimTile);
    await tester.pumpAndSettle();
    await tester.tap(khasJatimTile);
    await tester.pumpAndSettle();

    expect(find.text('KHAS JATIM'), findsWidgets);
    expect(find.text('Pendataan\nTerpadu'), findsOneWidget);
    expect(find.text('Standar\nUNESCO'), findsOneWidget);
    expect(find.text('Lihat Koleksi Digital'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Unduh Layanan'), findsOneWidget);
  });

  testWidgets('opens khas jatim main page from overview download button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final khasJatimTile = find.text('Khas\nJatim');
    await tester.ensureVisible(khasJatimTile);
    await tester.tap(khasJatimTile);
    await tester.pumpAndSettle();
    await tester.tap(khasJatimTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    expect(find.text('Fitur Utama'), findsOneWidget);
    expect(find.text('Naskah Kuno Jawa Timur'), findsOneWidget);
    final pendaftaranFinder = find.textContaining('Daftarkan koleksi Anda');
    await tester.scrollUntilVisible(
      pendaftaranFinder,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Pendaftaran Naskah'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Telusuri'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Daftar'), findsOneWidget);
  });

  testWidgets('opens khas jatim manuscripts page and shows filter panel', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final khasJatimTile = find.text('Khas\nJatim');
    await tester.ensureVisible(khasJatimTile);
    await tester.tap(khasJatimTile);
    await tester.pumpAndSettle();
    await tester.tap(khasJatimTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final telusuriButton = find.widgetWithText(FilledButton, 'Telusuri');
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -180));
    await tester.pumpAndSettle();
    await tester.ensureVisible(telusuriButton);
    await tester.pumpAndSettle();
    await tester.tap(telusuriButton);
    await tester.pumpAndSettle();

    expect(find.text('Naskah Kuno Jawa Timur'), findsWidgets);
    expect(find.text('Serat Sri\nSedana'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Lihat Detail'), findsWidgets);

    await tester.tap(find.byKey(const Key('khas-jatim-filter-button')));
    await tester.pumpAndSettle();

    expect(find.text('Filter Pencarian'), findsOneWidget);
    expect(find.text('Kategori'), findsOneWidget);
    expect(find.text('Asal Daerah'), findsOneWidget);
    expect(find.text('Tahun Penulisan'), findsOneWidget);
    expect(find.text('Aksara'), findsOneWidget);
    expect(find.text('Bahasa'), findsOneWidget);
    expect(
      find.widgetWithText(FilledButton, 'Terapkan Filter'),
      findsOneWidget,
    );
    expect(find.text('Reset Filter'), findsOneWidget);
  });

  testWidgets('opens khas jatim manuscripts pagination page two safely', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final khasJatimTile = find.text('Khas\nJatim');
    await tester.ensureVisible(khasJatimTile);
    await tester.tap(khasJatimTile);
    await tester.pumpAndSettle();
    await tester.tap(khasJatimTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final telusuriButton = find.widgetWithText(FilledButton, 'Telusuri');
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -180));
    await tester.pumpAndSettle();
    await tester.ensureVisible(telusuriButton);
    await tester.pumpAndSettle();
    await tester.tap(telusuriButton);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('›'));
    await tester.tap(find.text('›'));
    await tester.pumpAndSettle();

    expect(find.text('Kidung\nTantu Panggelaran'), findsOneWidget);
    expect(find.text('Naskah Arkeologi\nMalang'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Lihat Detail'), findsWidgets);
  });

  testWidgets('opens serat sri sedana detail page from manuscripts list', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.khasJatimManuscriptsPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Serat Sri\nSedana'), findsOneWidget);

    final detailButton = find
        .widgetWithText(FilledButton, 'Lihat Detail')
        .first;
    await tester.ensureVisible(detailButton);
    await tester.tap(detailButton);
    await tester.pumpAndSettle();

    expect(find.text('Serat Sri Sedana'), findsWidgets);
    expect(find.text('Keterangan: Klik gambar untuk membaca'), findsOneWidget);
    expect(find.text('SUMBER / PEMILIK'), findsOneWidget);
    expect(
      find.widgetWithText(OutlinedButton, 'Kirim Komentar'),
      findsOneWidget,
    );

    await tester.enterText(
      find.widgetWithText(TextField, 'Tambahkan komentar...'),
      'Riset yang sangat membantu.',
    );
    await tester.pumpAndSettle();

    final submitCommentButton = find.widgetWithText(
      OutlinedButton,
      'Kirim Komentar',
    );
    await tester.ensureVisible(submitCommentButton);
    await tester.tap(submitCommentButton);
    await tester.pump();

    expect(
      find.textContaining('Komentar untuk Serat Sri Sedana berhasil dikirim.'),
      findsOneWidget,
    );
  });

  testWidgets('opens khas jatim registration page and submits form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.khasJatimRegistrationPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Pendaftaran Naskah Kuno'), findsWidgets);
    expect(find.text('Identitas Pemilik'), findsOneWidget);
    expect(find.text('Keterangan Naskah'), findsOneWidget);

    final schemeOption = find.text('Skema 3: Pendaftaran (Registrasi)');
    await tester.ensureVisible(schemeOption);
    await tester.tap(schemeOption);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Masukkan nama sesuai KTP'),
      'Anggun Amalia',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Masukkan nomor telepon'),
      '081234567890',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Masukkan alamat lengkap'),
      'Jl. Surabaya No. 1',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Contoh: Serat Centhini'),
      'Serat Centhini',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Abad ke-18 / Tahun 1750'),
      'Abad ke-18 / Tahun 1750',
    );
    await tester.pumpAndSettle();

    final scriptDropdown = find.byType(DropdownButtonFormField<String>).at(0);
    await tester.ensureVisible(scriptDropdown);
    await tester.tap(scriptDropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kawi').last);
    await tester.pumpAndSettle();

    final languageDropdown = find.byType(DropdownButtonFormField<String>).at(1);
    await tester.ensureVisible(languageDropdown);
    await tester.tap(languageDropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Indonesia').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('khas-jatim-file-button')));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Kirim'));
    await tester.tap(find.widgetWithText(FilledButton, 'Kirim'));
    await tester.pump();

    expect(
      find.textContaining('Pendaftaran naskah "Serat Centhini"'),
      findsOneWidget,
    );
  });

  testWidgets('opens sidita destinasi wisata page from sidita main menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final siditaTile = find.text('SIDITA');
    await tester.ensureVisible(siditaTile);
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final destinasiMenu = find.text('Destinasi\nWisata');
    await tester.ensureVisible(destinasiMenu);
    await tester.tap(destinasiMenu);
    await tester.pumpAndSettle();

    expect(find.text('Destinasi Wisata'), findsOneWidget);
    expect(find.text('Cari Destinasi Wisata'), findsOneWidget);
    expect(find.text('Destinasi Malang'), findsOneWidget);
    expect(find.text('Gunung Bromo'), findsOneWidget);
    expect(find.text('Jatim Park 3'), findsOneWidget);
    expect(find.text('Kampung Jodipan'), findsOneWidget);
  });

  testWidgets('opens sidita accommodations page from sidita main menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final siditaTile = find.text('SIDITA');
    await tester.ensureVisible(siditaTile);
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final akomodasiMenu = find.text('Akomodasi');
    await tester.ensureVisible(akomodasiMenu.first);
    await tester.tap(akomodasiMenu.first);
    await tester.pumpAndSettle();

    expect(find.text('Akomodasi'), findsWidgets);
    expect(find.text('Rekomendasi Utama'), findsOneWidget);
    expect(find.text('The Singhasari\nResort'), findsOneWidget);
    expect(find.text('Properti Terpopuler'), findsOneWidget);
    expect(find.text('Grand City Hall Surabaya'), findsOneWidget);
    expect(find.text('Oak Tree Glamping'), findsOneWidget);
    expect(find.text('Jaya Sands Resort'), findsOneWidget);
  });

  testWidgets(
    'opens the singhasari resort detail page from sidita accommodations',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.servicesPath,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final siditaTile = find.text('SIDITA');
      await tester.ensureVisible(siditaTile);
      await tester.tap(siditaTile);
      await tester.pumpAndSettle();
      await tester.tap(siditaTile);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      final akomodasiMenu = find.text('Akomodasi');
      await tester.ensureVisible(akomodasiMenu.first);
      await tester.tap(akomodasiMenu.first);
      await tester.pumpAndSettle();

      final singhasariCard = find.text('The Singhasari\nResort');
      await tester.ensureVisible(singhasariCard);
      await tester.tap(singhasariCard);
      await tester.pumpAndSettle();

      expect(find.text('The Singhasari Resort'), findsWidgets);
      expect(find.text('Galeri Foto'), findsOneWidget);
      expect(find.text('Tentang Resort'), findsOneWidget);
      expect(find.text('Fasilitas Utama'), findsOneWidget);
      expect(find.text('Open in Maps'), findsOneWidget);
    },
  );

  testWidgets('opens gunung bromo detail page from sidita destinations list', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final siditaTile = find.text('SIDITA');
    await tester.ensureVisible(siditaTile);
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final destinasiMenu = find.text('Destinasi\nWisata');
    await tester.ensureVisible(destinasiMenu);
    await tester.tap(destinasiMenu);
    await tester.pumpAndSettle();

    final detailButton = find.widgetWithText(FilledButton, 'Detail').first;
    await tester.ensureVisible(detailButton);
    await tester.tap(detailButton);
    await tester.pumpAndSettle();

    expect(find.text('Tentang Gunung Bromo'), findsOneWidget);
    expect(find.text('Beri Ulasan'), findsOneWidget);
    expect(find.text('Ulasan Wisatawan'), findsOneWidget);
    expect(find.text('IDR 250k'), findsOneWidget);
  });

  testWidgets('opens sidita event page from sidita main menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final siditaTile = find.text('SIDITA');
    await tester.ensureVisible(siditaTile);
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final eventMenu = find.text('Event');
    await tester.ensureVisible(eventMenu.last);
    await tester.tap(eventMenu.last);
    await tester.pumpAndSettle();

    expect(find.text('Event Mendatang'), findsOneWidget);
    expect(find.text('Cari Event'), findsOneWidget);
    expect(find.text('Pasar Djadoel Ahad Legi'), findsOneWidget);
    expect(find.text('Kurma Festival'), findsOneWidget);
    expect(find.text('Gebyar Ekraf'), findsOneWidget);
  });

  testWidgets('opens sidita wisatawan page from sidita main menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final siditaTile = find.text('SIDITA');
    await tester.ensureVisible(siditaTile);
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final wisatawanMenu = find.text('Wisatawan');
    await tester.ensureVisible(wisatawanMenu.last);
    await tester.tap(wisatawanMenu.last);
    await tester.pumpAndSettle();

    expect(find.text('Wisatawan'), findsWidgets);
    expect(find.text('COMING SOON'), findsOneWidget);
  });

  testWidgets('opens pasar djadoel detail page from sidita event list', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.servicesPath,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final siditaTile = find.text('SIDITA');
    await tester.ensureVisible(siditaTile);
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();
    await tester.tap(siditaTile);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final eventMenu = find.text('Event');
    await tester.ensureVisible(eventMenu.last);
    await tester.tap(eventMenu.last);
    await tester.pumpAndSettle();

    final pasarCard = find.text('Pasar Djadoel Ahad Legi');
    await tester.ensureVisible(pasarCard);
    await tester.tap(pasarCard);
    await tester.pumpAndSettle();

    expect(find.text('Tentang Pasar Djadoel'), findsOneWidget);
    expect(find.text('Kabupaten Ngawi'), findsOneWidget);
    expect(find.text('Open in Maps'), findsOneWidget);
    expect(find.text('01 Jan - 31 Dec 2024'), findsOneWidget);
  });

  testWidgets('opens nomor darurat page from home layanan saya tile', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final emergencyTile = find.text('Nomor\nDarurat');
    await tester.dragUntilVisible(
      emergencyTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(emergencyTile);
    await tester.pumpAndSettle();

    expect(find.text('Nomor Darurat'), findsWidgets);
    expect(find.text('Unduh Layanan'), findsOneWidget);
    expect(find.text('Sistem, Mekanisme, dan Prosedur'), findsOneWidget);
  });

  testWidgets('opens siskaperbapo page from home layanan saya tile', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final siskaperTile = find.text('SISKAPER\nBAPO');
    await tester.dragUntilVisible(
      siskaperTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(siskaperTile);
    await tester.pumpAndSettle();

    expect(find.text('SISKAPERBAPO'), findsWidgets);
    expect(find.text('Unduh Layanan'), findsOneWidget);
    expect(find.text('Akses Informasi Harian'), findsOneWidget);
    expect(find.text('Notifikasi Update'), findsOneWidget);
  });

  testWidgets('opens sinaker page from home layanan saya tile', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final sinakerTile = find.text('SINAKER');
    await tester.dragUntilVisible(
      sinakerTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(sinakerTile.first);
    await tester.pumpAndSettle();

    expect(find.text('SINAKER'), findsWidgets);
    expect(find.text('Legalitas Terjamin'), findsOneWidget);
    expect(find.text('Verifikasi & Seleksi'), findsOneWidget);
  });

  testWidgets('opens sinaker main page from overview download button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final sinakerTile = find.text('SINAKER');
    await tester.dragUntilVisible(
      sinakerTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(sinakerTile.first);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    expect(find.text('Daftar Pelatihan Kerja'), findsOneWidget);
    expect(find.text('Balai Latihan Kerja'), findsOneWidget);
    expect(find.text('Cek Pendaftaran Pelatihan'), findsOneWidget);
  });

  testWidgets('opens daftar pelatihan kerja from sinaker main page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final sinakerTile = find.text('SINAKER');
    await tester.dragUntilVisible(
      sinakerTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(sinakerTile.first);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Daftar Pelatihan Kerja').first);
    await tester.pumpAndSettle();

    expect(find.text('Daftar Pelatihan Kerja'), findsWidgets);
    expect(find.text('Cari Laporan'), findsOneWidget);
    expect(find.text('Jawa Timur'), findsOneWidget);
    expect(
      find.text('Pelatihan Barista Profesional & Manajemen Coffee Shop'),
      findsOneWidget,
    );

    final designTitle = find.text('Graphic Design & UI/UX Foundations');
    await tester.dragUntilVisible(
      designTitle,
      find.byType(CustomScrollView),
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    expect(designTitle, findsOneWidget);

    final solarTitle = find.text(
      'Pemasangan & Pemeliharaan Panel Surya (PLTS)',
    );
    await tester.dragUntilVisible(
      solarTitle,
      find.byType(CustomScrollView),
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    expect(solarTitle, findsOneWidget);
  });

  testWidgets('opens balai latihan kerja from sinaker main page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final sinakerTile = find.text('SINAKER');
    await tester.dragUntilVisible(
      sinakerTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(sinakerTile.first);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Balai Latihan Kerja').first);
    await tester.pumpAndSettle();

    expect(find.text('Balai Latihan Kerja'), findsOneWidget);
    expect(find.text('Cari nama BLK'), findsOneWidget);
    expect(find.text('12 BLK Ditemukan'), findsOneWidget);
    expect(find.text('UPT BLK Sumenep'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'surabaya');
    await tester.pumpAndSettle();

    expect(find.text('UPT BLK Surabaya'), findsOneWidget);
    expect(find.text('UPT BLK Sumenep'), findsNothing);
  });

  testWidgets('opens cek pendaftaran pelatihan from sinaker main page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final sinakerTile = find.text('SINAKER');
    await tester.dragUntilVisible(
      sinakerTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(sinakerTile.first);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cek Pendaftaran Pelatihan').first);
    await tester.pumpAndSettle();

    expect(find.text('Cek Pendaftaran'), findsOneWidget);
    expect(find.text('Bambang Pamungkas'), findsOneWidget);
    expect(find.text('NIK: 3578021908920001'), findsOneWidget);
    expect(find.text('Batch 24 - 2024'), findsOneWidget);
    expect(find.text('UPT BLK\nSurabaya'), findsOneWidget);
    expect(find.text('Pendaftaran Diterima'), findsOneWidget);
    expect(find.text('Verifikasi Berkas'), findsOneWidget);
    expect(find.text('Pengumuman Seleksi'), findsOneWidget);
  });

  testWidgets(
    'opens upt blk sumenep detail and routes daftar to training registration form',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.path,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final sinakerTile = find.text('SINAKER');
      await tester.dragUntilVisible(
        sinakerTile,
        find.byType(CustomScrollView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(sinakerTile.first);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Balai Latihan Kerja').first);
      await tester.pumpAndSettle();

      final detailButton = find.text('Lihat Detail').first;
      await tester.dragUntilVisible(
        detailButton,
        find.byType(CustomScrollView),
        const Offset(0, -180),
      );
      await tester.pumpAndSettle();
      await tester.tap(detailButton);
      await tester.pumpAndSettle();

      expect(find.text('UPT BLK Sumenep'), findsOneWidget);
      expect(find.text('Cari pelatihan kerja'), findsOneWidget);
      expect(
        find.text('Pelatihan Barista Profesional & Manajemen Coffee Shop'),
        findsOneWidget,
      );

      final registerButton = find.widgetWithText(FilledButton, 'Daftar').first;
      await tester.dragUntilVisible(
        registerButton,
        find.byType(CustomScrollView),
        const Offset(0, -180),
      );
      await tester.pumpAndSettle();
      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      expect(find.text('Pelatihan Kerja'), findsOneWidget);
      expect(find.text('Lengkapi Formulir'), findsOneWidget);
    },
  );

  testWidgets('opens barista training registration form from training list', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final sinakerTile = find.text('SINAKER');
    await tester.dragUntilVisible(
      sinakerTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(sinakerTile.first);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Daftar Pelatihan Kerja').first);
    await tester.pumpAndSettle();

    final registerButton = find.widgetWithText(FilledButton, 'Daftar').first;
    await tester.dragUntilVisible(
      registerButton,
      find.byType(CustomScrollView),
      const Offset(0, -180),
    );
    await tester.pumpAndSettle();
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(find.text('Pelatihan Kerja'), findsOneWidget);
    expect(
      find.text('Pelatihan Barista Profesional &\nManajemen Coffee Shop'),
      findsOneWidget,
    );
    expect(find.text('Lengkapi Formulir'), findsOneWidget);
    expect(find.text('Nama Lengkap'), findsOneWidget);
    expect(find.text('NIK'), findsOneWidget);
    expect(find.text('Nomor WhatsApp'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Daftar'), findsOneWidget);
  });

  testWidgets('opens siskaperbapo main page from overview download button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final siskaperTile = find.text('SISKAPER\nBAPO');
    await tester.dragUntilVisible(
      siskaperTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(siskaperTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    expect(find.text('SISKAPERBAPO'), findsWidgets);
    expect(find.text('Cari Laporan'), findsOneWidget);
    expect(find.text('Semua'), findsOneWidget);
    expect(find.text('Bumbu Dapur'), findsOneWidget);
    expect(find.text('Bawang Merah'), findsOneWidget);
    expect(find.text('Rp36.118'), findsOneWidget);
    expect(find.text('Bawang Putih'), findsOneWidget);
    expect(find.text('Rp34.250'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'ayam');
    await tester.pumpAndSettle();

    expect(find.text('Daging Ayam'), findsOneWidget);
    expect(find.text('Bawang Merah'), findsNothing);
  });

  testWidgets('opens bawang merah detail page from siskaperbapo main page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final siskaperTile = find.text('SISKAPER\nBAPO');
    await tester.dragUntilVisible(
      siskaperTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(siskaperTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Bawang Merah'));
    await tester.pumpAndSettle();

    expect(find.text('HARGA TURUN'), findsOneWidget);
    expect(find.text('Bawang Merah/kg'), findsOneWidget);
    expect(
      find.text('Rata-rata Harga Hari Ini per kilogram (kg)'),
      findsOneWidget,
    );
    expect(find.text('Rp36.118'), findsWidgets);
    expect(find.text('TERTINGGI'), findsOneWidget);
    expect(find.text('Rp45.000'), findsWidgets);
    expect(find.text('Kab. Pamekasan'), findsWidgets);
    expect(find.text('TERENDAH'), findsOneWidget);
    expect(find.text('Rp26.000'), findsWidgets);
    expect(find.text('Kab. Nganjuk'), findsWidgets);
    expect(find.text('Tren\nHarga'), findsOneWidget);
    expect(find.text('1\nMinggu'), findsOneWidget);
    expect(find.text('Kota Surabaya'), findsOneWidget);
  });

  testWidgets('opens nomor darurat main page from overview download button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final emergencyTile = find.text('Nomor\nDarurat');
    await tester.dragUntilVisible(
      emergencyTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(emergencyTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    expect(find.text('Nomor Darurat'), findsWidgets);
    expect(
      find.text('Menampilkan kontak darurat untuk wilayah terpilih'),
      findsOneWidget,
    );
    expect(find.text('AMBULANS / KEADAAN DARURAT'), findsOneWidget);
    expect(find.text('CALL CENTER 112'), findsOneWidget);
    expect(find.text('POLDA JATIM'), findsOneWidget);
    expect(find.text('CALL CENTER 1500979'), findsOneWidget);
  });

  testWidgets('opens klinik hoaks page from layanan saya after installation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Layanan'));
    await tester.pumpAndSettle();

    final clinicTileOnServices = find.text('Klinik\nHoaks');
    await tester.dragUntilVisible(
      clinicTileOnServices,
      find.byType(GridView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(clinicTileOnServices);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Beranda'));
    await tester.pumpAndSettle();

    final clinicTileOnHome = find.text('Klinik\nHoaks').last;
    await tester.dragUntilVisible(
      clinicTileOnHome,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(clinicTileOnHome);
    await tester.pumpAndSettle();

    expect(find.text('Klinik Hoaks'), findsWidgets);
    expect(find.text('Fitur Utama'), findsOneWidget);
    expect(find.text('Cara Kerja'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Unduh Layanan'), findsOneWidget);
  });

  testWidgets(
    'opens islamic center page from layanan saya after installation',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.path,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Layanan'));
      await tester.pumpAndSettle();

      final islamicCenterTileOnServices = find.text('Islamic\nCenter');
      await tester.ensureVisible(islamicCenterTileOnServices);
      await tester.tap(islamicCenterTileOnServices);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Beranda'));
      await tester.pumpAndSettle();

      final islamicCenterTileOnHome = find.text('Islamic\nCenter').last;
      await tester.dragUntilVisible(
        islamicCenterTileOnHome,
        find.byType(CustomScrollView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(islamicCenterTileOnHome);
      await tester.pumpAndSettle();

      expect(find.text('ISLAMIC CENTER JAWA TIMUR'), findsOneWidget);
      expect(find.text('Jadwal Transparan'), findsOneWidget);
      expect(find.text('Lengkapi Data Diri'), findsOneWidget);
    },
  );

  testWidgets('opens klinik hoaks main page from overview download button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Layanan'));
    await tester.pumpAndSettle();

    final clinicTileOnServices = find.text('Klinik\nHoaks');
    await tester.dragUntilVisible(
      clinicTileOnServices,
      find.byType(GridView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(clinicTileOnServices);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Beranda'));
    await tester.pumpAndSettle();

    final clinicTileOnHome = find.text('Klinik\nHoaks').last;
    await tester.dragUntilVisible(
      clinicTileOnHome,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(clinicTileOnHome);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    expect(find.text('Klinik Hoaks'), findsWidgets);
    expect(find.text('Berita Hoaks'), findsOneWidget);
    expect(find.text('Disinformasi'), findsOneWidget);
    expect(find.text('Laporan Hoaks'), findsOneWidget);
    expect(find.text('Lacak Tiket Laporan'), findsOneWidget);
    expect(find.text('Laporan Terkini'), findsOneWidget);
    expect(find.text('Lihat Semua'), findsOneWidget);
    expect(find.text('CALL CENTER 112'), findsNothing);
  });

  testWidgets(
    'opens laporan hoaks page from klinik hoaks main feature button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.path,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Layanan'));
      await tester.pumpAndSettle();

      final clinicTileOnServices = find.text('Klinik\nHoaks');
      await tester.dragUntilVisible(
        clinicTileOnServices,
        find.byType(GridView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(clinicTileOnServices);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Beranda'));
      await tester.pumpAndSettle();

      final clinicTileOnHome = find.text('Klinik\nHoaks').last;
      await tester.dragUntilVisible(
        clinicTileOnHome,
        find.byType(CustomScrollView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(clinicTileOnHome);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      final reportButton = find
          .widgetWithText(FilledButton, 'Selengkapnya')
          .first;
      await tester.ensureVisible(reportButton);
      await tester.tap(reportButton);
      await tester.pumpAndSettle();

      expect(find.text('Laporan Hoaks'), findsWidgets);
      expect(find.text('Nama Lengkap'), findsOneWidget);
      expect(find.text('Email Aktif'), findsOneWidget);
      expect(find.text('Nomor WhatsApp'), findsOneWidget);
      expect(find.text('Narasi Laporan'), findsOneWidget);
      expect(find.text('Tautan Sumber'), findsOneWidget);
      expect(find.text('Lampiran Tangkapan Layar'), findsOneWidget);
      expect(find.text('Choose File'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Kirim'), findsOneWidget);

      await tester.enterText(find.byType(TextField).at(0), 'Ray Nanta');
      await tester.enterText(find.byType(TextField).at(1), 'ray@example.com');
      await tester.enterText(find.byType(TextField).at(2), '081234567890');
      await tester.enterText(
        find.byType(TextField).at(3),
        'Saya menemukan informasi yang meragukan.',
      );
      await tester.enterText(
        find.byType(TextField).at(4),
        'https://contoh.com/berita',
      );
      await tester.pumpAndSettle();

      expect(find.text('Ray Nanta'), findsOneWidget);
      expect(find.text('ray@example.com'), findsOneWidget);
      expect(find.text('081234567890'), findsOneWidget);

      final chooseFileText = find.text('Choose File');
      await tester.ensureVisible(chooseFileText);
      await tester.tap(chooseFileText);
      await tester.pumpAndSettle();

      expect(find.text('tangkapan_layar_hoaks.jpg'), findsOneWidget);
    },
  );

  testWidgets(
    'opens laporan terkini detail from donald trump card on klinik hoaks main page',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.path,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Layanan'));
      await tester.pumpAndSettle();

      final clinicTileOnServices = find.text('Klinik\nHoaks');
      await tester.dragUntilVisible(
        clinicTileOnServices,
        find.byType(GridView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(clinicTileOnServices);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Beranda'));
      await tester.pumpAndSettle();

      final clinicTileOnHome = find.text('Klinik\nHoaks').last;
      await tester.dragUntilVisible(
        clinicTileOnHome,
        find.byType(CustomScrollView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(clinicTileOnHome);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      final donaldTrumpCard = find.text(
        '[HOAKS] Kabar Donald Trump Sekarat Akibat Serangan Virus Baru...',
      );
      await tester.ensureVisible(donaldTrumpCard);
      await tester.tap(donaldTrumpCard);
      await tester.pumpAndSettle();

      expect(find.text('Laporan Terkini'), findsWidgets);
      expect(
        find.text('Kabar Donald Trump\nSekarat Akibat Melawan\nIran'),
        findsOneWidget,
      );
      expect(find.text('2026-04-11 10:51:13'), findsOneWidget);
      expect(find.text('28 Views'), findsOneWidget);
      expect(find.text('Link Rujukan'), findsOneWidget);
      expect(find.text('https://tirto.id/'), findsOneWidget);
    },
  );

  testWidgets(
    'opens all laporan terkini page from lihat semua button on klinik hoaks main page',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.path,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Layanan'));
      await tester.pumpAndSettle();

      final clinicTileOnServices = find.text('Klinik\nHoaks');
      await tester.dragUntilVisible(
        clinicTileOnServices,
        find.byType(GridView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(clinicTileOnServices);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Beranda'));
      await tester.pumpAndSettle();

      final clinicTileOnHome = find.text('Klinik\nHoaks').last;
      await tester.dragUntilVisible(
        clinicTileOnHome,
        find.byType(CustomScrollView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(clinicTileOnHome);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      final seeAllButton = find.text('Lihat Semua');
      await tester.ensureVisible(seeAllButton);
      await tester.tap(seeAllButton);
      await tester.pumpAndSettle();

      expect(find.text('Laporan Terkini'), findsWidgets);
      expect(find.text('Cari Laporan'), findsOneWidget);
      expect(
        find.text(
          '[HOAKS] Pendaftaran Vaksinasi Gratis Menggunakan Data Rekening Bank',
        ),
        findsOneWidget,
      );
      expect(
        find.text('Klarifikasi: Video Fenomena Langit Merah Bukan Tanda...'),
        findsOneWidget,
      );
      expect(
        find.text('[HOAKS] Kabar Donald Trump Sekarat Setelah...'),
        findsOneWidget,
      );

      await tester.enterText(find.byType(TextField).first, 'donald');
      await tester.pumpAndSettle();

      expect(
        find.text('[HOAKS] Kabar Donald Trump Sekarat Setelah...'),
        findsOneWidget,
      );
      expect(
        find.text(
          '[HOAKS] Pendaftaran Vaksinasi Gratis Menggunakan Data Rekening Bank',
        ),
        findsNothing,
      );
    },
  );

  testWidgets(
    'opens klinik hoaks page from daftar layanan saya after installation',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.path,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Layanan'));
      await tester.pumpAndSettle();

      final clinicTileOnServices = find.text('Klinik\nHoaks');
      await tester.dragUntilVisible(
        clinicTileOnServices,
        find.byType(GridView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(clinicTileOnServices);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Beranda'));
      await tester.pumpAndSettle();

      final lainnyaLabel = find.text('Lainnya').first;
      await tester.dragUntilVisible(
        lainnyaLabel,
        find.byType(CustomScrollView),
        const Offset(0, -280),
      );
      await tester.pumpAndSettle();
      await tester.tap(lainnyaLabel);
      await tester.pumpAndSettle();

      final clinicTileOnList = find.text('Klinik Hoaks');
      await tester.dragUntilVisible(
        clinicTileOnList,
        find.byType(CustomScrollView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(clinicTileOnList);
      await tester.pumpAndSettle();

      expect(find.text('Klinik Hoaks'), findsWidgets);
      expect(find.text('Fast verification'), findsOneWidget);
      expect(find.text('Expert-reviewed'), findsOneWidget);
    },
  );

  testWidgets(
    'opens lacak pelaporan page from klinik hoaks tracking feature button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.path,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Layanan'));
      await tester.pumpAndSettle();

      final clinicTileOnServices = find.text('Klinik\nHoaks');
      await tester.dragUntilVisible(
        clinicTileOnServices,
        find.byType(GridView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(clinicTileOnServices);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Beranda'));
      await tester.pumpAndSettle();

      final clinicTileOnHome = find.text('Klinik\nHoaks').last;
      await tester.dragUntilVisible(
        clinicTileOnHome,
        find.byType(CustomScrollView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(clinicTileOnHome);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      final trackingButton = find
          .widgetWithText(FilledButton, 'Selengkapnya')
          .last;
      await tester.ensureVisible(trackingButton);
      await tester.tap(trackingButton);
      await tester.pumpAndSettle();

      expect(find.text('Lacak Pelaporan'), findsWidgets);
      expect(find.text('Pelacakan Tiket Permohonan Anda'), findsOneWidget);
      expect(find.text('Nomor Tiket'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Lacak'), findsOneWidget);

      FilledButton trackButton = tester.widget(
        find.widgetWithText(FilledButton, 'Lacak'),
      );
      expect(trackButton.onPressed, isNull);

      await tester.enterText(find.byType(TextField).first, 'MH-2024-001');
      await tester.pumpAndSettle();

      expect(find.text('MH-2024-001'), findsOneWidget);

      trackButton = tester.widget(find.widgetWithText(FilledButton, 'Lacak'));
      expect(trackButton.onPressed, isNotNull);

      await tester.tap(find.widgetWithText(FilledButton, 'Lacak'));
      await tester.pumpAndSettle();

      expect(find.text('Hasil Pencarian'), findsOneWidget);
      expect(find.text('Menampilkan 1 hasil'), findsOneWidget);
      expect(find.text('TIKET AKTIF'), findsOneWidget);
      expect(find.text('MH-2024-001'), findsOneWidget);
      expect(find.text('Dalam Proses'), findsOneWidget);
      expect(find.text('Tanggal Laporan'), findsOneWidget);
      expect(find.text('12 April 2026'), findsOneWidget);
      expect(find.text('Laporan Diterima'), findsOneWidget);
      expect(find.text('Penugasan Petugas'), findsOneWidget);
      expect(find.text('Penyelesaian'), findsOneWidget);
    },
  );

  testWidgets('opens tbc identity form from skrining tbc page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final skriningTile = find.text('Skrining\nTBC');
    await tester.dragUntilVisible(
      skriningTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(skriningTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    expect(find.text('Formulir Identitas'), findsOneWidget);
    expect(
      find.text('Anda melakukan skrining untuk diri Anda sendiri?'),
      findsOneWidget,
    );
    expect(find.text('Masukkan Identitas Anda'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Selanjutnya'), findsOneWidget);

    final yesOption = find
        .ancestor(of: find.text('Ya'), matching: find.byType(InkWell))
        .first;
    await tester.ensureVisible(yesOption);
    await tester.tap(yesOption);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.radio_button_checked_rounded), findsOneWidget);
  });

  testWidgets('shows alternate reporter form when memilih tidak', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final skriningTile = find.text('Skrining\nTBC');
    await tester.dragUntilVisible(
      skriningTile,
      find.byType(CustomScrollView),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    await tester.tap(skriningTile);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
    await tester.pumpAndSettle();

    final noOption = find
        .ancestor(of: find.text('Tidak'), matching: find.byType(InkWell))
        .first;
    await tester.ensureVisible(noOption);
    await tester.tap(noOption);
    await tester.pumpAndSettle();

    expect(find.text('Informasi yang bantu lapor'), findsOneWidget);
    expect(find.text('Informasi yang di skrining'), findsOneWidget);
    expect(find.text('Kelompok'), findsOneWidget);
    expect(find.text('Nama Instansi'), findsOneWidget);
    expect(find.text('No. Telepon/HP'), findsOneWidget);
    expect(find.text('Masukkan Identitas Anda'), findsNothing);
  });

  testWidgets(
    'opens tbc personal identity page from identity form next button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.path,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final skriningTile = find.text('Skrining\nTBC');
      await tester.dragUntilVisible(
        skriningTile,
        find.byType(CustomScrollView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(skriningTile);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Selanjutnya'));
      await tester.pumpAndSettle();

      expect(find.text('Identitas Anda'), findsOneWidget);
      expect(find.text('Tahun Lahir'), findsOneWidget);
      expect(find.text('Umur (Otomatis)'), findsOneWidget);
      expect(find.text('Berat Badan (Kg)'), findsOneWidget);
      expect(find.text('Tinggi Badan (Cm)'), findsOneWidget);
      expect(find.widgetWithText(OutlinedButton, 'Sebelumnya'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Selanjutnya'), findsOneWidget);
    },
  );

  testWidgets(
    'opens tbc screening form one page from personal identity next button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.path,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final skriningTile = find.text('Skrining\nTBC');
      await tester.dragUntilVisible(
        skriningTile,
        find.byType(CustomScrollView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(skriningTile);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Selanjutnya'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Selanjutnya'));
      await tester.pumpAndSettle();

      expect(find.text('Formulir Skrining'), findsOneWidget);
      expect(find.text('Formulir 1 dari 2'), findsOneWidget);
      expect(find.text('Keluhan yang dirasakan'), findsOneWidget);
      expect(find.text('Batuk lebih dari 2 minggu'), findsOneWidget);
      expect(find.text('Berat badan turun'), findsOneWidget);
    },
  );

  testWidgets(
    'opens tbc screening form two page from screening form one next button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.path,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final skriningTile = find.text('Skrining\nTBC');
      await tester.dragUntilVisible(
        skriningTile,
        find.byType(CustomScrollView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(skriningTile);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Selanjutnya'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Selanjutnya'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Selanjutnya'));
      await tester.pumpAndSettle();

      expect(find.text('Formulir Skrining'), findsOneWidget);
      expect(find.text('Formulir 2 dari 2'), findsOneWidget);
      expect(find.text('Informasi lainnya'), findsOneWidget);
      expect(
        find.text('Anggota keluarga serumah ada yang sakit TBC?'),
        findsOneWidget,
      );
      expect(find.text('Lansia (diatas 60 tahun)'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Submit Data'), findsOneWidget);
    },
  );

  testWidgets(
    'opens negative tbc result page from screening form two submit button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: HomeRoutes.path,
              routes: HomeRoutes.routes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final skriningTile = find.text('Skrining\nTBC');
      await tester.dragUntilVisible(
        skriningTile,
        find.byType(CustomScrollView),
        const Offset(0, -220),
      );
      await tester.pumpAndSettle();
      await tester.tap(skriningTile);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Unduh Layanan'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Selanjutnya'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Selanjutnya'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Selanjutnya'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Submit Data'));
      await tester.pumpAndSettle();

      expect(find.text('Hasil Skrining'), findsOneWidget);
      expect(find.text('Anda Bukan Terduga TBC'), findsOneWidget);
      expect(find.text('Anggun Amalia'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Selesai'), findsOneWidget);
    },
  );

  testWidgets('opens skrining tbc page from daftar layanan saya', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final lainnyaLabel = find.text('Lainnya').first;
    await tester.dragUntilVisible(
      lainnyaLabel,
      find.byType(CustomScrollView),
      const Offset(0, -280),
    );
    await tester.pumpAndSettle();
    await tester.tap(lainnyaLabel);
    await tester.pumpAndSettle();

    final skriningTile = find.text('Skrining TBC');
    await tester.dragUntilVisible(
      skriningTile,
      find.byType(CustomScrollView),
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    await tester.tap(skriningTile);
    await tester.pumpAndSettle();

    expect(find.text('Skrining TBC Mandiri'), findsOneWidget);
    expect(find.text('Online 24 jam'), findsOneWidget);
  });

  testWidgets('opens rsud saiful anwar page from daftar layanan saya', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final lainnyaLabel = find.text('Lainnya').first;
    await tester.dragUntilVisible(
      lainnyaLabel,
      find.byType(CustomScrollView),
      const Offset(0, -280),
    );
    await tester.pumpAndSettle();
    await tester.tap(lainnyaLabel);
    await tester.pumpAndSettle();

    final rsudTile = find.text('RSUD Saiful Anwar');
    await tester.dragUntilVisible(
      rsudTile,
      find.byType(CustomScrollView),
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    await tester.tap(rsudTile);
    await tester.pumpAndSettle();

    expect(find.text('RSUD SAIFUL ANWAR'), findsWidgets);
    expect(find.text('Pembaruan Real-time'), findsOneWidget);
    expect(find.text('Lihat Hitungan Real-time'), findsOneWidget);
  });

  testWidgets('opens bapenda jatim page from daftar layanan saya', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final lainnyaLabel = find.text('Lainnya').first;
    await tester.dragUntilVisible(
      lainnyaLabel,
      find.byType(CustomScrollView),
      const Offset(0, -280),
    );
    await tester.pumpAndSettle();
    await tester.tap(lainnyaLabel);
    await tester.pumpAndSettle();

    final bapendaTile = find.text('Bapenda Jatim');
    await tester.dragUntilVisible(
      bapendaTile,
      find.byType(CustomScrollView),
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    await tester.tap(bapendaTile);
    await tester.pumpAndSettle();

    expect(find.text('BAPENDA JATIM'), findsWidgets);
    expect(find.text('Manfaat'), findsOneWidget);
    expect(
      find.text('Info Nilai Jual Kendaraan Bermotor (NJKB)'),
      findsOneWidget,
    );
  });

  testWidgets('opens nomor darurat page from daftar layanan saya', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final lainnyaLabel = find.text('Lainnya').first;
    await tester.dragUntilVisible(
      lainnyaLabel,
      find.byType(CustomScrollView),
      const Offset(0, -280),
    );
    await tester.pumpAndSettle();
    await tester.tap(lainnyaLabel);
    await tester.pumpAndSettle();

    final emergencyTile = find.text('Nomor Darurat');
    await tester.dragUntilVisible(
      emergencyTile,
      find.byType(CustomScrollView),
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    await tester.tap(emergencyTile);
    await tester.pumpAndSettle();

    expect(find.text('Nomor Darurat'), findsWidgets);
    expect(
      find.text('Berisi Nomor Darurat yang dapat dihubungi oleh masyarakat'),
      findsOneWidget,
    );
  });

  testWidgets('opens siskaperbapo page from daftar layanan saya', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final lainnyaLabel = find.text('Lainnya');
    await tester.dragUntilVisible(
      lainnyaLabel,
      find.byType(CustomScrollView),
      const Offset(0, -280),
    );
    await tester.pumpAndSettle();
    await tester.tap(lainnyaLabel);
    await tester.pumpAndSettle();

    final siskaperTile = find.text('SISKAPER BAPO');
    await tester.dragUntilVisible(
      siskaperTile,
      find.byType(CustomScrollView),
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    await tester.tap(siskaperTile);
    await tester.pumpAndSettle();

    expect(find.text('SISKAPERBAPO'), findsWidgets);
    expect(
      find.text(
        'Sistem Informasi Ketersediaan dan Perkembangan Harga Bahan Pokok',
      ),
      findsOneWidget,
    );
  });

  testWidgets('opens sinaker page from daftar layanan saya', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final lainnyaLabel = find.text('Lainnya');
    await tester.dragUntilVisible(
      lainnyaLabel,
      find.byType(CustomScrollView),
      const Offset(0, -280),
    );
    await tester.pumpAndSettle();
    await tester.tap(lainnyaLabel.first);
    await tester.pumpAndSettle();

    final sinakerTile = find.text('SINAKER');
    await tester.dragUntilVisible(
      sinakerTile,
      find.byType(CustomScrollView),
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    await tester.tap(sinakerTile.first);
    await tester.pumpAndSettle();

    expect(find.text('SINAKER'), findsWidgets);
    expect(find.text('Peningkatan Skill'), findsOneWidget);
    expect(find.text('Pendaftaran Akun'), findsOneWidget);
  });

  testWidgets('opens layanan page from home bottom navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Layanan'));
    await tester.pumpAndSettle();

    expect(find.text('Layanan'), findsWidgets);
    expect(find.text('Kesehatan'), findsOneWidget);
    expect(find.text('Kependudukan'), findsOneWidget);
    await tester.tap(find.text('Kesehatan'));
    await tester.pumpAndSettle();
    expect(find.text('✓ Terpasang'), findsWidgets);
    await tester.tap(find.text('Skrining\nTBC'));
    await tester.pumpAndSettle();

    expect(find.text('Skrining TBC Mandiri'), findsOneWidget);
    expect(find.text('Unduh Layanan'), findsOneWidget);
  });

  testWidgets('opens profile page from home bottom navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Akun'));
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Anggun Amalia'), findsOneWidget);
    expect(find.text('Ubah Kata Sandi'), findsOneWidget);
    expect(find.text('Keluar'), findsOneWidget);
  });

  testWidgets('opens personal data page from profile menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Akun'));
    await tester.pumpAndSettle();
    final personalDataMenuTile = find
        .ancestor(of: find.text('Data Diri'), matching: find.byType(InkWell))
        .first;
    await tester.ensureVisible(personalDataMenuTile);
    await tester.tap(personalDataMenuTile);
    await tester.pumpAndSettle();

    expect(find.text('Data Diri'), findsWidgets);
    expect(find.text('Nama lengkap'), findsOneWidget);
    expect(find.text('Anggun Amalia'), findsOneWidget);
    expect(find.text('3514075406040002'), findsOneWidget);
    expect(find.text('085748460431'), findsOneWidget);
  });

  testWidgets('opens change password page from profile menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Akun'));
    await tester.pumpAndSettle();
    final changePasswordMenuTile = find
        .ancestor(
          of: find.text('Ubah Kata Sandi'),
          matching: find.byType(InkWell),
        )
        .first;
    await tester.ensureVisible(changePasswordMenuTile);
    await tester.tap(changePasswordMenuTile);
    await tester.pumpAndSettle();

    expect(find.text('Ubah Kata Sandi'), findsWidgets);
    expect(find.text('Kata Sandi Lama'), findsOneWidget);
    expect(find.text('Kata Sandi Baru'), findsOneWidget);
    expect(find.text('Konfirmasi Kata Sandi Baru'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Masuk'), findsOneWidget);
  });

  testWidgets('opens change language page from profile menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Akun'));
    await tester.pumpAndSettle();
    final changeLanguageMenuTile = find
        .ancestor(of: find.text('Ganti Bahasa'), matching: find.byType(InkWell))
        .first;
    await tester.ensureVisible(changeLanguageMenuTile);
    await tester.tap(changeLanguageMenuTile);
    await tester.pumpAndSettle();

    expect(find.text('Ganti Bahasa'), findsWidgets);
    expect(find.text('Bahasa Indonesia'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Bahasa Jawa'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Terapkan'), findsOneWidget);
  });

  testWidgets('opens about jatim page from profile menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Akun'));
    await tester.pumpAndSettle();
    final aboutJatimMenuTile = find
        .ancestor(
          of: find.text('Tentang Jawa Timur'),
          matching: find.byType(InkWell),
        )
        .first;
    await tester.ensureVisible(aboutJatimMenuTile);
    await tester.tap(aboutJatimMenuTile);
    await tester.pumpAndSettle();

    expect(find.text('Tentang Jawa Timur'), findsWidgets);
    expect(find.text('Sekilas Profil\nJawa Timur'), findsOneWidget);
    expect(find.text('Investasi & Industri'), findsOneWidget);
    expect(find.text('Kekayaan Alam & Wisata'), findsOneWidget);
  });

  testWidgets('opens terms and conditions page from profile menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Akun'));
    await tester.pumpAndSettle();
    final termsMenuTile = find
        .ancestor(
          of: find.text('Syarat dan Ketentuan'),
          matching: find.byType(InkWell),
        )
        .first;
    await tester.ensureVisible(termsMenuTile);
    await tester.tap(termsMenuTile);
    await tester.pumpAndSettle();

    expect(find.text('Syarat dan Ketentuan'), findsWidgets);
    expect(find.text('Pendahuluan'), findsOneWidget);
    expect(find.text('Ketentuan Pengguna'), findsOneWidget);
    expect(find.text('Persetujuan'), findsOneWidget);
  });

  testWidgets('opens about majadigi page from profile menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: HomeRoutes.path,
            routes: HomeRoutes.routes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Akun'));
    await tester.pumpAndSettle();
    final aboutMajadigiMenuTile = find
        .ancestor(
          of: find.text('Tentang Majadigi'),
          matching: find.byType(InkWell),
        )
        .first;
    await tester.ensureVisible(aboutMajadigiMenuTile);
    await tester.tap(aboutMajadigiMenuTile);
    await tester.pumpAndSettle();

    expect(find.text('Tentang Majadigi'), findsWidgets);
    expect(find.text('SEKILAS MAJADIGI'), findsOneWidget);
    expect(
      find.text('Inovasi Layanan Publik\nBerbasis Digital Jawa\nTimur'),
      findsOneWidget,
    );
  });
}
