import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_porfolio/features/admin_projects/data/datasources/admin_projects_local_datasource.dart';
import 'package:easy_porfolio/features/admin_projects/data/repositories/admin_projects_repository_impl.dart';
import 'package:easy_porfolio/features/admin_projects/domain/repositories/admin_projects_repository.dart';
import 'package:easy_porfolio/features/admin_projects/domain/usecases/get_projects.dart';
import 'package:easy_porfolio/features/admin_projects/domain/usecases/get_project_by_id.dart';
import 'package:easy_porfolio/features/admin_projects/domain/usecases/create_project.dart';
import 'package:easy_porfolio/features/admin_projects/domain/usecases/update_project.dart';
import 'package:easy_porfolio/features/admin_projects/domain/usecases/delete_project.dart';

/// Provider for SharedPreferences instance.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

/// Provider for local data source.
final adminProjectsLocalDataSourceProvider =
    Provider<AdminProjectsLocalDataSource>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AdminProjectsLocalDataSourceImpl(prefs: prefs);
});

/// Provider for repository.
final adminProjectsRepositoryProvider =
    Provider<AdminProjectsRepository>((ref) {
  final localDataSource = ref.watch(adminProjectsLocalDataSourceProvider);
  return AdminProjectsRepositoryImpl(localDataSource: localDataSource);
});

/// Provider for use cases.
final getProjectsUseCaseProvider = Provider<GetProjects>((ref) {
  final repository = ref.watch(adminProjectsRepositoryProvider);
  return GetProjects(repository);
});

final getProjectByIdUseCaseProvider = Provider<GetProjectById>((ref) {
  final repository = ref.watch(adminProjectsRepositoryProvider);
  return GetProjectById(repository);
});

final createProjectUseCaseProvider = Provider<CreateProject>((ref) {
  final repository = ref.watch(adminProjectsRepositoryProvider);
  return CreateProject(repository);
});

final updateProjectUseCaseProvider = Provider<UpdateProject>((ref) {
  final repository = ref.watch(adminProjectsRepositoryProvider);
  return UpdateProject(repository);
});

final deleteProjectUseCaseProvider = Provider<DeleteProject>((ref) {
  final repository = ref.watch(adminProjectsRepositoryProvider);
  return DeleteProject(repository);
});


