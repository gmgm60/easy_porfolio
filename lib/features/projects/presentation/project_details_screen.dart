
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_porfolio/features/projects/data/projects_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsScreen extends ConsumerWidget {
  final String projectId;
  const ProjectDetailsScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectDetailsProvider(projectId));
    final textTheme = Theme.of(context).textTheme;

    if (project == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Project not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.description, style: textTheme.bodyLarge),
            const SizedBox(height: 24),
            Text('Screenshots', style: textTheme.displaySmall),
            const SizedBox(height: 16),
            _ScreenshotsCarousel(screenshots: project.screenshots),
            const SizedBox(height: 24),
            Text('Technologies Used', style: textTheme.displaySmall),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: project.technologies.map((tech) => Chip(label: Text(tech))).toList(),
            ),
            const SizedBox(height: 24),
            Text('Links', style: textTheme.displaySmall),
            const SizedBox(height: 16),
            if (project.liveDemoUrl != null)
              _LinkTile(title: 'Live Demo', url: project.liveDemoUrl!),
            if (project.repositoryUrl != null)
              _LinkTile(title: 'Repository', url: project.repositoryUrl!),
          ],
        ),
      ),
    );
  }
}

class _ScreenshotsCarousel extends StatelessWidget {
  final List<String> screenshots;
  const _ScreenshotsCarousel({required this.screenshots});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PageView.builder(
        itemCount: screenshots.length,
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Image.network(screenshots[index], fit: BoxFit.contain),
          );
        },
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  final String title;
  final String url;

  const _LinkTile({required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(FontAwesomeIcons.arrowRight),
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
    );
  }
}
