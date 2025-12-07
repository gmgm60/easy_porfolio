/// Model for project form data
class ProjectFormModel {
  final String title;
  final String description;
  final String liveDemoUrl;
  final String repositoryUrl;
  final String technologies;
  final bool isFeatured;

  const ProjectFormModel({
    this.title = '',
    this.description = '',
    this.liveDemoUrl = '',
    this.repositoryUrl = '',
    this.technologies = '',
    this.isFeatured = false,
  });

  ProjectFormModel copyWith({
    String? title,
    String? description,
    String? liveDemoUrl,
    String? repositoryUrl,
    String? technologies,
    bool? isFeatured,
  }) {
    return ProjectFormModel(
      title: title ?? this.title,
      description: description ?? this.description,
      liveDemoUrl: liveDemoUrl ?? this.liveDemoUrl,
      repositoryUrl: repositoryUrl ?? this.repositoryUrl,
      technologies: technologies ?? this.technologies,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}

