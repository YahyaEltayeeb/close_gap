import 'package:close_gap/features/get_linkedin_posts/data/models/response_linkedin_posts_model_dto.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';

extension LinkedinPostMapper on LinkedinPostDto {
  LinkedinPostEntity toEntity() {
    return LinkedinPostEntity(
      jobTitle: jobTitle,
      companyName: companyName,
      requiredSkills: requiredSkills,
      preferredSkills: preferredSkills,
      experienceYears: experienceYears,
      educationRequired: educationRequired,
      languagesRequired: languagesRequired,
      jobDescription: jobDescription,
      postUrl: postUrl,
      hrEmail: hrEmail,
    );
  }
}
