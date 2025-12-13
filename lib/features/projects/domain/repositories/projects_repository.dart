import 'package:easy_porfolio/core/network/result/result_types.dart';
import 'package:easy_porfolio/features/projects/domain/entities/project.dart';

/// Repository interface for projects management.
/// This defines the contract that data layer implementations must follow.
abstract class ProjectsRepository {
  /// Gets all projects.
  AppAsyncResult<List<Project>> getProjects();

  /// Gets a single project by ID.
  AppAsyncResult<Project>getProjectById(String id);

  /// Creates a new project.
  AppAsyncResult<Project> createProject(Project project);

  /// Updates an existing project.
  AppAsyncResult<Project> updateProject(Project project);

  /// Deletes a project by ID.
  AppUnitAsyncResult deleteProject(String id);
}
