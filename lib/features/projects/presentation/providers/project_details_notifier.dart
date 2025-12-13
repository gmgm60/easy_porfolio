import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_porfolio/features/projects/domain/entities/project.dart';
import 'package:easy_porfolio/features/projects/presentation/providers/projects_providers.dart';

/// Notifier for managing a single project's details state.
class ProjectDetailsNotifier extends AsyncNotifier<Project> {
  String? _projectId;

  @override
  Future<Project> build() {

    return _loadProjectInternal(_projectId!);
  }

  /// Internal method to load project by ID.
  Future<Project> _loadProjectInternal(String projectId) async {
    final useCase = ref.read(getProjectByIdUseCaseProvider);
    final result = await useCase.call(projectId);

    return result.fold(
            (project) =>  project,
            (failure) => throw Exception(failure.message));
  }

  /// Loads a project by ID.
  Future<void> loadProject(String projectId) async {
    _projectId = projectId;

    if (projectId.isEmpty) {
      state = AsyncValue.error('Invalid project ID', StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();

    try {
      final project = await _loadProjectInternal(projectId);

      if (!ref.mounted) {
        return;
      }

      state = AsyncValue.data(project);
    } catch (e, stackTrace) {
      if (ref.mounted) {
        state = AsyncValue.error(e, stackTrace);
      }
    }
  }

  /// Refreshes the project data.
  Future<void> refresh() async {
    if (_projectId != null) {
      await loadProject(_projectId!);
    }
  }
}

/// Provider for project details notifier.
final projectDetailsNotifierProvider =
    AsyncNotifierProvider.autoDispose<ProjectDetailsNotifier, Project>(
      ProjectDetailsNotifier.new,
    );
