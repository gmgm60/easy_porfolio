import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/projects/domain/entities/project.dart';
import 'package:easy_porfolio/features/projects/domain/repositories/projects_repository.dart';

/// Use case for retrieving all projects.
class GetProjects {
  final ProjectsRepository _repository;

  const GetProjects(this._repository);

  AppAsyncResult<List<Project>> call() {
    return _repository.getProjects();
  }
}
