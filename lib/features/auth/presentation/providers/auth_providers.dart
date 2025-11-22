import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:easy_porfolio/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:easy_porfolio/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:easy_porfolio/features/auth/domain/repositories/auth_repository.dart';
import 'package:easy_porfolio/features/auth/domain/usecases/admin_login.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
   return AuthRepositoryImpl(remote: remote);
});

final adminLoginUseCaseProvider = Provider<AdminLogin>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AdminLogin(repo);
});
