import 'dart:convert';

import 'package:flutter_riverpod/legacy.dart';

import '../../features/auth/models/user_model.dart';
import '../../features/auth/services/auth_service.dart';
import '../storage/auth_storage.dart';

final authProvider =
StateNotifierProvider<AuthNotifier, UserModel?>(
      (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<UserModel?> {
  AuthNotifier() : super(null);

  Future<void> loadCurrentUser() async {
    try {
      final userJson = await AuthStorage.getUser();

      if (userJson != null) {
        state = UserModel.fromJson(
          jsonDecode(userJson),
        );
      }
    } catch (e) {
      state = null;
    }
  }

  Future<void> fetchCurrentUser() async {
    final user = await AuthService.me();

    state = user;

    await AuthStorage.saveUser(
      jsonEncode(user.toJson()),
    );
  }

  void setUser(UserModel user) {
    state = user;
  }

  Future<void> logout() async {
    state = null;

    await AuthStorage.clear();
  }
}