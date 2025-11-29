import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/features/admin_projects/domain/entities/admin_project.dart';
import 'package:flutter/material.dart';

class DeleteProjectDialog extends StatelessWidget {
  const DeleteProjectDialog({
    super.key,
    required this.project,
  });

  final AdminProject project;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.spacingTokens;
    final radius = context.radiusTokens;
    final textStyles = context.textStyles;

    return AlertDialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: radius.all16,
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(
        horizontal: spacing.lg,
        vertical: spacing.md,
      ),
      actionsPadding: EdgeInsets.fromLTRB(
        spacing.lg,
        0,
        spacing.lg,
        spacing.md,
      ),
      title: Padding(
        padding: EdgeInsets.fromLTRB(
          spacing.lg,
          spacing.lg,
          spacing.lg,
          spacing.sm,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spacing.sm),
              decoration: BoxDecoration(
                color: colors.error.withValues(alpha: 0.08),
                borderRadius: radius.all12,
              ),
              child: Icon(
                Icons.delete_outline,
                color: colors.error,
                size: spacing.lg,
              ),
            ),
            SizedBox(width: spacing.md),
            Expanded(
              child: Text(
                'Delete Project',
                style: textStyles.titleMediumTextStyle,
              ),
            ),
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Are you sure you want to delete "${project.title}"?',
            style: textStyles.bodyMediumTextStyle,
          ),
          SizedBox(height: spacing.sm),
          Text(
            'This action cannot be undone.',
            style: textStyles.bodySmallTextStyle.copyWith(
              color: colors.textMuted,
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: spacing.sm),
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: spacing.sm),
            backgroundColor: colors.error,
            foregroundColor: colors.onError,
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
