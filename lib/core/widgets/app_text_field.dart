import 'package:easy_porfolio/features/auth/presentation/widgets/slide_fade_transition_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/validation/validators.dart';

/// A reusable, themed TextFormField widget with built-in validation support.
///
/// This widget provides:
/// - Themed styling using theme extensions
/// - Support for custom validators
/// - Input formatters
/// - Consistent appearance across the app
/// - Support for both controller-based and value/onChange patterns
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.value,
    this.labelText,
    this.hintText,
    this.helperText,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.enabled = true,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.autofocus = false,
    this.readOnly = false,
    this.isRequired = false,
    this.fieldName,
    this.validationType,
    this.customValidationParams,
    this.animationDelay = Duration.zero,
  });

  final TextEditingController? controller;
  final String? value;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final bool enabled;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool autofocus;
  final bool readOnly;
  final bool isRequired;
  final String? fieldName;
  final Duration animationDelay;

  /// Predefined validation types for common use cases
  final ValidationType? validationType;

  /// Custom parameters for validation (e.g., minLength, maxLength)
  final Map<String, dynamic>? customValidationParams;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null && widget.value != null) {
      _controller = TextEditingController(text: widget.value);
    }
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null) {
      if (_controller == null && widget.value != null) {
        _controller = TextEditingController(text: widget.value);
      } else if (_controller != null && widget.value != oldWidget.value) {
        if (widget.value != _controller!.text) {
          _controller!.text = widget.value ?? '';
        }
      }
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.spacingTokens;
    final radius = context.radiusTokens;
    final textStyles = context.textStyles;

    final effectiveController = widget.controller ?? _controller;

    // Build the validator function
    String? Function(String?)? finalValidator = widget.validator;

    if (widget.validationType != null && widget.validator == null) {
      finalValidator = _buildValidatorFromType();
    } else if (widget.isRequired && widget.validator == null) {
      finalValidator = (value) => Validators.required(
        value,
        fieldName: widget.fieldName ?? widget.labelText ?? 'This field',
      );
    }

    // Build input formatters
    final List<TextInputFormatter> finalFormatters = [];

    if (widget.inputFormatters != null) {
      finalFormatters.addAll(widget.inputFormatters!);
    }

    // Add trimming formatter for single-line text fields
    if (widget.maxLines == 1 || widget.maxLines == null) {
      finalFormatters.add(FilteringTextInputFormatter.deny(RegExp(r'\n')));
    }

    return SlideFadeTransitionWidget(
      child: TextFormField(
        controller: effectiveController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          helperText: widget.helperText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          enabled: widget.enabled,
          border: OutlineInputBorder(
            borderRadius: radius.all8,
            borderSide: BorderSide(
              color: colors.textMuted.withValues(alpha: 0.3),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: radius.all8,
            borderSide: BorderSide(
              color: colors.textMuted.withValues(alpha: 0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: radius.all8,
            borderSide: BorderSide(color: colors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: radius.all8,
            borderSide: BorderSide(color: colors.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: radius.all8,
            borderSide: BorderSide(color: colors.error, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: radius.all8,
            borderSide: BorderSide(
              color: colors.textMuted.withValues(alpha: 0.1),
            ),
          ),
          labelStyle: textStyles.bodyMediumTextStyle,
          hintStyle: textStyles.bodyMediumTextStyle.copyWith(
            color: colors.textMuted,
          ),
          helperStyle: textStyles.bodySmallTextStyle.copyWith(
            color: colors.textMuted,
          ),
          errorStyle: textStyles.bodySmallTextStyle.copyWith(
            color: colors.error,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: spacing.md,
            vertical: spacing.md,
          ),
        ),
        style: textStyles.bodyMediumTextStyle,
        validator: finalValidator,
        onChanged: (value) {
          widget.onChanged?.call(value);
        },
        onSaved: widget.onSaved,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        inputFormatters: finalFormatters.isEmpty ? null : finalFormatters,
        autofocus: widget.autofocus,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
      ),
    );
  }

  String? Function(String?)? _buildValidatorFromType() {
    final name = widget.fieldName ?? widget.labelText ?? 'This field';
    final params = widget.customValidationParams ?? {};

    switch (widget.validationType!) {
      case ValidationType.required:
        return (value) => Validators.required(value, fieldName: name);

      case ValidationType.name:
        return (value) => Validators.name(
          value,
          minLength: params['minLength'] as int? ?? 2,
          maxLength: params['maxLength'] as int? ?? 100,
          isRequired: widget.isRequired,
          fieldName: name,
        );

      case ValidationType.url:
        return (value) => Validators.url(
          value,
          isRequired: widget.isRequired,
          fieldName: name,
        );

      case ValidationType.email:
        return (value) => Validators.email(
          value,
          isRequired: widget.isRequired,
          fieldName: name,
        );

      case ValidationType.password:
        return (value) => Validators.password(
          value,
          minLength: params['minLength'] as int? ?? 6,
          isRequired: widget.isRequired,
          fieldName: name,
        );

      case ValidationType.description:
        return (value) => Validators.description(
          value,
          minLength: params['minLength'] as int? ?? 10,
          maxLength: params['maxLength'] as int? ?? 2000,
          isRequired: widget.isRequired,
          fieldName: name,
        );

      case ValidationType.commaSeparatedList:
        return (value) => Validators.commaSeparatedList(
          value,
          isRequired: widget.isRequired,
          fieldName: name,
        );
    }
  }
}

/// Predefined validation types for common use cases.
enum ValidationType {
  required,
  name,
  url,
  email,
  password,
  description,
  commaSeparatedList,
}
