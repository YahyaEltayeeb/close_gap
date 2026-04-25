import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/generate_cv/domain/entities/generate_cv_request_entity.dart';
import 'package:close_gap/features/generate_cv/domain/repo/generate_cv_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GenerateCvUseCase {
  final GenerateCvRepo repository;

  GenerateCvUseCase(this.repository);

  Future<ApiResult<List<int>>> call(GenerateCvRequestEntity requestEntity) {
    return repository.generateCv(requestEntity);
  }
}
