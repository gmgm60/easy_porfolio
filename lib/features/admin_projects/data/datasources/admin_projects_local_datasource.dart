import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_porfolio/features/admin_projects/data/models/admin_project_model.dart';

/// Local data source for admin projects using SharedPreferences.
abstract class AdminProjectsLocalDataSource {
  Future<List<AdminProjectModel>> getProjects();
  Future<AdminProjectModel?> getProjectById(String id);
  Future<AdminProjectModel> createProject(AdminProjectModel project);
  Future<AdminProjectModel> updateProject(AdminProjectModel project);
  Future<void> deleteProject(String id);
}

class AdminProjectsLocalDataSourceImpl implements AdminProjectsLocalDataSource {
  final SharedPreferences _prefs;
  static const String _projectsKey = 'admin_projects';

  AdminProjectsLocalDataSourceImpl({required SharedPreferences prefs})
      : _prefs = prefs;

  @override
  Future<List<AdminProjectModel>> getProjects() async {
    final jsonString = _prefs.getString(_projectsKey);
    if (jsonString == null) {
      return [];
    }

    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList
        .map((json) => AdminProjectModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<AdminProjectModel?> getProjectById(String id) async {
    final projects = await getProjects();
    try {
      return projects.firstWhere((project) => project.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<AdminProjectModel> createProject(AdminProjectModel project) async {
    final projects = await getProjects();
    projects.add(project);
    await _saveProjects(projects);
    return project;
  }

  @override
  Future<AdminProjectModel> updateProject(AdminProjectModel project) async {
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

  Future<void> _saveProjects(List<AdminProjectModel> projects) async {
    final jsonList = projects.map((project) => project.toJson()).toList();
    await _prefs.setString(_projectsKey, json.encode(jsonList));
  }
}


