 import 'package:easy_porfolio/core/services/messaging_service/helper_message.dart';
import 'package:easy_porfolio/core/utils/validator.dart';
import 'package:easy_porfolio/core/widgets/animated_size_visibility.dart';
import 'package:easy_porfolio/core/widgets/app_text_field.dart';
import 'package:easy_porfolio/core/widgets/custom_animated_card.dart';
import 'package:easy_porfolio/core/widgets/error_banner_widget.dart';
import 'package:easy_porfolio/core/widgets/text_link_widget.dart';
import 'package:easy_porfolio/features/auth/data/models/login_form_model.dart';
import 'package:easy_porfolio/features/auth/presentation/providers/admin_login_provider.dart';
import 'package:easy_porfolio/features/auth/presentation/widgets/admin_header_widget.dart';
import 'package:easy_porfolio/features/auth/presentation/widgets/label_field_widget.dart';
import 'package:easy_porfolio/features/auth/presentation/widgets/password_field_widget.dart';
import 'package:easy_porfolio/features/auth/presentation/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AdminLoginPage extends ConsumerStatefulWidget {
  const AdminLoginPage({super.key});

  @override
  ConsumerState<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends ConsumerState<AdminLoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  LoginFormModel _formData = const LoginFormModel();

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

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }

    final params = LoginCredentialsParams(
      email: _formData.email,
      password: _formData.password,
    );

    await ref.read(adminLoginProvider.notifier).login(params);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(adminLoginProvider);
    final isSubmitting = loginState.isLoading;
    final errorMessage = loginState.error;


    // Handle success side effect
    ref.listen<AdminLoginState>(adminLoginProvider, (prev, next) {
      if ((prev?.isLoading ?? false) && !next.isLoading && next.error == null) {
        ToastMessage.success(message: "Logged in successfully", ctx: context);
        context.go('/dashboard');
      }
    });

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
                      child: CustomAnimatedCard(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(child: AdminHeaderWidget()),
                              const SizedBox(height: 32),

                              // Email
                              LabelFieldWidget(
                                label: "Email",
                                child: AppTextField(
                                  value: _formData.email,
                                  hintText: "Enter your email",
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: const Icon(Icons.mail_outline),
                                  validator: Validators.validateEmail,
                                  onChanged: (value) {
                                    setState(() {
                                      _formData = _formData.copyWith(
                                        email: value,
                                      );
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Password
                              LabelFieldWidget(
                                label: "Password",
                                child: PasswordFieldWidget(
                                  value: _formData.password,
                                  onChanged: (value) {
                                    setState(() {
                                      _formData = _formData.copyWith(
                                        password: value,
                                      );
                                    });
                                  },
                                  validator: Validators.validatePassword,
                                ),
                              ),

                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextLinkWidget(
                                  text: "Forgot Password?",
                                  onPressed: isSubmitting
                                      ? null
                                      : () {
                                          /* navigate or show dialog */
                                        },
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Error banner (animated visibility)
                              AnimatedSizeVisibility(
                                isVisible:
                                    errorMessage != null && !isSubmitting,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: ErrorBannerWidget(
                                    message: errorMessage ?? '',
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Primary action
                              PrimaryButtonWidget(
                                label: "Login",
                                isLoading: isSubmitting,
                                onPressed: isSubmitting ? null : _submit,
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
