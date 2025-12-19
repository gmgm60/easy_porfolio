import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_porfolio/features/projects/domain/entities/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_porfolio/features/projects/presentation/providers/projects_state_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';

class ProjectDetailsScreen extends ConsumerWidget {
  final String projectId;

  const ProjectDetailsScreen({super.key, required this.projectId});

  Project? _findProject(WidgetRef ref) {
    final state = ref.watch(projectsStateProvider);
    try {
      return state.projects.firstWhere((p) => p.id == projectId);
    } catch (_) {
      return null;
    }
  }



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = _findProject(ref);
    final textTheme = Theme.of(context).textTheme;
    final colors = context.appColors;
    final spacing = context.spacingTokens;

    if (project == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: spacing.lg * 3,
                color: colors.textMuted,
              ),
              SizedBox(height: spacing.md),
              Text('Project not found', style: textTheme.headlineSmall),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (project.description.isNotEmpty)
              Text(project.description, style: textTheme.bodyLarge),
            if (project.description.isNotEmpty) SizedBox(height: spacing.lg),
            if (project.screenshots.isNotEmpty) ...[
              Text('Screenshots', style: textTheme.displaySmall),
              SizedBox(height: spacing.md),
              _ScreenshotsCarousel(screenshots: project.screenshots),
              SizedBox(height: spacing.lg),
            ],
            if (project.technologies.isNotEmpty) ...[
              Text('Technologies Used', style: textTheme.displaySmall),
              SizedBox(height: spacing.md),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: project.technologies
                    .map((tech) => Chip(label: Text(tech)))
                    .toList(),
              ),
              SizedBox(height: spacing.lg),
            ],
            if (project.liveDemoUrl != null ||
                project.repositoryUrl != null) ...[
              Text('Links', style: textTheme.displaySmall),
              SizedBox(height: spacing.md),
              if (project.liveDemoUrl != null)
                _LinkTile(title: 'Live Demo', url: project.liveDemoUrl!),
              if (project.repositoryUrl != null)
                _LinkTile(title: 'Repository', url: project.repositoryUrl!),
            ],
          ],
        ),
      ),
    );
  }
}

class _ScreenshotsCarousel extends StatelessWidget {
  final List<String> screenshots;

  const _ScreenshotsCarousel({required this.screenshots});

  Uint8List? _getImageBytes(String base64String) {
    if (base64String.isEmpty) {
      return null;
    }
    try {
      String cleanBase64 = base64String;
      if (cleanBase64.startsWith('data:image')) {
        final commaIndex = cleanBase64.indexOf(',');
        if (commaIndex != -1) {
          cleanBase64 = cleanBase64.substring(commaIndex + 1);
        }
      }
      return base64Decode(cleanBase64);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return SizedBox(
      height: 400,
      child: PageView.builder(
        itemCount: screenshots.length,
        itemBuilder: (context, index) {
          final bytes = _getImageBytes(screenshots[index]);
          return Card(
            clipBehavior: Clip.antiAlias,
            child: bytes != null
                ? Image.memory(
                    bytes,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: colors.surfaceVariant,
                        child: Center(
                          child: Icon(
                            Icons.broken_image,
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
