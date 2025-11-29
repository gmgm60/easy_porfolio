import 'package:result_dart/result_dart.dart';
import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/core/network/failure/app_failure.dart';
import 'package:easy_porfolio/features/admin_projects/domain/entities/admin_project.dart';
import 'package:easy_porfolio/features/admin_projects/domain/repositories/admin_projects_repository.dart';
import 'package:easy_porfolio/features/admin_projects/data/datasources/admin_projects_local_datasource.dart';
import 'package:easy_porfolio/features/admin_projects/data/models/admin_project_model.dart';

/// Implementation of AdminProjectsRepository using local data source.
class AdminProjectsRepositoryImpl implements AdminProjectsRepository {
  final AdminProjectsLocalDataSource _localDataSource;

  AdminProjectsRepositoryImpl({required AdminProjectsLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<AppResult<List<AdminProject>>> getProjects() async {
    try {
      final projects = await _localDataSource.getProjects();
      return Success(projects);
    } catch (e) {
      return Failure(UnknownFailure('Failed to get projects: $e'));
    }
  }

  @override
  Future<AppResult<AdminProject>> getProjectById(String id) async {
    try {
      final project = await _localDataSource.getProjectById(id);
      if (project == null) {
        return Failure(UnknownFailure('Project not found'));
      }
      return Success(project);
    } catch (e) {
      return Failure(UnknownFailure('Failed to get project: $e'));
    }
  }

  @override
  Future<AppResult<AdminProject>> createProject(AdminProject project) async {
    try {
      final model = AdminProjectModel.fromEntity(project);
      final created = await _localDataSource.createProject(model);
      return Success(created);
    } catch (e) {
      return Failure(UnknownFailure('Failed to create project: $e'));
    }
  }

  @override
  Future<AppResult<AdminProject>> updateProject(AdminProject project) async {
    try {
      final model = AdminProjectModel.fromEntity(project);
      final updated = await _localDataSource.updateProject(model);
      return Success(updated);
    } catch (e) {
      return Failure(UnknownFailure('Failed to update project: $e'));
    }
  }

  @override
  Future<AppUnitResult> deleteProject(String id) async {
    try {
      await _localDataSource.deleteProject(id);
      return const Success(unit);
    } catch (e) {
      return Failure(UnknownFailure('Failed to delete project: $e'));
    }
  }
}

