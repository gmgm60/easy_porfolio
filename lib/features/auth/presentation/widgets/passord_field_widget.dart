import 'package:easy_porfolio/features/auth/presentation/widgets/auth_text_field_widget.dart';
import 'package:flutter/material.dart';

class PasswordFieldWidget extends StatefulWidget {
  const PasswordFieldWidget({
    super.key,
    required this.controller,
    required this.validator,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<PasswordFieldWidget> createState() => PasswordFieldWidgetState();
}

class PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return AuthTextFieldWidget(
      controller: widget.controller,
      hintText: "Enter your password",
      validator: widget.validator,
      prefixIcon: Icons.lock_outline,
      obscureText: _obscure,
      suffixIcon: IconButton(
        tooltip: _obscure ? "Show password" : "Hide password",
        icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off),
        onPressed: () {
          setState(() => _obscure = !_obscure);
        },
      ),
    );
  }
}
