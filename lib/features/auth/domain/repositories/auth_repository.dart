
import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/auth/domain/entities/admin_credentials.dart';

abstract class AuthRepository {
  AppUnitAsyncResult adminLogin(AdminCredentials credentials);
}
