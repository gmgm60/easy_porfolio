import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_porfolio/features/projects/data/datasources/projects_local_datasource.dart';
import 'package:easy_porfolio/features/projects/data/repositories/projects_repository_impl.dart';
import 'package:easy_porfolio/features/projects/domain/repositories/projects_repository.dart';
import 'package:easy_porfolio/features/projects/domain/usecases/get_projects.dart';
import 'package:easy_porfolio/features/projects/domain/usecases/get_project_by_id.dart';
import 'package:easy_porfolio/features/projects/domain/usecases/create_project.dart';
import 'package:easy_porfolio/features/projects/domain/usecases/update_project.dart';
import 'package:easy_porfolio/features/projects/domain/usecases/delete_project.dart';

/// Provider for SharedPreferences instance.
/// This should be overridden in the app initialization.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

/// Provider for local data source.
final projectsLocalDataSourceProvider = Provider<ProjectsLocalDataSource>((
  ref,
) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ProjectsLocalDataSourceImpl(prefs: prefs);
});

/// Provider for repository.
final projectsRepositoryProvider = Provider<ProjectsRepository>((ref) {
  final localDataSource = ref.watch(projectsLocalDataSourceProvider);
  return ProjectsRepositoryImpl(localDataSource: localDataSource);
});

/// Provider for use cases.
final getProjectsUseCaseProvider = Provider<GetProjects>((ref) {
  final repository = ref.watch(projectsRepositoryProvider);
  return GetProjects(repository);
});

final getProjectByIdUseCaseProvider = Provider<GetProjectById>((ref) {
  final repository = ref.watch(projectsRepositoryProvider);
  return GetProjectById(repository);
});

final createProjectUseCaseProvider = Provider<CreateProject>((ref) {
  final repository = ref.watch(projectsRepositoryProvider);
  return CreateProject(repository);
});

final updateProjectUseCaseProvider = Provider<UpdateProject>((ref) {
  final repository = ref.watch(projectsRepositoryProvider);
  return UpdateProject(repository);
});

final deleteProjectUseCaseProvider = Provider<DeleteProject>((ref) {
  final repository = ref.watch(projectsRepositoryProvider);
  return DeleteProject(repository);
});
