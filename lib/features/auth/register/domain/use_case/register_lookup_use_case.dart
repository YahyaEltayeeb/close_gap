import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/auth/register/domain/entities/academic_lookup_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/semester_lookup_entity.dart';
import 'package:close_gap/features/auth/register/domain/repo/register_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterLookupUseCase {
  final RegisterRepo _registerRepo;

  RegisterLookupUseCase(this._registerRepo);

  Future<ApiResult<List<AcademicLookupEntity>>> getUniversities() {
    return _registerRepo.getUniversities();
  }

  Future<ApiResult<List<AcademicLookupEntity>>> getFaculties(int universityId) {
    return _registerRepo.getFaculties(universityId);
  }

  Future<ApiResult<List<AcademicLookupEntity>>> getDepartments(int facultyId) {
    return _registerRepo.getDepartments(facultyId);
  }

  Future<ApiResult<List<AcademicLookupEntity>>> getTracks() {
    return _registerRepo.getTracks();
  }

  Future<ApiResult<List<SemesterLookupEntity>>> getAvailableSemesters(
    int departmentId,
  ) {
    return _registerRepo.getAvailableSemesters(departmentId);
  }
}
