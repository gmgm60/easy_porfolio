import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_porfolio/features/projects/data/models/project_model.dart';

/// Local data source for projects using SharedPreferences.
abstract class ProjectsLocalDataSource {
  Future<List<ProjectModel>> getProjects();
  Future<ProjectModel?> getProjectById(String id);
  Future<ProjectModel> createProject(ProjectModel project);
  Future<ProjectModel> updateProject(ProjectModel project);
  Future<void> deleteProject(String id);
}

class ProjectsLocalDataSourceImpl implements ProjectsLocalDataSource {
  final SharedPreferences _prefs;
  static const String _projectsKey = 'admin_projects';
  ProjectsLocalDataSourceImpl({required SharedPreferences prefs})
    : _prefs = prefs;

  @override
  Future<List<ProjectModel>> getProjects() async {
    final jsonString = _prefs.getString(_projectsKey);
    if (jsonString == null) {
      return [];
    }

    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList
        .map((json) => ProjectModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ProjectModel?> getProjectById(String id) async {
    final projects = await getProjects();
    try {
      return projects.firstWhere((project) => project.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ProjectModel> createProject(ProjectModel project) async {
    final projects = await getProjects();
    projects.add(project);
    await _saveProjects(projects);
    return project;
  }

  @override
  Future<ProjectModel> updateProject(ProjectModel project) async {
    final projects = await getProjects();
    final index = projects.indexWhere((p) => p.id == project.id);
    if (index == -1) {
      throw Exception('Project not found');
    }
    projects[index] = project;
    await _saveProjects(projects);
    return project;
  }

  @override
  Future<void> deleteProject(String id) async {
    final projects = await getProjects();
    projects.removeWhere((project) => project.id == id);
    await _saveProjects(projects);
  }

  Future<void> _saveProjects(List<ProjectModel> projects) async {
    final jsonList = projects.map((project) => project.toJson()).toList();
    await _prefs.setString(_projectsKey, json.encode(jsonList));
  }
}
