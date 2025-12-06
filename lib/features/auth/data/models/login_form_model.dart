/// Model for login form data
class LoginFormModel {
  final String email;
  final String password;

  const LoginFormModel({this.email = '', this.password = ''});

  LoginFormModel copyWith({String? email, String? password}) {
    return LoginFormModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
