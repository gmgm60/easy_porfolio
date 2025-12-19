import 'package:easy_porfolio/features/projects/domain/entities/project.dart';
import 'package:easy_porfolio/features/projects/data/models/project_model.dart';

/// Mapper for converting between Project entity and ProjectModel.
class ProjectMapper {
  /// Converts a Project entity to a ProjectModel.
  static ProjectModel toModel(Project entity) {
    return ProjectModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      imageUrl: entity.imageUrl,
      isFeatured: entity.isFeatured,
      screenshots: List<String>.from(entity.screenshots),
      technologies: List<String>.from(entity.technologies),
      liveDemoUrl: entity.liveDemoUrl,
      repositoryUrl: entity.repositoryUrl,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Converts a ProjectModel to a Project entity.
  static Project toEntity(ProjectModel model) {
    return Project(
      id: model.id,
      title: model.title,
      description: model.description,
      imageUrl: model.imageUrl,
      isFeatured: model.isFeatured,
      screenshots: List<String>.from(model.screenshots),
      technologies: List<String>.from(model.technologies),
      liveDemoUrl: model.liveDemoUrl,
      repositoryUrl: model.repositoryUrl,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  /// Converts a list of Project entities to a list of ProjectModels.
  static List<ProjectModel> toModelList(List<Project> entities) {
    return entities.map((entity) => toModel(entity)).toList();
  }

  /// Converts a list of ProjectModels to a list of Project entities.
  static List<Project> toEntityList(List<ProjectModel> models) {
    return models.map((model) => toEntity(model)).toList();
  }
}
