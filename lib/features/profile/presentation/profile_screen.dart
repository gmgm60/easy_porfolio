
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_porfolio/features/profile/data/profile_provider.dart';
import 'package:easy_porfolio/core/theme/app_theme.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(profile.imageUrl),
                  ),
                  const SizedBox(height: 16),
                  Text(profile.name, style: textTheme.displayMedium),
                  const SizedBox(height: 4),
                  Text(profile.title, style: textTheme.bodyLarge?.copyWith(color: AppTheme.onSurfaceVariantColor)),
                  const SizedBox(height: 4),
                  Text(profile.location, style: textTheme.bodyMedium),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Skills', style: textTheme.displaySmall),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: profile.skills.map((skill) => Chip(label: Text(skill.name))).toList(),
            ),
            const SizedBox(height: 32),
            Text('Experience', style: textTheme.displaySmall),
            const SizedBox(height: 16),
            ...profile.experiences.map((exp) => _ExperienceTile(experience: exp)),
            const SizedBox(height: 32),
            Text('Education', style: textTheme.displaySmall),
            const SizedBox(height: 16),
            _EducationTile(
              university: profile.education,
              degree: 'B.S. in Computer Science', // This can be added to the model
              period: profile.educationPeriod,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceTile extends StatelessWidget {
  final dynamic experience;
  const _ExperienceTile({required this.experience});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(experience.company, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(experience.position, style: textTheme.bodyMedium),
      trailing: Text(experience.period, style: textTheme.bodyMedium),
    );
  }
}

class _EducationTile extends StatelessWidget {
  final String university;
  final String degree;
  final String period;

  const _EducationTile({
    required this.university,
    required this.degree,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(university, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(degree, style: textTheme.bodyMedium),
      trailing: Text(period, style: textTheme.bodyMedium),
    );
  }
}
