import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_porfolio/core/theme/app_colors.dart';
import 'package:easy_porfolio/core/theme/spacing_tokens.dart';
import 'package:flutter/material.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/widgets/custom_animated_card.dart';
import 'package:easy_porfolio/core/widgets/fade_scale_animation.dart';
import 'package:easy_porfolio/features/projects/domain/entities/project.dart';

/// Card widget for displaying a project in the admin list/grid.
class ProjectCardWidget extends StatelessWidget {
  const ProjectCardWidget({
    super.key,
    required this.project,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final Project project;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;
    final radius = context.radiusTokens;

    return FadeScaleAnimation(
      child: CustomAnimatedCard(
        child: InkWell(
          onTap: onTap,
          borderRadius: radius.all12,
          child: Padding(
            padding: EdgeInsets.all(spacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProjectImageSection(project: project),
                SizedBox(height: spacing.sm),
                _ProjectInfoSection(project: project),
                SizedBox(height: spacing.sm),
                _ProjectActionsSection(onEdit: onEdit, onDelete: onDelete),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Private widget: handles image / thumbnail section only.
class _ProjectImageSection extends StatelessWidget {
  const _ProjectImageSection({required this.project});

  final Project project;

  Uint8List? _getImageBytes() {
    if (project.imageUrl.isEmpty) {
      return null;
    }
    try {
      // Handle both base64 string and data URL format
      String base64String = project.imageUrl;
      if (base64String.startsWith('data:image')) {
        // Extract base64 from data URL
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
    final radius = context.radiusTokens;
    final bytes = _getImageBytes();

    return ClipRRect(
      borderRadius: radius.all12,
      child: AspectRatio(
        aspectRatio: 1.3,
        child: bytes != null
            ? Image.memory(
                bytes,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const _ProjectImagePlaceholder();
                },
              )
            : const _ProjectImagePlaceholder(),
      ),
    );
  }
}

/// Private widget: placeholder for broken/missing image.
class _ProjectImagePlaceholder extends StatelessWidget {
  const _ProjectImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.spacingTokens;

    return Container(
      color: colors.surfaceVariant,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: spacing.lg * 2,
          color: colors.textMuted,
        ),
      ),
    );
  }
}

/// Private widget: title, featured badge, description, technologies.
class _ProjectInfoSection extends StatelessWidget {
  const _ProjectInfoSection({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.spacingTokens;
    final radius = context.radiusTokens;
    final textStyles = context.textStyles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + Featured badge
        if (project.title.isNotEmpty)
          Row(
            children: [
              Expanded(
                child: Text(
                  project.title,
                  style: textStyles.titleMediumTextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (project.isFeatured)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.xs,
                    vertical: spacing.xs / 2,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: radius.all4,
                  ),
                  child: Text(
                    'Featured',
                    style: textStyles.labelSmallTextStyle.copyWith(
                      color: colors.onPrimary,
                    ),
                  ),
                ),
            ],
          ),
        if (project.title.isNotEmpty) SizedBox(height: spacing.xs),

        // Description
        if (project.description.isNotEmpty)
          Text(
            project.description,
            style: textStyles.bodySmallTextStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        if (project.description.isNotEmpty) SizedBox(height: spacing.sm),

        // Technologies
        if (project.technologies.isNotEmpty)
          Wrap(
            spacing: spacing.xs,
            runSpacing: spacing.xs,
            children: project.technologies.take(3).map((tech) {
              return Chip(
                label: Text(tech, style: textStyles.labelSmallTextStyle),
                padding: EdgeInsets.zero,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              );
            }).toList(),
          ),
      ],
    );
  }
}

/// Private widget: Edit/Delete actions.
class _ProjectActionsSection extends StatelessWidget {
  const _ProjectActionsSection({required this.onEdit, required this.onDelete});

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.spacingTokens;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onEdit,
            icon: Icon(Icons.edit, size: spacing.md),
            label: const Text('Edit'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: spacing.xs),
            ),
          ),
        ),
        SizedBox(width: spacing.md),
        IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline),
          color: colors.error,
          tooltip: 'Delete',
        ),
      ],
    );
  }
}
