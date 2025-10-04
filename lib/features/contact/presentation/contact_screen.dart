
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_porfolio/features/contact/data/contact_provider.dart';
import 'package:easy_porfolio/features/contact/data/models/contact_method.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getInTouchMethods = ref.watch(getInTouchProvider);
    final socialMethods = ref.watch(socialProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Get in touch', style: textTheme.displaySmall),
            const SizedBox(height: 16),
            ...getInTouchMethods.map((method) => _ContactTile(method: method)),
            const SizedBox(height: 32),
            Text('Social', style: textTheme.displaySmall),
            const SizedBox(height: 16),
            ...socialMethods.map((method) => _ContactTile(method: method)),
          ],
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final ContactMethod method;
  const _ContactTile({required this.method});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(method.icon, size: 28),
      title: Text(method.title),
      subtitle: Text(method.subtitle),
      onTap: () async {
        final uri = Uri.parse(method.url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
    );
  }
}
