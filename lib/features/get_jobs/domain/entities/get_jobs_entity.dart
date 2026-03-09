class GetJobEntity {
  final String jobUrl;
  final String jobTitle;
  final String companyUrl;
  final String companyName;
  final String location;
  final bool isRemote;

  const GetJobEntity({
    required this.jobUrl,
    required this.jobTitle,
    required this.companyUrl,
    required this.companyName,
    required this.location,
    required this.isRemote,
  });
}