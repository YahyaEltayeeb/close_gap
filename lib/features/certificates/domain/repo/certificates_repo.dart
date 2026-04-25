import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/certificates/domain/entities/certificate_item.dart';
import 'package:close_gap/features/certificates/domain/entities/certificate_request_entity.dart';
import 'package:close_gap/features/certificates/domain/entities/course_option_entity.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';

abstract class CertificatesRepo {
  Future<ApiResult<List<CertificateItem>>> getCertificates();

  Future<ApiResult<void>> createCertificate(
    CertificateRequestEntity requestEntity,
  );

  Future<ApiResult<List<SkillEntity>>> getSkills();

  Future<ApiResult<List<CourseOptionEntity>>> getCourses();
}
