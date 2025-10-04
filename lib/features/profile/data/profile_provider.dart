
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_porfolio/features/profile/data/models/profile.dart';
import 'package:easy_porfolio/features/profile/data/models/experience.dart';
import 'package:easy_porfolio/features/profile/data/models/skill.dart';

final profileProvider = Provider<Profile>((ref) {
  return Profile(
    name: 'Ethan Carter',
    title: 'Software Engineer',
    location: 'San Francisco, CA',
    imageUrl: 'https://i.pravatar.cc/300', // Placeholder image
    skills: [
      Skill(name: 'Python'),
      Skill(name: 'JavaScript'),
      Skill(name: 'React'),
      Skill(name: 'Node.js'),
      Skill(name: 'SQL'),
      Skill(name: 'Git'),
    ],
    experiences: [
      Experience(
        company: 'Tech Innovators Inc.',
        position: 'Software Engineer',
        period: '2021 - Present',
      ),
      Experience(
        company: 'Code Crafters LLC',
        position: 'Software Development Intern',
        period: '2020 - 2021',
      ),
    ],
    education: 'University of Technology',
    educationPeriod: '2017 - 2021',
  );
});
