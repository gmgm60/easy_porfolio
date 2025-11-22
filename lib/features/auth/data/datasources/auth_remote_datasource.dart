

import 'package:easy_porfolio/core/network/failure/app_failure.dart';
import 'package:easy_porfolio/core/network/failure/auth_failure.dart';
import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/auth/domain/entities/admin_credentials.dart';
import 'package:result_dart/result_dart.dart';

abstract class AuthRemoteDataSource {
  AppUnitAsyncResult adminLogin(AdminCredentials credentials);
}

/// Fake implementation — ready for real API later
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  AppUnitAsyncResult adminLogin(AdminCredentials credentials) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 900));

      final email = credentials.email.trim();
      final password = credentials.password;

      if (email == "admin@example.com" && password == "123456") {
        return const Success(unit);
      }

      return const Failure(InvalidCredentialsFailure());
    } catch (e, _) {
       final failure = UnknownFailure(e.toString());
      return Failure(failure);
    }
  }
}
