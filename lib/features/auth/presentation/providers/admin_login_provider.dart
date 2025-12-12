import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:easy_porfolio/features/auth/domain/entities/admin_credentials.dart';
import 'package:easy_porfolio/features/auth/presentation/providers/auth_providers.dart';

/// Parameter class for login credentials.
class LoginCredentialsParams {
  const LoginCredentialsParams({required this.email, required this.password});

  final String email;
  final String password;

}

/// State class for admin login.
class AdminLoginState {
  final bool isLoading;
  final String? error;

  const AdminLoginState({this.isLoading = false, this.error});

  AdminLoginState copyWith({bool? isLoading, String? error}) {
    return AdminLoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier that handles admin login with automatic loading and error state management.
class AdminLoginNotifier extends Notifier<AdminLoginState> {
  @override
  AdminLoginState build() {
    return const AdminLoginState();
  }

  /// Triggers the login process with the provided credentials.
  Future<void> login(LoginCredentialsParams params) async {
    state = state.copyWith(isLoading: true);

    final loginUseCase = ref.read(adminLoginUseCaseProvider);
    final credentials = AdminCredentials(
      email: params.email.trim(),
      password: params.password,
    );

    final result = await loginUseCase(credentials);

    if (!ref.mounted) {
      return;
    }

    result.fold(
      (success) {
        state = const AdminLoginState();
      },
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
    );
  }
}

/// Provider for admin login state management.
final adminLoginProvider =
    NotifierProvider.autoDispose<AdminLoginNotifier, AdminLoginState>(
      AdminLoginNotifier.new,
    );
