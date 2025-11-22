import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/auth/domain/entities/admin_credentials.dart';
import 'package:easy_porfolio/features/auth/domain/repositories/auth_repository.dart';
import 'package:easy_porfolio/features/auth/data/datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  const AuthRepositoryImpl({required this.remote});

  @override
  AppUnitAsyncResult adminLogin(AdminCredentials credentials) {
    return remote.adminLogin(credentials);
  }
}
