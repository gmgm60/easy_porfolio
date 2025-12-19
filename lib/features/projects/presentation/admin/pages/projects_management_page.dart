import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/utils/responsive_util.dart';
import 'package:easy_porfolio/core/widgets/fade_scale_animation.dart';
import 'package:easy_porfolio/core/widgets/error_banner_widget.dart';
import 'package:easy_porfolio/core/services/messaging_service/helper_message.dart';
import 'package:easy_porfolio/features/projects/domain/entities/project.dart';
import 'package:easy_porfolio/features/projects/presentation/providers/projects_state_provider.dart';
import 'package:easy_porfolio/features/projects/presentation/providers/projects_providers.dart';
import 'package:easy_porfolio/features/projects/presentation/admin/widgets/projects_list_widget.dart';
import 'package:easy_porfolio/features/projects/presentation/admin/widgets/project_form_widget.dart';
import 'package:easy_porfolio/features/projects/presentation/admin/widgets/delete_project_dialog.dart';

/// Main page for managing projects (admin interface).
class ProjectsManagementPage extends ConsumerStatefulWidget {
  const ProjectsManagementPage({super.key});

  @override
  ConsumerState<ProjectsManagementPage> createState() =>
      _ProjectsManagementPageState();
}

class _ProjectsManagementPageState
    extends ConsumerState<ProjectsManagementPage> {
  bool _showForm = false;
  Project? _editingProject;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(projectsStateProvider);
    final spacing = context.spacingTokens;
    final isMobile = ResponsiveUtil.isMobile(context);

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ProjectsManagementHeader(
                  projectCount: state.projects.length,
                  isFormVisible: _showForm,
                  isMobile: isMobile,
                  onAddPressed: () {
                    setState(() {
                      _showForm = true;
                      _editingProject = null;
                    });
                  },
                  onCancelFormPressed: () {
                    setState(() {
                      _showForm = false;
                      _editingProject = null;
                    });
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(spacing.md),
                    child: _showForm
                        ? _buildForm(context)
                        : _buildProjectsList(context, state),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return ProjectFormWidget(
      key: ValueKey(_editingProject?.id ?? 'new'),
      project: _editingProject,
      onSave: (project, imageBytes, screenshotBytes) async {
        await _handleSave(project, imageBytes, screenshotBytes);
      },
      onCancel: () {
        setState(() {
          _showForm = false;
          _editingProject = null;
        });
      },
    );
  }

  Widget _buildProjectsList(BuildContext context, ProjectsState state) {
    final colors = context.appColors;
    final spacing = context.spacingTokens;

    if (state.isLoading) {
      return Center(child: CircularProgressIndicator(color: colors.primary));
    }

    if (state.error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ErrorBannerWidget(message: state.error!),
              SizedBox(height: spacing.md),
              ElevatedButton(
                onPressed: () {
                  ref.read(projectsStateProvider.notifier).refresh();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return ProjectsListWidget(
      projects: state.projects,
      onProjectTap: (project) {
        context.push('/Projects/${project.id}');
      },
      onEdit: (project) {
        setState(() {
          _showForm = true;
          _editingProject = project;
        });
      },
      onDelete: (project) {
        _showDeleteDialog(project);
      },
    );
  }

  Future<void> _handleSave(
    Project project,
    Uint8List? imageBytes,
    List<Uint8List> screenshotBytes,
  ) async {
    // Project already has base64 strings from form widget, use it directly
    final projectToSave = project;

    final result = _editingProject == null
        ? await ref.read(createProjectUseCaseProvider).call(projectToSave)
        : await ref.read(updateProjectUseCaseProvider).call(projectToSave);

    result
        .onFailure((failure) {
          ToastMessage.failed(
            message: 'Error: ${failure.toString()}',
            ctx: context,
          );
        })
        .onSuccess((_) {
          ToastMessage.success(
            message: _editingProject == null
                ? 'Project created successfully'
                : 'Project updated successfully',
            ctx: context,
          );
          setState(() {
            _showForm = false;
            _editingProject = null;
          });
          ref.read(projectsStateProvider.notifier).refresh();
        });
  }

  Future<void> _showDeleteDialog(Project project) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteProjectDialog(project: project),
    );

    if (confirmed != true) {
      return;
    }

    await ref.read(projectsStateProvider.notifier).deleteProject(project.id);

    if (!mounted) {
      return;
    }

    ToastMessage.success(message: 'Project deleted successfully', ctx: context);
  }
}

/// Header extracted as its own widget
class _ProjectsManagementHeader extends StatelessWidget {
  const _ProjectsManagementHeader({
    required this.projectCount,
    required this.isFormVisible,
    required this.isMobile,
    required this.onAddPressed,
    required this.onCancelFormPressed,
  });

  final int projectCount;
  final bool isFormVisible;
  final bool isMobile;
  final VoidCallback onAddPressed;
  final VoidCallback onCancelFormPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.textStyles;
    final spacing = context.spacingTokens;

    return Container(
      padding: EdgeInsets.all(spacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          bottom: BorderSide(color: colors.textMuted.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Projects', style: textStyles.headlineSmallTextStyle),
                SizedBox(height: spacing.xs),
                Text(
                  '$projectCount ${projectCount == 1 ? 'project' : 'projects'}',
                  style: textStyles.bodySmallTextStyle.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          if (!isFormVisible)
            FadeScaleAnimation(
              child: ElevatedButton.icon(
                onPressed: onAddPressed,
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                    EdgeInsetsGeometry.symmetric(horizontal: 5),
                  ),
                ),
                icon: const Icon(Icons.add),
                label: Text(isMobile ? 'New' : 'New Project'),
              ),
            )
          else
            FadeScaleAnimation(
              child: OutlinedButton.icon(
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                    EdgeInsetsGeometry.symmetric(horizontal: 10),
                  ),
                ),
                onPressed: onCancelFormPressed,
                icon: const Icon(Icons.close),
                label: const Text('Cancel'),
              ),
            ),
        ],
      ),
    );
  }
}
