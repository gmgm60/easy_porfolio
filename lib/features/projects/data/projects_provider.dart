
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_porfolio/features/projects/data/models/project.dart';

final projectsProvider = Provider<List<Project>>((ref) {
  return [
    Project(
      id: '1',
      title: 'Urban Oasis',
      description: 'A sustainable housing project in the city center.',
      imageUrl: 'https://picsum.photos/seed/urbanoasis/400/300', // Placeholder
      isFeatured: true,
      screenshots: [],
      technologies: [],
    ),
    Project(
      id: '2',
      title: 'Zen Retreat',
      description: 'A tranquil home designed for relaxation and mindfulness.',
      imageUrl: 'https://picsum.photos/seed/zenretreat/400/300', // Placeholder
      isFeatured: true,
      screenshots: [],
      technologies: [],
    ),
    Project(
      id: '3',
      title: 'Eco-Living',
      description: 'Sustainable and eco-friendly living spaces.',
      imageUrl: 'https://picsum.photos/seed/ecoliving/400/300', // Placeholder
      screenshots: [],
      technologies: [],
    ),
    Project(
      id: '4',
      title: 'Tech Hub',
      description: 'A modern co-working space for tech startups.',
      imageUrl: 'https://picsum.photos/seed/techhub/400/300', // Placeholder
      screenshots: [],
      technologies: [],
    ),
     Project(
      id: '5',
      title: 'Mobile App for Fitness Tracking',
      description: 'A mobile application designed to help users track their fitness activities, set goals, and monitor progress. Built with React Native, it features a user-friendly interface and integrates with various fitness trackers.',
      imageUrl: 'https://picsum.photos/seed/fitnessapp/400/300', // Placeholder
      screenshots: [
        'https://picsum.photos/seed/fitnessapp_shot1/300/600',
        'https://picsum.photos/seed/fitnessapp_shot2/300/600',
        'https://picsum.photos/seed/fitnessapp_shot3/300/600',
      ],
      technologies: ['React Native', 'Redux', 'Firebase', 'Expo'],
      liveDemoUrl: '#',
      repositoryUrl: '#',
    ),
  ];
});

final featuredProjectsProvider = Provider<List<Project>>((ref) {
  final projects = ref.watch(projectsProvider);
  return projects.where((p) => p.isFeatured).toList();
});

final otherProjectsProvider = Provider<List<Project>>((ref) {
  final projects = ref.watch(projectsProvider);
  return projects.where((p) => !p.isFeatured).toList();
});

final projectDetailsProvider = Provider.family<Project?, String>((ref, id) {
   final projects = ref.watch(projectsProvider);
   try {
    return projects.firstWhere((p) => p.id == id);
   } catch (e) {
     return null;
   }
});
