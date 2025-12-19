import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/projects/domain/entities/project.dart';
import 'package:easy_porfolio/features/projects/domain/repositories/projects_repository.dart';

/// Use case for updating an existing project.
class UpdateProject {
  final ProjectsRepository _repository;

  const UpdateProject(this._repository);

  AppAsyncResult<Project> call(Project project) {
    return _repository.updateProject(project);
  }
}
