import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_porfolio/features/projects/domain/entities/project.dart';
import 'package:easy_porfolio/features/projects/presentation/providers/projects_providers.dart';

/// State class for projects list.
class ProjectsState {
  final List<Project> projects;
  final bool isLoading;
  final String? error;

  const ProjectsState({
    this.projects = const [],
    this.isLoading = false,
    this.error,
  });

  ProjectsState copyWith({
    List<Project>? projects,
    bool? isLoading,
    String? error,
  }) {
    return ProjectsState(
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier for managing projects state.
class ProjectsNotifier extends Notifier<ProjectsState> {
  @override
  ProjectsState build() {
    Future.microtask(_loadProjects);
    return const ProjectsState();
  }

  Future<void> _loadProjects() async {
    state = state.copyWith(isLoading: true);
    final useCase = ref.read(getProjectsUseCaseProvider);
    final result = await useCase();

    if (!ref.mounted) {
      return;
    }

    result
        .onFailure((failure) {
          state = state.copyWith(isLoading: false, error: failure.message);
        })
        .onSuccess((projects) {
          state = state.copyWith(projects: projects, isLoading: false);
        });
  }

  /// Refreshes the projects list.
  Future<void> refresh() async {
    await _loadProjects();
  }

  /// Deletes a project.
  Future<void> deleteProject(String id) async {
    final useCase = ref.read(deleteProjectUseCaseProvider);
    final result = await useCase(id);

    result
        .onFailure((failure) {
          state = state.copyWith(error: failure.message);
        })
        .onSuccess((_) {
          // Remove from local state
          final updatedProjects = state.projects
              .where((p) => p.id != id)
              .toList();
          state = state.copyWith(projects: updatedProjects);
        });
  }
}

/// Provider for projects state.
final projectsStateProvider = NotifierProvider<ProjectsNotifier, ProjectsState>(
  ProjectsNotifier.new,
);

/// Provider for a single project by ID.
final projectByIdProvider = Provider.autoDispose
    .family<AsyncValue<Project>, String>((ref, id) {
      final useCase = ref.watch(getProjectByIdUseCaseProvider);
      return ref.watch(
        FutureProvider((ref) async {
          final result = await useCase(id);
          return result.getOrThrow();
        }),
      );
    });
