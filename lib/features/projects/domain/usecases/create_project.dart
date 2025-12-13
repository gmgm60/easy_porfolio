import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/projects/domain/entities/project.dart';
import 'package:easy_porfolio/features/projects/domain/repositories/projects_repository.dart';

/// Use case for creating a new project.
class CreateProject {
  final ProjectsRepository _repository;

  const CreateProject(this._repository);

  AppAsyncResult<Project> call(Project project) {
    return _repository.createProject(project);
  }
}
