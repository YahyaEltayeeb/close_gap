abstract class NetworkConstants {
  static const String baseUrl = "https://mmm.nexxuus.site/";
  static const String authorization = 'Authorization';
  static const String bearer = "Bearer";
}

abstract class EndPoints {
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String universities = "academic/universities";
  static const String faculties = "academic/faculties";
  static const String departments = "academic/departments";
  static const String tracks = "academic/jobtrack/list";
  static const String availableSemesters = "academic/available_semesters";
  static const String cvCoash = "api/analyze_cv/";
  static const String getGobs = "https://nexusporject.runasp.net/LinkedIn/GetJobs";
  static const String getLinkedinPosts =
      "https://nexusporject.runasp.net/LinkedIn/GetPosts";
}
