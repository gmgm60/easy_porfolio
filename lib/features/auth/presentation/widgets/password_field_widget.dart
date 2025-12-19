import 'package:easy_porfolio/core/widgets/app_text_field.dart';
 import 'package:flutter/material.dart';

class PasswordFieldWidget extends StatefulWidget {
  const PasswordFieldWidget({
    super.key,
    this.controller,
    this.value,
    this.onChanged,
    required this.validator,
  }) : assert(
         controller == null || value == null,
         'Cannot provide both controller and value',
       );

  final TextEditingController? controller;
  final String? value;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<PasswordFieldWidget> createState() => PasswordFieldWidgetState();
}

class PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      value: widget.value,
      hintText: "Enter your password",
      validator: widget.validator,
      prefixIcon: const Icon(Icons.lock_outline),
      obscureText: _obscure,
      onChanged: widget.onChanged,
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
