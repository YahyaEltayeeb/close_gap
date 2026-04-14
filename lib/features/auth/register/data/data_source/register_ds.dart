import 'package:close_gap/features/auth/register/data/model/response/academic_lookup_dto.dart';
import 'package:close_gap/features/auth/register/data/model/request/register_request_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/register_response_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/semester_lookup_dto.dart';

abstract interface class RegisterDataSource {
  Future<RegisterResponseDto> registerUser(RegisterRequestDto requestDto);
  Future<List<AcademicLookupDto>> getUniversities();
  Future<List<AcademicLookupDto>> getFaculties(int universityId);
  Future<List<AcademicLookupDto>> getDepartments(int facultyId);
  Future<List<AcademicLookupDto>> getTracks();
  Future<List<SemesterLookupDto>> getAvailableSemesters(int departmentId);
}
