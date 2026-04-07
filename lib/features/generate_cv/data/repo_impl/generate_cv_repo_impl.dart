import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/generate_cv/data/data_sorce/generate_cv_data_sorce.dart';
import 'package:close_gap/features/generate_cv/domain/repo/generate_cv_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: GenerateCvRepo)
class GenerateCvRepoImpl implements GenerateCvRepo {
  final GenerateCvDataSource generateCvDataSource;

  GenerateCvRepoImpl(this.generateCvDataSource);

  @override
  Future<ApiResult<List<int>>> generateCv() async {
    return generateCvDataSource.generateCv();
  }
}