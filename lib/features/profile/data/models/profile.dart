
import './experience.dart';
import './skill.dart';

class Profile {
  final String name;
  final String title;
  final String location;
  final String imageUrl;
  final List<Skill> skills;
  final List<Experience> experiences;
  final String education;
  final String educationPeriod;

  Profile({
    required this.name,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.skills,
    required this.experiences,
    required this.education,
    required this.educationPeriod,
  });
}
