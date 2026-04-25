import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/certificates/domain/entities/course_option_entity.dart';
import 'package:close_gap/features/certificates/domain/repo/certificates_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCertificateCoursesUseCase {
  GetCertificateCoursesUseCase(this._certificatesRepo);

  final CertificatesRepo _certificatesRepo;

  Future<ApiResult<List<CourseOptionEntity>>> call() {
    return _certificatesRepo.getCourses();
  }
}
