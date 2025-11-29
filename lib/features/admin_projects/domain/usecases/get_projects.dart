import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/admin_projects/domain/entities/admin_project.dart';
import 'package:easy_porfolio/features/admin_projects/domain/repositories/admin_projects_repository.dart';

/// Use case for retrieving all projects.
class GetProjects {
  final AdminProjectsRepository _repository;

  const GetProjects(this._repository);

  Future<AppResult<List<AdminProject>>> call() {
    return _repository.getProjects();
  }
}

