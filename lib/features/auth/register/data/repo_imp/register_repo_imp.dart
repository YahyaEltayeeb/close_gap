import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/auth/register/data/data_source/register_ds.dart';
import 'package:close_gap/features/auth/register/data/model/register_mapper.dart';
import 'package:close_gap/features/auth/register/domain/entities/academic_lookup_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/semester_lookup_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/user_register_entity.dart';
import 'package:close_gap/features/auth/register/domain/repo/register_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRepo)
class RegisterRepoImp implements RegisterRepo {
  final RegisterDataSource _registerDataSource;
  RegisterRepoImp(this._registerDataSource);
  @override
  Future<ApiResult<UserEntity>> registerUser(
    RegisterRequestEntity requestEntity,
  ) async {
    return await safeApiCall(() async {
      var result = await _registerDataSource.registerUser(
        requestEntity.toDto(),
      );

      return result.toEntity();
    });
  }

  @override
  Future<ApiResult<List<AcademicLookupEntity>>> getUniversities() async {
    return safeApiCall(() async {
      final result = await _registerDataSource.getUniversities();
      return result.map((item) => item.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<AcademicLookupEntity>>> getFaculties(
    int universityId,
  ) async {
    return safeApiCall(() async {
      final result = await _registerDataSource.getFaculties(universityId);
      return result.map((item) => item.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<AcademicLookupEntity>>> getDepartments(
    int facultyId,
  ) async {
    return safeApiCall(() async {
      final result = await _registerDataSource.getDepartments(facultyId);
      return result.map((item) => item.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<AcademicLookupEntity>>> getTracks() async {
    return safeApiCall(() async {
      final result = await _registerDataSource.getTracks();
      return result.map((item) => item.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<SemesterLookupEntity>>> getAvailableSemesters(
    int departmentId,
  ) async {
    return safeApiCall(() async {
      final result = await _registerDataSource.getAvailableSemesters(
        departmentId,
      );
      return result.map((item) => item.toEntity()).toList();
    });
  }
}
