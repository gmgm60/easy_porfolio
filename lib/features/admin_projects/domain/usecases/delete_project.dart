import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/admin_projects/domain/repositories/admin_projects_repository.dart';

/// Use case for deleting a project.
class DeleteProject {
  final AdminProjectsRepository _repository;

  const DeleteProject(this._repository);

  Future<AppUnitResult> call(String id) {
    return _repository.deleteProject(id);
  }
}

