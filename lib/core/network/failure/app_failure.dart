
abstract class AppFailure implements Exception {
  final String message;
  final String? code;
  const AppFailure(this.message, {this.code});

  @override
  String toString() => message;
}

class UnknownFailure extends AppFailure {
  const UnknownFailure([super.message = "Unknown error"]);
}
