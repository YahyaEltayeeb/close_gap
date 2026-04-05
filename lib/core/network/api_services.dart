import 'package:close_gap/features/get_jobs/data/models/response_get_jobs_model_dto.dart';
import 'package:close_gap/features/get_linkedin_posts/data/models/response_linkedin_posts_model_dto.dart';
import 'package:dio/dio.dart';
import 'package:close_gap/core/network/network_constants.dart';
import 'package:close_gap/features/auth/login/data/model/request/login_request_dto.dart';
import 'package:close_gap/features/auth/login/data/model/response/login_response_dto.dart';
import 'package:close_gap/features/auth/register/data/model/request/register_request_dto.dart';
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

  @POST(EndPoints.cvCoash)
  @MultiPart()
  Future<CvAnalysisResponseDto> cvCoash(@Part(name: "file") MultipartFile file);

  @GET(EndPoints.getGobs)
  Future<List<GetJobsModelDto>> getJobs();

  @GET(EndPoints.getLinkedinPosts)
  Future<LinkedinPostsResponseDto> getLinkedinPosts();
}
