
import 'package:easy_porfolio/core/network/failure/app_failure.dart';

class AuthFailure extends AppFailure {
  const AuthFailure(super.message);
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure()
      : super(
    "We couldn't find an account with those credentials. Double-check your email and password.",
  );
}
