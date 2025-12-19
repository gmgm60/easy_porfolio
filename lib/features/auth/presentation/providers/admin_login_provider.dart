import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:easy_porfolio/features/auth/domain/entities/admin_credentials.dart';
import 'package:easy_porfolio/features/auth/presentation/providers/auth_providers.dart';

class AdminLoginNotifier extends AsyncNotifier<void> {

  @override
  FutureOr<void> build()   {
    return null;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final creds = AdminCredentials(email: email, password: password);
    final adminLogin = ref.read(adminLoginUseCaseProvider);
    final result = await adminLogin(creds);

    if (!ref.mounted) {
      return;
    }
    // Unwrap at the edge
    state = result.fold(
          (ok) => const AsyncData(null),
          (fail) => AsyncError(fail, StackTrace.current),
    );
  }

}

final adminLoginProvider =
AsyncNotifierProvider<AdminLoginNotifier, void>(AdminLoginNotifier.new);
