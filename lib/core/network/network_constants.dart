abstract class NetworkConstants {
  static const String baseUrl = "https://mmm.nexxuus.site/";
  static const String authorization = 'Authorization';
  static const String bearer = "Bearer";
}

abstract class EndPoints {
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String cvCoash = "api/analyze_cv/";
  static const String generateCv =
      "https://nexusporject.runasp.net/cv/generate-cv";

  static const String getGobs =
      "https://nexusporject.runasp.net/LinkedIn/GetJobs";
  static const String getLinkedinPosts =
      "https://nexusporject.runasp.net/LinkedIn/GetPosts";

  static const String examstart = "exams/start";
  static const String examfinish = "exams/finish";
  static const String examanswer = "exams/answer";
  static const String examquestions = "assessment/questions/frontend";
  static const String visionCheck = "exams/vision-check";
  static const String advancedLearningPlan =
      "https://mmm.nexxuus.site/learning/advanced_plan";
  static const String universities = "academic/universities";
  static const String faculties = "academic/faculties";
  static const String departments = "academic/departments";
  static const String tracks = "academic/jobtrack/list";
  static const String availableSemesters = "academic/available_semesters";
}
