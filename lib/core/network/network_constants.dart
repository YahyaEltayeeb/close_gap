abstract class NetworkConstants {
  //static const String baseUrl = "https://nexus-generate-cv-and-analysis-cv-evo8oz-79e5af-187-77-71-179.traefik.me/";
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
  static const String examquestions = "assessment/questions/Ai";
  static const String visionCheck = "exams/vision-check";
  static const String advancedLearningPlan =
      "https://mmm.nexxuus.site/learning/advanced_plan";
}
