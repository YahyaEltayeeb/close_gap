abstract class NetworkConstants {
  static const String baseUrl = "https://mmm.nexxuus.site/";
  static const String authorization = 'Authorization';
  static const String bearer = "Bearer";
}

abstract class EndPoints {
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String cvCoash = "api/analyze_cv/";
  static const String examstart = "exams/start";
  static const String examfinish = "exams/finish";
  static const String examanswer = "exams/answer";
  static const String examquestions = "assessment/questions/Ai";
  static const String visionCheck = "exams/vision-check";
}