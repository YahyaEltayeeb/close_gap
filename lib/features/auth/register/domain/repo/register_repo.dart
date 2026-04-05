import 'package:close_gap/features/auth/register/domain/entities/academic_lookup_entity.dart';
import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/semester_lookup_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/user_register_entity.dart';

abstract interface class RegisterRepo {
  Future<ApiResult<UserEntity>> registerUser(
    RegisterRequestEntity requestEntity,
  );
  Future<ApiResult<List<AcademicLookupEntity>>> getUniversities();
  Future<ApiResult<List<AcademicLookupEntity>>> getFaculties(int universityId);
  Future<ApiResult<List<AcademicLookupEntity>>> getDepartments(int facultyId);
  Future<ApiResult<List<AcademicLookupEntity>>> getTracks();
  Future<ApiResult<List<SemesterLookupEntity>>> getAvailableSemesters(
    int departmentId,
  );
}
