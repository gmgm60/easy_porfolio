import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/projects/domain/repositories/projects_repository.dart';

/// Use case for deleting a project.
class DeleteProject {
  final ProjectsRepository _repository;

  const DeleteProject(this._repository);

  AppUnitAsyncResult call(String id) {
    return _repository.deleteProject(id);
  }
}
