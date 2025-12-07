import 'package:easy_porfolio/features/admin_projects/domain/entities/admin_project.dart';

/// Data model for AdminProject.
/// Extends the domain entity with JSON serialization capabilities.
class AdminProjectModel extends AdminProject {
  const AdminProjectModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    super.isFeatured = false,
    super.screenshots = const [],
    super.technologies = const [],
    super.liveDemoUrl,
    super.repositoryUrl,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Creates an AdminProjectModel from a domain entity.
  factory AdminProjectModel.fromEntity(AdminProject project) {
    return AdminProjectModel(
      id: project.id,
      title: project.title,
      description: project.description,
      imageUrl: project.imageUrl,
      isFeatured: project.isFeatured,
      screenshots: List<String>.from(project.screenshots),
      technologies: List<String>.from(project.technologies),
      liveDemoUrl: project.liveDemoUrl,
      repositoryUrl: project.repositoryUrl,
      createdAt: project.createdAt,
      updatedAt: project.updatedAt,
    );
  }

  /// Creates an AdminProjectModel from JSON.
  factory AdminProjectModel.fromJson(Map<String, dynamic> json) {
    return AdminProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      isFeatured: json['isFeatured'] as bool? ?? false,
      screenshots: (json['screenshots'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      technologies: (json['technologies'] as List<dynamic>?)
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
  @override
  AdminProjectModel copyWith({
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
    return AdminProjectModel(
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



