/// Centralized validation functions for the application.
/// All validators return null if validation passes, or an error message string if it fails.
class Validators {
  Validators._();

  // URL validation regex
  static final _urlRegex = RegExp(
    r'^https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_+.~#?&/=]*)$',
  );

  // Email validation regex
  static final _emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");

  /// Validates a required field (non-empty after trimming).
  static String? required(String? value, {String fieldName = 'This field'}) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) {
      return "$fieldName is required.";
    }
    return null;
  }

  /// Validates a URL field.
  /// Returns null if valid or empty (optional), or an error message if invalid.
  static String? url(String? value, {bool isRequired = false, String fieldName = 'URL'}) {
    final text = value?.trim() ?? "";
    
    if (text.isEmpty) {
      if (isRequired) {
        return "$fieldName is required.";
      }
      return null; // Optional field can be empty
    }

    if (!_urlRegex.hasMatch(text)) {
      return "Please enter a valid $fieldName (must start with http:// or https://).";
    }

    return null;
  }

  /// Validates a name/title field.
  /// Checks for minimum length and maximum length.
  static String? name(
    String? value, {
    int minLength = 2,
    int maxLength = 100,
    bool isRequired = true,
    String fieldName = 'Name',
  }) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) {
      if (isRequired) {
        return "$fieldName is required.";
      }
      return null;
    }

    if (text.length < minLength) {
      return "$fieldName must be at least $minLength characters.";
    }

    if (text.length > maxLength) {
      return "$fieldName must not exceed $maxLength characters.";
    }

    return null;
  }

  /// Validates an email address.
  static String? email(String? value, {bool isRequired = true, String fieldName = 'Email'}) {
    final text = value?.trim() ?? "";
    
    if (text.isEmpty) {
      if (isRequired) {
        return "$fieldName is required.";
      }
      return null;
    }

    if (!_emailRegex.hasMatch(text)) {
      return "Please enter a valid $fieldName.";
    }

    return null;
  }

  /// Validates a password.
  static String? password(
    String? value, {
    int minLength = 6,
    bool isRequired = true,
    String fieldName = 'Password',
  }) {
    final text = value ?? "";
    
    if (text.isEmpty) {
      if (isRequired) {
        return "$fieldName is required.";
      }
      return null;
    }

    if (text.length < minLength) {
      return "$fieldName must be at least $minLength characters.";
    }

    return null;
  }

  /// Validates a description/text field.
  static String? description(
    String? value, {
    int minLength = 10,
    int maxLength = 2000,
    bool isRequired = true,
    String fieldName = 'Description',
  }) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) {
      if (isRequired) {
        return "$fieldName is required.";
      }
      return null;
    }

    if (text.length < minLength) {
      return "$fieldName must be at least $minLength characters.";
    }

    if (text.length > maxLength) {
      return "$fieldName must not exceed $maxLength characters.";
    }

    return null;
  }

  /// Validates a comma-separated list (e.g., technologies).
  static String? commaSeparatedList(
    String? value, {
    bool isRequired = false,
    String fieldName = 'List',
  }) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) {
      if (isRequired) {
        return "$fieldName is required.";
      }
      return null;
    }

    // Basic validation: check if it's a valid comma-separated format
    final items = text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    
    if (items.isEmpty && isRequired) {
      return "$fieldName must contain at least one item.";
    }

    return null;
  }
}


