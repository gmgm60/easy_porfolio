import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/auth/domain/entities/admin_credentials.dart';
import 'package:easy_porfolio/features/auth/domain/repositories/auth_repository.dart';

class AdminLogin {
  final AuthRepository repository;

  const AdminLogin(this.repository);

  AppUnitAsyncResult call(AdminCredentials credentials) {
    return repository.adminLogin(credentials);
  }
}
