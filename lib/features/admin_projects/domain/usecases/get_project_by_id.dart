import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/admin_projects/domain/entities/admin_project.dart';
import 'package:easy_porfolio/features/admin_projects/domain/repositories/admin_projects_repository.dart';

/// Use case for retrieving a single project by ID.
class GetProjectById {
  final AdminProjectsRepository _repository;

  const GetProjectById(this._repository);

  Future<AppResult<AdminProject>> call(String id) {
    return _repository.getProjectById(id);
  }
}

