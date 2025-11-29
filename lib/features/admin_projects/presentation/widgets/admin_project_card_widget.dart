import 'package:easy_porfolio/core/theme/app_colors.dart';
import 'package:easy_porfolio/core/theme/spacing_tokens.dart';
import 'package:flutter/material.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/widgets/custom_animated_card.dart';
import 'package:easy_porfolio/core/widgets/fade_scale_animation.dart';
import 'package:easy_porfolio/features/admin_projects/domain/entities/admin_project.dart';

/// Card widget for displaying a project in the admin list/grid.
class AdminProjectCardWidget extends StatelessWidget {
  const AdminProjectCardWidget({
    super.key,
    required this.project,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final AdminProject project;
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
                _AdminProjectImageSection(project: project),
                SizedBox(height: spacing.sm),
                _AdminProjectInfoSection(project: project),
                SizedBox(height: spacing.sm),
                _AdminProjectActionsSection(
                  onEdit: onEdit,
                  onDelete: onDelete,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Private widget: handles image / thumbnail section only.
class _AdminProjectImageSection extends StatelessWidget {
  const _AdminProjectImageSection({
    required this.project,
  });

  final AdminProject project;

  @override
  Widget build(BuildContext context) {
    final radius = context.radiusTokens;
    final spacing = context.spacingTokens;

    return ClipRRect(
      borderRadius: radius.all12,
      child: AspectRatio(
        aspectRatio: 1.3,
        child: project.imageUrl.isNotEmpty
            ? Image.network(
          project.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const _AdminProjectImagePlaceholder();
          },
        )
            : const _AdminProjectImagePlaceholder(),
      ),
    );
  }
}

/// Private widget: placeholder for broken/missing image.
class _AdminProjectImagePlaceholder extends StatelessWidget {
  const _AdminProjectImagePlaceholder();

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
class _AdminProjectInfoSection extends StatelessWidget {
  const _AdminProjectInfoSection({
    required this.project,
  });

  final AdminProject project;

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
        SizedBox(height: spacing.xs),

        // Description
        Text(
          project.description,
          style: textStyles.bodySmallTextStyle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: spacing.sm),

        // Technologies
        if (project.technologies.isNotEmpty)
          Wrap(
            spacing: spacing.xs,
            runSpacing: spacing.xs,
            children: project.technologies.take(3).map((tech) {
              return Chip(
                label: Text(
                  tech,
                  style: textStyles.labelSmallTextStyle,
                ),
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
class _AdminProjectActionsSection extends StatelessWidget {
  const _AdminProjectActionsSection({
    required this.onEdit,
    required this.onDelete,
  });

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

