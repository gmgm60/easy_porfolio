
class Project {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final bool isFeatured;
  final List<String> screenshots;
  final List<String> technologies;
  final String? liveDemoUrl;
  final String? repositoryUrl;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.isFeatured = false,
    required this.screenshots,
    required this.technologies,
    this.liveDemoUrl,
    this.repositoryUrl,
  });
}
