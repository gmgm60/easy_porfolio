import 'package:easy_porfolio/core/services/messaging_service/helper_message.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/utils/validator.dart';
import 'package:easy_porfolio/core/widgets/error_banner_widget.dart';
import 'package:easy_porfolio/features/auth/presentation/widgets/admin_header_widget.dart';
import 'package:easy_porfolio/features/auth/presentation/widgets/auth_text_field_widget.dart';
import 'package:easy_porfolio/features/auth/presentation/widgets/label_field_widget.dart';
import 'package:easy_porfolio/features/auth/presentation/widgets/passord_field_widget.dart';
import 'package:easy_porfolio/features/auth/presentation/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  String? _formError;
  bool _isSubmitting = false;

  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // start entrance animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final form = _formKey.currentState;
    if (form == null) {
      return;
    }


    if (!form.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    await Future<void>.delayed(const Duration(milliseconds: 900));

    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;

    if (email == "admin@example.com" && password == "123456") {
      if (!mounted) {
        return;
      }

    ToastMessage.success(message: "Logged in successfully", ctx: context);
      // Navigate to dashboard here
    }
    else {
      setState(() {
        _formError =
            "We couldn't find an account with those credentials. Double-check your email and password.";
      });
    }

    if (mounted) {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 0 : 24,
                    vertical: 24,
                  ),
                  child: FadeTransition(
                    opacity: _fade,
                    child: SlideTransition(
                      position: _slide,
                      child: _AuthCard(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(child: AdminHeaderWidget()),
                              const SizedBox(height: 32),
                              LabelFieldWidget(
                                label: "Email",
                                child: AuthTextFieldWidget(
                                  controller: _emailCtrl,
                                  hintText: "Enter your email",
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: Icons.mail_outline,
                                  validator: Validators.validateEmail,
                                ),
                              ),
                              const SizedBox(height: 20),
                              LabelFieldWidget(
                                label: "Password",
                                child: PasswordFieldWidget(
                                  controller: _passwordCtrl,
                                  validator: Validators.validatePassword,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: _isSubmitting ? null : () {},
                                  child: Text(
                                    "Forgot Password?",
                                    style: context.textStyles.buttonTextStyle.copyWith(color: context.appColors.primary),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              AnimatedSize(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOutCubic,
                                child: _formError == null
                                    ? const SizedBox.shrink()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                        ),
                                        child: ErrorBannerWidget(
                                          message: _formError!,
                                        ),
                                      ),
                              ),
                              const SizedBox(height: 8),
                               PrimaryButtonWidget(
                                label: "Login",
                                isLoading: _isSubmitting,
                                onPressed: _isSubmitting ? null : _submit,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


}

/// Card Shell
class _AuthCard extends StatelessWidget {
  const _AuthCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final radius = context.radiusTokens;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: radius.all16,
        border: Border.all(color: colors.textMuted.withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
             blurRadius: 55,
             offset: const Offset(1, 1),
            color: colors.onSurface.withValues(alpha: 0.3),
          ),
        ],
      ),
      child: child,
    );
  }
}

