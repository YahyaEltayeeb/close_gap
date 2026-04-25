import 'package:close_gap/features/academic_course/data/models/request/submission_exam_request.dart';
import 'package:close_gap/features/academic_course/data/models/response/academic_course_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/academic_exam_results_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/explanation_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/publish_exam_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/start_exam_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/submission_exam_response_dto.dart';
import 'package:close_gap/features/get_jobs/data/models/response_get_jobs_model_dto.dart';
import 'package:close_gap/features/get_linkedin_posts/data/models/response_linkedin_posts_model_dto.dart';
import 'package:close_gap/features/chatbot/data/model/request/chatbot_request_dto.dart';
import 'package:close_gap/features/chatbot/data/model/response/chatbot_response_dto.dart';
import 'package:close_gap/features/assessment/data/model/request/exam_answer_request.dart';
import 'package:close_gap/features/assessment/data/model/request/exam_finish_request.dart';
import 'package:close_gap/features/assessment/data/model/request/start_exam_request.dart';
import 'package:close_gap/features/assessment/data/model/response/exam_answer_response.dart';
import 'package:close_gap/features/assessment/data/model/response/exam_finish_response.dart';
import 'package:close_gap/features/assessment/data/model/response/exam_questions_response.dart';
import 'package:close_gap/features/assessment/data/model/response/start_exam_response.dart';
import 'package:close_gap/features/exam_monitoring/data/models/request/vision_check_camera_request.dart';
import 'package:close_gap/features/exam_monitoring/data/models/response/vision_check_camera_response.dart';
import 'package:close_gap/features/generate_cv/data/model/request/generate_cv_request_dto.dart';
import 'package:close_gap/features/learning/advanced_plan/data/models/request/advanced_learning_plan_request_dto.dart';
import 'package:close_gap/features/learning/advanced_plan/data/models/response/advanced_learning_plan_response_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/request/add_exam_question_request_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/request/create_exam_request_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/academic_course_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/add_exam_question_response_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/create_exam_response_dto.dart';
import 'package:close_gap/features/certificates/data/model/request/create_certificate_request_dto.dart';
import 'package:close_gap/features/experience/data/model/request/experience_request_dto.dart';
import 'package:close_gap/features/projects/data/model/request/create_project_request_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/request/grade_submission_answer_request_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_question_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_results_response_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_submissions_response_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_list_item_dto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:close_gap/core/network/network_constants.dart';
import 'package:close_gap/features/auth/login/data/model/request/login_request_dto.dart';
import 'package:close_gap/features/auth/login/data/model/response/login_response_dto.dart';
import 'package:close_gap/features/auth/register/data/model/request/register_request_dto.dart';
import 'package:close_gap/features/auth/register/data/model/request/profile_setup_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/academic_lookup_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/register_response_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/semester_lookup_dto.dart';
import 'package:close_gap/features/cv_coach/data/models/response/cv_analysis_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;
  @POST(EndPoints.register)
  Future<RegisterResponseDto> registerUser(
    @Body() RegisterRequestDto requestDto,
  );

  @POST(EndPoints.login)
  Future<LoginResponseDto> loginUser(@Body() LoginRequestDto loginRequestDto);

  @POST(EndPoints.profileSetup)
  Future<dynamic> setupProfile(@Body() ProfileSetupDto requestDto);

  @GET(EndPoints.universities)
  Future<List<AcademicLookupDto>> getUniversities();

  @GET('${EndPoints.faculties}/{universityId}')
  Future<List<AcademicLookupDto>> getFaculties(
    @Path('universityId') int universityId,
  );

  @GET('${EndPoints.departments}/{facultyId}')
  Future<List<AcademicLookupDto>> getDepartments(
    @Path('facultyId') int facultyId,
  );

  @GET(EndPoints.tracks)
  Future<List<AcademicLookupDto>> getTracks();

  @GET('${EndPoints.availableSemesters}/{departmentId}')
  Future<List<SemesterLookupDto>> getAvailableSemesters(
    @Path('departmentId') int departmentId,
  );

  @GET(EndPoints.academicCoursesY)
  Future<List<TeacherAcademicCourseDto>> getTeacherAcademicCourses();

  @POST(EndPoints.createAcademicExam)
  Future<CreateExamResponseDto> createAcademicExam(
    @Body() CreateExamRequestDto requestDto,
  );

  @POST(EndPoints.addAcademicExamQuestion)
  Future<AddExamQuestionResponseDto> addAcademicExamQuestion(
    @Path('examId') int examId,
    @Body() AddExamQuestionRequestDto requestDto,
  );

  @POST(EndPoints.publishAcademicExam)
  Future<CreateExamResponseDto> publishAcademicExam(@Path('examId') int examId);

  @GET(EndPoints.myAcademicExams)
  Future<List<TeacherExamListItemDto>> getMyAcademicExams();

  @GET(EndPoints.academicExamQuestions)
  Future<List<TeacherExamQuestionDto>> getAcademicExamQuestions(
    @Path('examId') int examId,
  );

  @GET(EndPoints.academicExamResults)
  Future<TeacherExamResultsResponseDto> getAcademicExamResults(
    @Path('examId') int examId,
  );

  @GET(EndPoints.academicExamSubmissions)
  Future<TeacherExamSubmissionsResponseDto> getAcademicExamSubmissions(
    @Path('examId') int examId,
    @Query('page') int page,
    @Query('per_page') int perPage,
  );

  @POST(EndPoints.gradeAcademicExamAnswer)
  Future<void> gradeAcademicExamAnswer(
    @Path('answerId') int answerId,
    @Body() GradeSubmissionAnswerRequestDto requestDto,
  );

  @GET(EndPoints.projects)
  Future<dynamic> getProjects();

  @GET(EndPoints.suggestedProjects)
  Future<dynamic> getSuggestedProjects();

  @GET(EndPoints.skills)
  Future<dynamic> getSkills();

  @POST(EndPoints.projects)
  Future<void> createProject(@Body() CreateProjectRequestDto requestDto);

  @DELETE(EndPoints.projectById)
  Future<void> deleteProject(@Path('projectId') int projectId);

  @GET(EndPoints.experiences)
  Future<dynamic> getExperiences();

  @POST(EndPoints.experiences)
  Future<void> createExperience(@Body() ExperienceRequestDto requestDto);

  @PUT(EndPoints.experienceById)
  Future<void> updateExperience(
    @Path('expId') int experienceId,
    @Body() ExperienceRequestDto requestDto,
  );

  @DELETE(EndPoints.experienceById)
  Future<void> deleteExperience(@Path('expId') int experienceId);

  @GET(EndPoints.certificates)
  Future<dynamic> getCertificates();

  @POST(EndPoints.addCertificate)
  Future<void> createCertificate(
    @Body() CreateCertificateRequestDto requestDto,
  );

  @POST(EndPoints.cvCoash)
  @MultiPart()
  Future<CvAnalysisResponseDto> cvCoash(@Part(name: "file") MultipartFile file);

  @POST(EndPoints.generateCv)
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> generateCv(
    @Body() GenerateCvRequestDto requestDto,
  );

  @GET(EndPoints.getGobs)
  Future<List<GetJobsModelDto>> getJobs(
    @Path('agent_id') String agentId, {
    @Query('track') String? track,
  });

  @GET(EndPoints.getLinkedinPosts)
  Future<LinkedinPostsResponseDto> getLinkedinPosts(
    @Path('agent_id') String agentId, {
    @Query('track') String? track,
  });

  @POST(EndPoints.chatbot)
  Future<ChatbotResponseDto> sendChatbotMessage(
    @Body() ChatbotRequestDto requestDto,
  );

  @GET(EndPoints.marketTrends)
  Future<dynamic> getMarketTrends(@Query('track_id') int trackId);

  @GET(EndPoints.notifications)
  Future<dynamic> getNotifications({
    @Query('unread_only') bool unreadOnly = false,
    @Query('limit') int limit = 20,
    @Query('page') int page = 1,
  });

  @GET(EndPoints.notificationsUnreadCount)
  Future<dynamic> getNotificationsUnreadCount();

  @PATCH(EndPoints.notificationReadById)
  Future<void> markNotificationAsRead(@Path('notifId') int notificationId);

  @PATCH(EndPoints.notificationsReadAll)
  Future<void> markAllNotificationsAsRead();

  @DELETE(EndPoints.notificationById)
  Future<void> deleteNotification(@Path('notifId') int notificationId);

  @DELETE(EndPoints.notificationsClearAll)
  Future<void> clearAllNotifications();

  @POST(EndPoints.examstart)
  Future<StartexamResponse> startExam(
    @Body() StartExamRequest startExamRequest,
  );
  @POST(EndPoints.examfinish)
  Future<ExamFinishResponse> finishExam(
    @Body() ExamFinishRequest examFinishRequest,
  );
  @POST(EndPoints.examanswer)
  Future<ExamAnswerResponse> answerExam(
    @Body() ExamAnswerRequest examAnswerRequest,
  );
  @GET(EndPoints.examquestions)
  Future<ExamquestionsResponse> getExamQuestions(
    @Path('track') String track, {
    @Query('level') String? level,
    @Query('page') int? page,
    @Query('per_page') int? perPage,
  });
  @POST(EndPoints.visionCheck)
  Future<VisionCheckCameraResponse> visionCheck(
    @Body() VisionCheckCameraRequest visionCheckCameraRequest,
  );
  @POST(EndPoints.advancedLearningPlan)
  Future<AdvancedLearningPlanResponseDto> getAdvancedLearningPlan(
    @Body() AdvancedLearningPlanRequestDto requestDto,
  );
  @GET(EndPoints.academicCourses)
  Future<List<AcademicCourseDto>> getAcademicCoursesBySemester(
    @Path("semester") int semester,
  );
  @GET(EndPoints.academicExplanation)
  Future<List<ExplanationDto>> getAcademicCourseExplanation(
    @Path("courseId") int courseId,
  );
  @GET(EndPoints.academicpublishedexam)
  Future<List<PublishExamDto>> getAcademicPublishedExam();
  @POST(EndPoints.academicStartExam)
  Future<StartExamDto> startAcademicExam(@Path("exam_id") int examId);
  @POST(EndPoints.academicSubmitExam)
  Future<SubmissionExamResponseDto> submitAcademicExam(
    @Path("exam_id") int examId,
    @Body() SubmissionExamRequest submissionExamRequest,
  );
  @GET(EndPoints.academicExamResult)
  Future<List<AcademicExamResultsDto>> getAcademicExamResult();
}
