import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/providers/core_providers.dart';
import 'app.dart';

Future<void> bootstrap(SharedPreferences sharedPreferences) async {
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
      ],
      child: const MajadigiApp(),
    ),
  );
}
