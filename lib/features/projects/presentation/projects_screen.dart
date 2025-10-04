
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_porfolio/features/projects/data/projects_provider.dart';
import 'package:easy_porfolio/features/projects/data/models/project.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredProjects = ref.watch(featuredProjectsProvider);
    final otherProjects = ref.watch(otherProjectsProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Featured Projects', style: textTheme.displaySmall),
            const SizedBox(height: 16),
            _FeaturedProjectsList(projects: featuredProjects),
            const SizedBox(height: 32),
            Text('All Projects', style: textTheme.displaySmall),
            const SizedBox(height: 16),
            _ProjectsGrid(projects: otherProjects),
          ],
        ),
      ),
    );
  }
}

class _FeaturedProjectsList extends StatelessWidget {
  final List<Project> projects;
  const _FeaturedProjectsList({required this.projects});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return SizedBox(
              width: 300,
              child: _ProjectCard(project: project, isFeatured: true));
        },
      ),
    );
  }
}

class _ProjectsGrid extends StatelessWidget {
  final List<Project> projects;
  const _ProjectsGrid({required this.projects});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return _ProjectCard(project: project);
      },
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  final bool isFeatured;

  const _ProjectCard({required this.project, this.isFeatured = false});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => context.go('/projects/${project.id}'),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                project.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project.title, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  if (isFeatured)
                    Text(project.description, style: textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
