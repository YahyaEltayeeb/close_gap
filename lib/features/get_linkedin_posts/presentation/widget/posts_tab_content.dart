import 'package:close_gap/core/l10n/translations/app_localizations.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/widget/linkedin_post_card.dart';
import 'package:flutter/material.dart';

class PostsTabContent extends StatelessWidget {
  const PostsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    if (_staticPosts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(l10n.noPostsFound, style: theme.textTheme.bodyMedium),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _staticPosts.length,
      itemBuilder: (context, index) => LinkedinPostCard(post: _staticPosts[index]),
    );
  }
}

const List<LinkedinPostEntity> _staticPosts = [
  LinkedinPostEntity(
    jobTitle: 'Flutter Developer',
    companyName: 'Tech Bridge',
    requiredSkills: ['Flutter', 'Dart', 'REST API', 'Firebase', 'Git'],
    preferredSkills: ['Clean Architecture', 'Bloc'],
    experienceYears: '1-3 years',
    educationRequired: ['Computer Science or related field'],
    languagesRequired: ['Arabic', 'English'],
    jobDescription:
        'We are looking for a Flutter developer to build and maintain scalable mobile applications with clean UI and strong API integration.',
    postUrl: 'https://www.linkedin.com/',
    hrEmail: 'hr@techbridge.com',
  ),
  LinkedinPostEntity(
    jobTitle: 'Junior Backend Developer',
    companyName: 'Nile Solutions',
    requiredSkills: ['Node.js', 'Express', 'MongoDB', 'Postman'],
    preferredSkills: ['Docker', 'JWT'],
    experienceYears: '0-2 years',
    educationRequired: ['Software Engineering'],
    languagesRequired: ['English'],
    jobDescription:
        'Join our backend team to help build APIs, manage databases, and support mobile and web products in a fast-paced environment.',
    postUrl: 'https://www.linkedin.com/',
    hrEmail: 'careers@nilesolutions.com',
  ),
  LinkedinPostEntity(
    jobTitle: 'Frontend React Developer',
    companyName: 'Pixel Hub',
    requiredSkills: ['React', 'JavaScript', 'HTML', 'CSS', 'Redux'],
    preferredSkills: ['TypeScript', 'Next.js'],
    experienceYears: '2+ years',
    educationRequired: ['Bachelor degree'],
    languagesRequired: ['Arabic', 'English'],
    jobDescription:
        'Build polished web interfaces, collaborate with designers, and integrate frontend features with backend services.',
    postUrl: 'https://www.linkedin.com/',
    hrEmail: 'jobs@pixelhub.io',
  ),
];
