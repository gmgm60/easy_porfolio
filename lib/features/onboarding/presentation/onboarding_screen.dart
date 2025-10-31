
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:flutter/material.dart';
 import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = context.appColors;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Placeholder for the abstract graphic
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(125),
                ),
                child: Icon(
                  Icons.bubble_chart,
                  color: colors.primary,
                  size: 150,
                ),
              ),
              const Spacer(flex: 1),
              Text(
                'Craft Your Digital Identity',
                textAlign: TextAlign.center,
                style: textTheme.displayMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Showcase your skills, projects, and experience with a personalized portfolio. Connect with opportunities and stand out from the crowd.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
              const Spacer(flex: 2),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the main app shell
                  // The router will handle replacing this screen
                  context.go('/profile');
                },
                child: const Text('Get Started'),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
