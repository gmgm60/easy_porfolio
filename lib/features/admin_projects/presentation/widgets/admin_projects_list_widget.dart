import 'package:easy_porfolio/core/theme/spacing_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/utils/responsive_util.dart';
import 'package:easy_porfolio/features/admin_projects/domain/entities/admin_project.dart';
import 'package:easy_porfolio/features/admin_projects/presentation/widgets/admin_project_card_widget.dart';

/// Widget for displaying projects in a responsive list/grid.
class AdminProjectsListWidget extends ConsumerWidget {
  const AdminProjectsListWidget({
    super.key,
    required this.projects,
    required this.onProjectTap,
    required this.onEdit,
    required this.onDelete,
  });

  final List<AdminProject> projects;
  final Function(AdminProject) onProjectTap;
  final Function(AdminProject) onEdit;
  final Function(AdminProject) onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacing = context.spacingTokens;
    final isMobile = ResponsiveUtil.isMobile(context);
    final isTablet = ResponsiveUtil.isTablet(context);

    if (projects.isEmpty) {
      return _EmptyProjectFallback(spacing: spacing);
    }

    // Determine cross axis count based on screen size
    int crossAxisCount = 1;
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 3;
    }

    return GridView.builder(
      padding: EdgeInsets.all(spacing.md),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing.md,
        mainAxisSpacing: spacing.md,
        childAspectRatio: 0.8,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return AdminProjectCardWidget(
          project: project,
          onTap: () => onProjectTap(project),
          onEdit: () => onEdit(project),
          onDelete: () => onDelete(project),
        );
      },
    );
  }
}

class _EmptyProjectFallback extends StatelessWidget {
  const _EmptyProjectFallback({
    super.key,
    required this.spacing,
  });

  final SpacingTokens spacing;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: context.spacingTokens.lg * 2.5,
            color: context.appColors.textMuted,
          ),
          SizedBox(height: spacing.md),
          Text(
            'No projects yet',
            style: context.textStyles.titleMediumTextStyle.copyWith(
              color: context.appColors.textMuted,
            ),
          ),
          SizedBox(height: spacing.xs),
          Text(
            'Create your first project to get started',
            style: context.textStyles.bodySmallTextStyle.copyWith(
              color: context.appColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

