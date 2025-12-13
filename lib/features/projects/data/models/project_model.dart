/// Data model for Project.
/// Separate class for data layer, independent of domain entity.
class ProjectModel {
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

  const ProjectModel({
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

  /// Creates a ProjectModel from JSON.
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      isFeatured: json['isFeatured'] as bool? ?? false,
      screenshots:
          (json['screenshots'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      technologies:
          (json['technologies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      liveDemoUrl: json['liveDemoUrl'] as String?,
      repositoryUrl: json['repositoryUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the model to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'isFeatured': isFeatured,
      'screenshots': screenshots,
      'technologies': technologies,
      'liveDemoUrl': liveDemoUrl,
      'repositoryUrl': repositoryUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Creates a copy with updated fields.
  ProjectModel copyWith({
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
    return ProjectModel(
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

  /// Creates a ProjectModel for form editing (with empty defaults).
  factory ProjectModel.empty() {
    final now = DateTime.now();
    return ProjectModel(
      id: '',
      title: '',
      description: '',
      imageUrl: '',
      createdAt: now,
      updatedAt: now,
    );
  }
}
