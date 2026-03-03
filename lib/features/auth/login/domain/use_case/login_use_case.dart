import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:close_gap/features/auth/login/domain/entities/user_model_login_entity.dart';
import 'package:close_gap/features/auth/login/domain/repo/login_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class LoginUseCase {
  final LoginRepo _loginRepo;
  LoginUseCase(this._loginRepo);

  Future<ApiResult<UserModelLoginEntity>> call(
    LoginRequestEntity loginRequestEntity,
  ) {
    return _loginRepo.login(loginRequestEntity);
  }
}
