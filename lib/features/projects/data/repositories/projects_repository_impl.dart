import 'package:result_dart/result_dart.dart';
import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/core/network/failure/app_failure.dart';
import 'package:easy_porfolio/features/projects/domain/entities/project.dart';
import 'package:easy_porfolio/features/projects/domain/repositories/projects_repository.dart';
import 'package:easy_porfolio/features/projects/data/datasources/projects_local_datasource.dart';
import 'package:easy_porfolio/features/projects/data/mappers/project_mapper.dart';

/// Implementation of ProjectsRepository using local data source.
class ProjectsRepositoryImpl implements ProjectsRepository {
  final ProjectsLocalDataSource _localDataSource;

  ProjectsRepositoryImpl({required ProjectsLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  AppAsyncResult<List<Project>> getProjects() async {
    try {
      final models = await _localDataSource.getProjects();
      final entities = ProjectMapper.toEntityList(models);
      return Success(entities);
    } catch (e) {
      return Failure(UnknownFailure('Failed to get projects: $e'));
    }
  }

  @override
  AppAsyncResult<Project> getProjectById(String id) async {
    try {
      final model = await _localDataSource.getProjectById(id);
      if (model == null) {
        return const Failure(UnknownFailure('Project not found'));
      }
      final entity = ProjectMapper.toEntity(model);
      return Success(entity);
    } catch (e) {
      return Failure(UnknownFailure('Failed to get project: $e'));
    }
  }

  @override
  AppAsyncResult<Project> createProject(Project project) async {
    try {
      final model = ProjectMapper.toModel(project);
      final created = await _localDataSource.createProject(model);
      final entity = ProjectMapper.toEntity(created);
      return Success(entity);
    } catch (e) {
      return Failure(UnknownFailure('Failed to create project: $e'));
    }
  }

  @override
  AppAsyncResult<Project> updateProject(Project project) async {
    try {
      final model = ProjectMapper.toModel(project);
      final updated = await _localDataSource.updateProject(model);
      final entity = ProjectMapper.toEntity(updated);
      return Success(entity);
    } catch (e) {
      return Failure(UnknownFailure('Failed to update project: $e'));
    }
  }

  @override
  AppUnitAsyncResult deleteProject(String id) async {
    try {
      await _localDataSource.deleteProject(id);
      return const Success(unit);
    } catch (e) {
      return Failure(UnknownFailure('Failed to delete project: $e'));
    }
  }
}
