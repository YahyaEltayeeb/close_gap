import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/certificates/domain/repo/certificates_repo.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCertificateSkillsUseCase {
  GetCertificateSkillsUseCase(this._certificatesRepo);

  final CertificatesRepo _certificatesRepo;

  Future<ApiResult<List<SkillEntity>>> call() {
    return _certificatesRepo.getSkills();
  }
}
