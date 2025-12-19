import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_porfolio/features/projects/presentation/providers/projects_state_provider.dart';
import 'package:easy_porfolio/features/projects/domain/entities/project.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectsStateProvider);
    final featuredProjects = state.projects.where((p) => p.isFeatured).toList();
    final otherProjects = state.projects.where((p) => !p.isFeatured).toList();
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacingTokens;

    if (state.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Projects')),
        body: Center(
          child: CircularProgressIndicator(color: context.appColors.primary),
        ),
      );
    }

    if (state.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Projects')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: ${state.error}'),
              SizedBox(height: spacing.md),
              ElevatedButton(
                onPressed: () =>
                    ref.read(projectsStateProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (featuredProjects.isNotEmpty) ...[
              Text('Featured Projects', style: textTheme.displaySmall),
              SizedBox(height: spacing.md),
              _FeaturedProjectsList(projects: featuredProjects),
              SizedBox(height: spacing.lg * 2),
            ],
            Text('All Projects', style: textTheme.displaySmall),
            SizedBox(height: spacing.md),
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
    final spacing = context.spacingTokens;
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return SizedBox(
            width: 300,
            child: _ProjectCard(project: project, isFeatured: true),
          );
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
    if (projects.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(context.spacingTokens.lg),
          child: Text(
            'No projects available',
            style: context.textStyles.bodyLargeTextStyle.copyWith(
              color: context.appColors.textMuted,
            ),
          ),
        ),
      );
    }

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

  Uint8List? _getImageBytes() {
    if (project.imageUrl.isEmpty) {
      return null;
    }
    try {
      String base64String = project.imageUrl;
      if (base64String.startsWith('data:image')) {
        final commaIndex = base64String.indexOf(',');
        if (commaIndex != -1) {
          base64String = base64String.substring(commaIndex + 1);
        }
      }
      return base64Decode(base64String);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = context.appColors;
    final bytes = _getImageBytes();

    return GestureDetector(
      onTap: () => context.go('/projects/${project.id}'),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: bytes != null
                  ? Image.memory(
                      bytes,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: colors.surfaceVariant,
                          child: Center(
                            child: Icon(
                              Icons.image_outlined,
                              color: colors.textMuted,
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: colors.surfaceVariant,
                      child: Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: colors.textMuted,
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isFeatured && project.description.isNotEmpty)
                    Text(
                      project.description,
                      style: textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
