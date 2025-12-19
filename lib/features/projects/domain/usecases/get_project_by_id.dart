import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/projects/domain/entities/project.dart';
import 'package:easy_porfolio/features/projects/domain/repositories/projects_repository.dart';

/// Use case for retrieving a single project by ID.
class GetProjectById {
  final ProjectsRepository _repository;

  const GetProjectById(this._repository);

  AppAsyncResult<Project> call(String id) {
    return _repository.getProjectById(id);
  }
}
