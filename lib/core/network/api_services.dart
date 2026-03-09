import 'package:close_gap/features/get_linkedin_posts/data/models/response_linkedin_posts_model_dto.dart';
import 'package:dio/dio.dart';
import 'package:close_gap/core/network/network_constants.dart';
import 'package:close_gap/features/auth/login/data/model/request/login_request_dto.dart';
import 'package:close_gap/features/auth/login/data/model/response/login_response_dto.dart';
import 'package:close_gap/features/auth/register/data/model/request/register_request_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/register_response_dto.dart';
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

  @POST(EndPoints.cvCoash)
  @MultiPart()
  Future<CvAnalysisResponseDto> cvCoash(@Part(name: "file") MultipartFile file);
@GET(EndPoints.getGobs)
  Future<List<GetJobsModelDto>> getJobs(
    
  );

  @GET(EndPoints.getLinkedinPosts)
  Future<LinkedinPostsResponseDto> getLinkedinPosts();

}
