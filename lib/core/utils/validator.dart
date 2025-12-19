
class Validators {
  /// A simple email validation regex.
  static final _emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");

  /// Validates an email address.
  /// Returns an error message string if validation fails, otherwise returns null.
  static String? validateEmail(String? value) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) {
      return "Email is required.";
    }
    if (!_emailRegex.hasMatch(text)) {
      return "Enter a valid email address.";
    }
    return null;
  }

  /// Validates a password.
  /// Returns an error message string if validation fails, otherwise returns null.
  static String? validatePassword(String? value, {int minLength = 6}) {
    final text = value ?? "";
    if (text.isEmpty) {
      return "Password is required.";
    }
    if (text.length < minLength) {
      return "Password must be at least $minLength characters.";
    }
    return null;
  }

}