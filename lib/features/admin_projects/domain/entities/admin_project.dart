/// Domain entity representing a project in the admin system.
/// This is the core business object, independent of data sources.
class AdminProject {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final bool isFeatured;
  final List<String> screenshots;
  final List<String> technologies;
  final String? liveDemoUrl;
  final String? repositoryUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdminProject({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.isFeatured = false,
    this.screenshots = const [],
    this.technologies = const [],
    this.liveDemoUrl,
    this.repositoryUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a copy of this project with updated fields.
  AdminProject copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    bool? isFeatured,
    List<String>? screenshots,
    List<String>? technologies,
    String? liveDemoUrl,
    String? repositoryUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdminProject(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isFeatured: isFeatured ?? this.isFeatured,
      screenshots: screenshots ?? this.screenshots,
      technologies: technologies ?? this.technologies,
      liveDemoUrl: liveDemoUrl ?? this.liveDemoUrl,
      repositoryUrl: repositoryUrl ?? this.repositoryUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}



