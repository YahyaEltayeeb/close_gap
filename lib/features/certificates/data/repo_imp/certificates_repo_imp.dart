import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/certificates/data/data_source/certificates_ds.dart';
import 'package:close_gap/features/certificates/data/model/mapper/certificates_mapper.dart';
import 'package:close_gap/features/certificates/domain/entities/certificate_item.dart';
import 'package:close_gap/features/certificates/domain/entities/certificate_request_entity.dart';
import 'package:close_gap/features/certificates/domain/entities/course_option_entity.dart';
import 'package:close_gap/features/certificates/domain/repo/certificates_repo.dart';
import 'package:close_gap/features/projects/data/model/mapper/projects_mapper.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CertificatesRepo)
class CertificatesRepoImp implements CertificatesRepo {
  CertificatesRepoImp(this._certificatesDs);

  final CertificatesDs _certificatesDs;

  @override
  Future<ApiResult<void>> createCertificate(
    CertificateRequestEntity requestEntity,
  ) {
    return safeApiCall(
      () => _certificatesDs.createCertificate(requestEntity.toDto()),
    );
  }

  @override
  Future<ApiResult<List<CertificateItem>>> getCertificates() {
    return safeApiCall(() async {
      final result = await _certificatesDs.getCertificates();
      return result.map((item) => item.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<CourseOptionEntity>>> getCourses() {
    return safeApiCall(() async {
      final result = await _certificatesDs.getCourses();
      return result.map((item) => item.toCourseEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<SkillEntity>>> getSkills() {
    return safeApiCall(() async {
      final result = await _certificatesDs.getSkills();
      return result.map((item) => item.toEntity()).toList();
    });
  }
}
