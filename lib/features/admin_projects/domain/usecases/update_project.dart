import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/admin_projects/domain/entities/admin_project.dart';
import 'package:easy_porfolio/features/admin_projects/domain/repositories/admin_projects_repository.dart';

/// Use case for updating an existing project.
class UpdateProject {
  final AdminProjectsRepository _repository;

  const UpdateProject(this._repository);

  Future<AppResult<AdminProject>> call(AdminProject project) {
    return _repository.updateProject(project);
  }
}

