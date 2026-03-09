class LinkedinPostEntity {
  final String jobTitle;
  final String companyName;
  final List<String> requiredSkills;
  final List<String>? preferredSkills;
  final String experienceYears;
  final List<String>? educationRequired;
  final List<String>? languagesRequired;
  final String jobDescription;
  final String postUrl;
  final String? hrEmail;

  const LinkedinPostEntity({
    required this.jobTitle,
    required this.companyName,
    required this.requiredSkills,
    this.preferredSkills,
    required this.experienceYears,
    this.educationRequired,
    this.languagesRequired,
    required this.jobDescription,
    required this.postUrl,
    this.hrEmail,
  });
}
