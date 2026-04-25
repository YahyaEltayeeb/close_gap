import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/certificates/domain/entities/certificate_request_entity.dart';
import 'package:close_gap/features/certificates/domain/repo/certificates_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateCertificateUseCase {
  CreateCertificateUseCase(this._certificatesRepo);

  final CertificatesRepo _certificatesRepo;

  Future<ApiResult<void>> call(CertificateRequestEntity requestEntity) {
    return _certificatesRepo.createCertificate(requestEntity);
  }
}
