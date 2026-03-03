import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/user_register_entity.dart';

abstract interface class RegisterRepo {
  Future<ApiResult<UserEntity>> registerUser(
    RegisterRequestEntity requestEntity,
  );
}
