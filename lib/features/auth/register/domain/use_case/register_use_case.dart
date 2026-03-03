import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/user_register_entity.dart';
import 'package:close_gap/features/auth/register/domain/repo/register_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final RegisterRepo _registerRepo;
  RegisterUseCase(this._registerRepo);
  Future<ApiResult<UserEntity>> call(
    RegisterRequestEntity requestEntity,
  ) {
    return _registerRepo.registerUser(requestEntity);
  }
}
