import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/admin_projects/domain/entities/admin_project.dart';

/// Repository interface for admin projects management.
/// This defines the contract that data layer implementations must follow.
abstract class AdminProjectsRepository {
  /// Gets all projects.
  Future<AppResult<List<AdminProject>>> getProjects();

  /// Gets a single project by ID.
  Future<AppResult<AdminProject>> getProjectById(String id);

  /// Creates a new project.
  Future<AppResult<AdminProject>> createProject(AdminProject project);

  /// Updates an existing project.
  Future<AppResult<AdminProject>> updateProject(AdminProject project);

  /// Deletes a project by ID.
  Future<AppUnitResult> deleteProject(String id);
}

