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
