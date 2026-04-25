abstract class NetworkConstants {
  static const String baseUrl = "https://mmm.nexxuus.site/";
  static const String authorization = 'Authorization';
  static const String bearer = "Bearer";
}

abstract class EndPoints {
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String profileSetup = "profiles/setup";
  static const String cvCoash = "https://app2.nexxuus.site/api/analyze_cv/";
  static const String generateCv = "https://app2.nexxuus.site/api/generate_cv/";

  static const String getGobs = "https://app1.nexxuus.site/get-jobs/{agent_id}";
  static const String getLinkedinPosts =
      "https://app1.nexxuus.site/get-posts/{agent_id}";
  static const String chatbot = "https://chat.nexxuus.site/chat";

  static const String examstart = "exams/start";
  static const String examfinish = "exams/finish";
  static const String examanswer = "exams/answer";
  static const String examquestions = "assessment/questions/{track}";
  static const String visionCheck = "exams/vision-check";
  static const String advancedLearningPlan =
      "https://mmm.nexxuus.site/learning/advanced_plan";
  static const String universities = "academic/universities";
  static const String faculties = "academic/faculties";
  static const String departments = "academic/departments";
  static const String tracks = "academic/jobtrack/list";
  static const String availableSemesters = "academic/available_semesters";
  static const String academicCoursesY = "academic/courses/all";
  static const String createAcademicExam = "academic-exams/create";
  static const String addAcademicExamQuestion =
      "academic-exams/{examId}/add-question";
  static const String publishAcademicExam = "academic-exams/{examId}/publish";
  static const String myAcademicExams = "academic-exams/my-exams";
  static const String academicExamQuestions =
      "academic-exams/{examId}/questions";
  static const String academicExamResults = "academic-exams/{examId}/results";
  static const String academicExamSubmissions =
      "academic-exams/{examId}/submissions";
  static const String gradeAcademicExamAnswer =
      "academic-exams/answer/{answerId}/grade";
  static const String projects = "projects/";
  static const String projectById = "projects/{projectId}";
  static const String suggestedProjects = "projects/suggested";
  static const String skills = "skills/";
  static const String experiences = "experience/";
  static const String experienceById = "experience/{expId}";
  static const String certificates = "certificates";
  static const String addCertificate = "certificates/add";
  static const String marketTrends = "market-trends";
  static const String notifications = "notifications";
  static const String notificationsUnreadCount = "notifications/unread-count";
  static const String notificationReadById = "notifications/{notifId}/read";
  static const String notificationsReadAll = "notifications/read-all";
  static const String notificationById = "notifications/{notifId}";
  static const String notificationsClearAll = "notifications/clear-all";
  static const String academicCourses = "academic/courses/semester/{semester}";
  static const String academicExplanation =
      "academic/courses/{courseId}/resources";
  static const String academicpublishedexam = "academic-exams/available";
  static const String academicStartExam = "academic-exams/{exam_id}/start";
  static const String academicSubmitExam = "/academic-exams/{exam_id}/submit";
  static const String academicExamResult = "/academic-exams/my-results";
}
