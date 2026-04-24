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
    await tester.pumpAndSettle();

    expect(find.text('Powered by'), findsOneWidget);
    expect(find.text('Pemerintah Provinsi Jawa Timur'), findsOneWidget);
  });
}
