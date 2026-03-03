import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:close_gap/features/auth/login/data/data_source/login_ds.dart';
import 'package:close_gap/features/auth/login/data/model/mapper/login_mapper.dart';
import 'package:close_gap/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:close_gap/features/auth/login/domain/entities/user_model_login_entity.dart';
import 'package:close_gap/features/auth/login/domain/repo/login_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: LoginRepo)
class LoginRepoImp implements LoginRepo {
  final LoginDataSource _loginDataSource;
  final TokenService _tokenService;
  LoginRepoImp(this._loginDataSource, this._tokenService);
  @override
  Future<ApiResult<UserModelLoginEntity>> login(
    LoginRequestEntity loginRequestEntity,
  ) async {
    return await safeApiCall(() async {
      var result = await _loginDataSource.login(loginRequestEntity.toDto());

      _tokenService.saveToken(result.accessToken);
      return result.user.toEntity();
    });
  }
}
