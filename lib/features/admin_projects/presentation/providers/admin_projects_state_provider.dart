import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_porfolio/features/admin_projects/domain/entities/admin_project.dart';
import 'package:easy_porfolio/features/admin_projects/presentation/providers/admin_projects_providers.dart';

/// State class for admin projects list.
class AdminProjectsState {
  final List<AdminProject> projects;
  final bool isLoading;
  final String? error;

  const AdminProjectsState({
    this.projects = const [],
    this.isLoading = false,
    this.error,
  });

  AdminProjectsState copyWith({
    List<AdminProject>? projects,
    bool? isLoading,
    String? error,
  }) {
    return AdminProjectsState(
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier for managing admin projects state.
class AdminProjectsNotifier extends Notifier<AdminProjectsState> {
  @override
  AdminProjectsState build() {
    _loadProjects();
    return const AdminProjectsState();
  }

  Future<void> _loadProjects() async {
    state = state.copyWith(isLoading: true);
    final useCase = ref.read(getProjectsUseCaseProvider);
    final result = await useCase();

    result.onFailure((failure) {
      state = state.copyWith(
        isLoading: false,
        error: failure.toString(),
      );
    }).onSuccess((projects) {
      state = state.copyWith(
        projects: projects,
        isLoading: false,
      );
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

    result.onFailure((failure) {
      state = state.copyWith(error: failure.toString());
    }).onSuccess((_) {
      // Remove from local state
      final updatedProjects = state.projects.where((p) => p.id != id).toList();
      state = state.copyWith(projects: updatedProjects);
    });
  }
}

/// Provider for admin projects state.
final adminProjectsStateProvider =
    NotifierProvider<AdminProjectsNotifier, AdminProjectsState>(
  AdminProjectsNotifier.new,
);

  /// Provider for a single project by ID.
final adminProjectByIdProvider =
    Provider.autoDispose.family<AsyncValue<AdminProject>, String>((ref, id) {
  final useCase = ref.watch(getProjectByIdUseCaseProvider);
  return ref.watch(
    FutureProvider((ref) async {
      final result = await useCase(id);
      return result.getOrThrow();
    }),
  );
});

