import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/certificates/domain/entities/certificate_item.dart';
import 'package:close_gap/features/certificates/domain/repo/certificates_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCertificatesUseCase {
  GetCertificatesUseCase(this._certificatesRepo);

  final CertificatesRepo _certificatesRepo;

  Future<ApiResult<List<CertificateItem>>> call() {
    return _certificatesRepo.getCertificates();
  }
}
