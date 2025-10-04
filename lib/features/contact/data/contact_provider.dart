
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_porfolio/features/contact/data/models/contact_method.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final getInTouchProvider = Provider<List<ContactMethod>>((ref) {
  return [
    ContactMethod(
      title: 'Email',
      subtitle: 'Send me an email',
      icon: FontAwesomeIcons.solidEnvelope,
      url: 'mailto:ethan.carter@example.com',
    ),
    ContactMethod(
      title: 'Phone',
      subtitle: 'Call me',
      icon: FontAwesomeIcons.phone,
      url: 'tel:+1234567890',
    ),
  ];
});

final socialProvider = Provider<List<ContactMethod>>((ref) {
  return [
    ContactMethod(
      title: 'LinkedIn',
      subtitle: 'Connect with me',
      icon: FontAwesomeIcons.linkedin,
      url: 'https://linkedin.com/in/ethancarter', // Placeholder
    ),
    ContactMethod(
      title: 'GitHub',
      subtitle: 'See my code',
      icon: FontAwesomeIcons.github,
      url: 'https://github.com/ethancarter', // Placeholder
    ),
    ContactMethod(
      title: 'Website',
      subtitle: 'Visit my website',
      icon: FontAwesomeIcons.globe,
      url: 'https://ethancarter.dev', // Placeholder
    ),
  ];
});
