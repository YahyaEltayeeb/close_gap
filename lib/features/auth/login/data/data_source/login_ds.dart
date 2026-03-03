import 'package:close_gap/features/auth/login/data/model/response/login_response_dto.dart';
import 'package:close_gap/features/auth/login/data/model/request/login_request_dto.dart';

abstract interface class LoginDataSource {
  Future<LoginResponseDto> login(LoginRequestDto loginRequestDto);
}
