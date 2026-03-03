import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:close_gap/features/auth/login/domain/entities/user_model_login_entity.dart';

abstract interface class LoginRepo {
  Future<ApiResult<UserModelLoginEntity>> login(
    LoginRequestEntity loginRequestEntity,
  );
}
