import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/utils/responsive_util.dart';
import 'package:easy_porfolio/core/widgets/fade_scale_animation.dart';
import 'package:easy_porfolio/core/widgets/error_banner_widget.dart';
import 'package:easy_porfolio/features/projects/domain/entities/project.dart';
import 'package:easy_porfolio/features/projects/presentation/providers/project_details_notifier.dart';

/// Details page for viewing a single project (admin interface).
class ProjectDetailsPage extends ConsumerStatefulWidget {
  const ProjectDetailsPage({super.key, required this.projectId});

  final String projectId;

  @override
  ConsumerState<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends ConsumerState<ProjectDetailsPage> {
  @override
  void initState() {
    super.initState();
    // Load project when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref
            .read(projectDetailsNotifierProvider.notifier)
            .loadProject(widget.projectId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncProject = ref.watch(projectDetailsNotifierProvider);
    final isMobile = ResponsiveUtil.isMobile(context);
    final isTablet = ResponsiveUtil.isTablet(context);

    return Scaffold(
      body: asyncProject.when(
        data: (project) => _buildProjectDetails(project, isMobile, isTablet),
        loading: () => Center(
          child: CircularProgressIndicator(color: context.appColors.primary),
        ),
        error: (error, stackTrace) => _buildErrorState(error.toString()),
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    final spacing = context.spacingTokens;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ErrorBannerWidget(message: errorMessage),
            SizedBox(height: spacing.lg),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(projectDetailsNotifierProvider.notifier).refresh();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
            SizedBox(height: spacing.md),
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectDetails(Project project, bool isMobile, bool isTablet) {
    return CustomScrollView(
      slivers: [
        _ProjectDetailsAppBar(project: project),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(
              isMobile ? context.spacingTokens.md : context.spacingTokens.lg,
            ),
            child: isMobile
                ? _buildMobileLayout(project)
                : isTablet
                ? _buildTabletLayout(project)
                : _buildDesktopLayout(project),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ProjectImageSection(project: project),
        SizedBox(height: context.spacingTokens.md),
        _ProjectInfoSection(project: project),
        SizedBox(height: context.spacingTokens.md),
        _ProjectScreenshotsSection(project: project),
        SizedBox(height: context.spacingTokens.md),
        _ProjectLinksSection(project: project),
        SizedBox(height: context.spacingTokens.md),
        _ProjectMetadataSection(project: project),
      ],
    );
  }

  Widget _buildTabletLayout(Project project) {
    final spacing = context.spacingTokens;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ProjectImageSection(project: project),
              SizedBox(height: spacing.md),
              _ProjectInfoSection(project: project),
              SizedBox(height: spacing.md),
              _ProjectLinksSection(project: project),
              SizedBox(height: spacing.md),
              _ProjectMetadataSection(project: project),
            ],
          ),
        ),
        SizedBox(width: spacing.lg),
        Expanded(flex: 1, child: _ProjectScreenshotsSection(project: project)),
      ],
    );
  }

  Widget _buildDesktopLayout(Project project) {
    final spacing = context.spacingTokens;
    final maxWidth = 1200.0;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ProjectImageSection(project: project),
                  SizedBox(height: spacing.lg),
                  _ProjectInfoSection(project: project),
                  SizedBox(height: spacing.lg),
                  _ProjectScreenshotsSection(project: project),
                ],
              ),
            ),
            SizedBox(width: spacing.lg * 2),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ProjectLinksSection(project: project),
                  SizedBox(height: spacing.lg),
                  _ProjectMetadataSection(project: project),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// App bar for project details page.
class _ProjectDetailsAppBar extends StatelessWidget {
  const _ProjectDetailsAppBar({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.textStyles;
    final spacing = context.spacingTokens;
    final isMobile = ResponsiveUtil.isMobile(context);

    return SliverAppBar(
      expandedHeight: isMobile ? 200.0 : 300.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          project.title.isNotEmpty ? project.title : 'Untitled Project',
          style: textStyles.titleLargeTextStyle.copyWith(
            color: colors.onSurface,
            shadows: [Shadow(color: colors.surface, blurRadius: 4)],
          ),
        ),
        background: _ProjectHeaderImage(project: project),
      ),
      actions: [
        if (project.isFeatured)
          Container(
            margin: EdgeInsets.only(right: spacing.md),
            padding: EdgeInsets.symmetric(
              horizontal: spacing.sm,
              vertical: spacing.xs,
            ),
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: context.radiusTokens.all8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, size: spacing.md, color: colors.onPrimary),
                SizedBox(width: spacing.xs),
                Text(
                  'Featured',
                  style: textStyles.labelSmallTextStyle.copyWith(
                    color: colors.onPrimary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Header image for the app bar.
class _ProjectHeaderImage extends StatelessWidget {
  const _ProjectHeaderImage({required this.project});

  final Project project;

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
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final bytes = _getImageBytes();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.surfaceVariant, colors.surface],
        ),
      ),
      child: bytes != null
          ? Image.memory(
              bytes,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholder(context);
              },
            )
          : _buildPlaceholder(context),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final colors = context.appColors;
    return Container(
      color: colors.surfaceVariant,
      child: Center(
        child: Icon(Icons.image_outlined, size: 80, color: colors.textMuted),
      ),
    );
  }
}

/// Project image section.
class _ProjectImageSection extends StatelessWidget {
  const _ProjectImageSection({required this.project});

  final Project project;

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
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = context.radiusTokens;
    final bytes = _getImageBytes();

    return FadeScaleAnimation(
      child: ClipRRect(
        borderRadius: radius.all16,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: bytes != null
              ? Image.memory(
                  bytes,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholder(context);
                  },
                )
              : _buildPlaceholder(context),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final colors = context.appColors;
    return Container(
      color: colors.surfaceVariant,
      child: Center(
        child: Icon(Icons.image_outlined, size: 64, color: colors.textMuted),
      ),
    );
  }
}

/// Project info section (title, description, technologies).
class _ProjectInfoSection extends StatelessWidget {
  const _ProjectInfoSection({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;
    final textStyles = context.textStyles;
    final colors = context.appColors;

    return FadeScaleAnimation(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (project.title.isNotEmpty) ...[
            Text(project.title, style: textStyles.headlineMediumTextStyle),
            SizedBox(height: spacing.sm),
          ],
          if (project.description.isNotEmpty) ...[
            Text(
              project.description,
              style: textStyles.bodyLargeTextStyle.copyWith(
                color: colors.textMuted,
                height: 1.6,
              ),
            ),
            SizedBox(height: spacing.md),
          ],
          if (project.technologies.isNotEmpty) ...[
            Text('Technologies', style: textStyles.titleSmallTextStyle),
            SizedBox(height: spacing.sm),
            Wrap(
              spacing: spacing.sm,
              runSpacing: spacing.sm,
              children: project.technologies.map((tech) {
                return Chip(
                  label: Text(tech),
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.sm,
                    vertical: spacing.xs,
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

/// Project screenshots section.
class _ProjectScreenshotsSection extends StatelessWidget {
  const _ProjectScreenshotsSection({required this.project});

  final Project project;

  List<Uint8List> _getScreenshotBytes() {
    final List<Uint8List> bytesList = [];
    for (final screenshot in project.screenshots) {
      if (screenshot.isEmpty) continue;
      try {
        String base64String = screenshot;
        if (base64String.startsWith('data:image')) {
          final commaIndex = base64String.indexOf(',');
          if (commaIndex != -1) {
            base64String = base64String.substring(commaIndex + 1);
          }
        }
        bytesList.add(base64Decode(base64String));
      } catch (e) {
        // Skip invalid screenshots
        continue;
      }
    }
    return bytesList;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;
    final textStyles = context.textStyles;
    final radius = context.radiusTokens;
    final colors = context.appColors;
    final screenshots = _getScreenshotBytes();

    if (screenshots.isEmpty) {
      return const SizedBox.shrink();
    }

    return FadeScaleAnimation(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Screenshots', style: textStyles.titleLargeTextStyle),
          SizedBox(height: spacing.md),
          SizedBox(
            height: ResponsiveUtil.isMobile(context) ? 200 : 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: screenshots.length,
              itemBuilder: (context, index) {
                return Container(
                  width: ResponsiveUtil.isMobile(context) ? 300 : 400,
                  margin: EdgeInsets.only(
                    right: index < screenshots.length - 1 ? spacing.md : 0,
                  ),
                  child: ClipRRect(
                    borderRadius: radius.all12,
                    child: Image.memory(
                      screenshots[index],
                      fit: BoxFit.cover,
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
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Project links section.
class _ProjectLinksSection extends StatelessWidget {
  const _ProjectLinksSection({required this.project});

  final Project project;

  Future<void> _launchUrl(String url, BuildContext context) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not launch $url'),
              backgroundColor: context.appColors.error,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: context.appColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;
    final textStyles = context.textStyles;
    final colors = context.appColors;
    final radius = context.radiusTokens;

    final hasLinks =
        project.liveDemoUrl != null || project.repositoryUrl != null;

    if (!hasLinks) {
      return const SizedBox.shrink();
    }

    return FadeScaleAnimation(
      child: Container(
        padding: EdgeInsets.all(spacing.lg),
        decoration: BoxDecoration(
          color: colors.surfaceVariant.withValues(alpha: 0.3),
          borderRadius: radius.all16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.link, color: colors.primary),
                SizedBox(width: spacing.sm),
                Text('Links', style: textStyles.titleMediumTextStyle),
              ],
            ),
            SizedBox(height: spacing.md),
            if (project.liveDemoUrl != null)
              _LinkButton(
                icon: Icons.language,
                label: 'Live Demo',
                url: project.liveDemoUrl!,
                onTap: () => _launchUrl(project.liveDemoUrl!, context),
              ),
            if (project.liveDemoUrl != null && project.repositoryUrl != null)
              SizedBox(height: spacing.sm),
            if (project.repositoryUrl != null)
              _LinkButton(
                icon: Icons.code,
                label: 'Repository',
                url: project.repositoryUrl!,
                onTap: () => _launchUrl(project.repositoryUrl!, context),
              ),
          ],
        ),
      ),
    );
  }
}

/// Link button widget.
class _LinkButton extends StatelessWidget {
  const _LinkButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String url;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;
    final colors = context.appColors;
    final textStyles = context.textStyles;
    final radius = context.radiusTokens;

    return InkWell(
      onTap: onTap,
      borderRadius: radius.all8,
      child: Container(
        padding: EdgeInsets.all(spacing.md),
        decoration: BoxDecoration(
          border: Border.all(color: colors.textMuted.withValues(alpha: 0.2)),
          borderRadius: radius.all8,
        ),
        child: Row(
          children: [
            Icon(icon, color: colors.primary),
            SizedBox(width: spacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: textStyles.bodyMediumTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spacing.xs / 2),
                  Text(
                    url,
                    style: textStyles.bodySmallTextStyle.copyWith(
                      color: colors.textMuted,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.open_in_new, size: spacing.md, color: colors.textMuted),
          ],
        ),
      ),
    );
  }
}

/// Project metadata section (dates, featured status).
class _ProjectMetadataSection extends StatelessWidget {
  const _ProjectMetadataSection({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;
    final textStyles = context.textStyles;
    final colors = context.appColors;
    final radius = context.radiusTokens;

    return FadeScaleAnimation(
      child: Container(
        padding: EdgeInsets.all(spacing.lg),
        decoration: BoxDecoration(
          color: colors.surfaceVariant.withValues(alpha: 0.3),
          borderRadius: radius.all16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: colors.primary),
                SizedBox(width: spacing.sm),
                Text(
                  'Project Information',
                  style: textStyles.titleMediumTextStyle,
                ),
              ],
            ),
            SizedBox(height: spacing.md),
            _MetadataRow(
              icon: Icons.calendar_today,
              label: 'Created',
              value: _formatDate(project.createdAt),
            ),
            SizedBox(height: spacing.sm),
            _MetadataRow(
              icon: Icons.update,
              label: 'Last Updated',
              value: _formatDate(project.updatedAt),
            ),
            if (project.isFeatured) ...[
              SizedBox(height: spacing.sm),
              _MetadataRow(
                icon: Icons.star,
                label: 'Status',
                value: 'Featured Project',
                valueColor: colors.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

/// Metadata row widget.
class _MetadataRow extends StatelessWidget {
  const _MetadataRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;
    final textStyles = context.textStyles;
    final colors = context.appColors;

    return Row(
      children: [
        Icon(icon, size: spacing.md, color: colors.textMuted),
        SizedBox(width: spacing.sm),
        Text(
          '$label: ',
          style: textStyles.bodyMediumTextStyle.copyWith(
            color: colors.textMuted,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: textStyles.bodyMediumTextStyle.copyWith(
              color: valueColor ?? colors.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
