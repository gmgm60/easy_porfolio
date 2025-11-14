import 'package:easy_porfolio/features/auth/presentation/widgets/slide_fade_transition_widget.dart';
import 'package:flutter/material.dart';

class AuthTextFieldWidget extends StatelessWidget {
  const AuthTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.animationDelay = Duration.zero,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Duration animationDelay; // Delay for staggering animations
  @override
  Widget build(BuildContext context) {

    return SlideFadeTransitionWidget(
      delay: animationDelay,
       child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
         decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon == null ? null : Icon(prefixIcon, size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
