import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/auth/register/data/data_source/register_ds.dart';
import 'package:close_gap/features/auth/register/data/model/request/register_request_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/academic_lookup_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/register_response_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/semester_lookup_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterDataSource)
class RegisterDataSourceImp implements RegisterDataSource {
  final ApiServices _apiServices;
  RegisterDataSourceImp(this._apiServices);
  @override
  Future<RegisterResponseDto> registerUser(RegisterRequestDto requestDto) {
    return _apiServices.registerUser(requestDto);
  }

  @override
  Future<List<AcademicLookupDto>> getUniversities() {
    return _apiServices.getUniversities();
  }

  @override
  Future<List<AcademicLookupDto>> getFaculties(int universityId) {
    return _apiServices.getFaculties(universityId);
  }

  @override
  Future<List<AcademicLookupDto>> getDepartments(int facultyId) {
    return _apiServices.getDepartments(facultyId);
  }

  @override
  Future<List<AcademicLookupDto>> getTracks() {
    return _apiServices.getTracks();
  }

  @override
  Future<List<SemesterLookupDto>> getAvailableSemesters(int departmentId) {
    return _apiServices.getAvailableSemesters(departmentId);
  }
}
