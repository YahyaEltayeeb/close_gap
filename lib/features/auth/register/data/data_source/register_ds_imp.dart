import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/auth/register/data/data_source/register_ds.dart';
import 'package:close_gap/features/auth/register/data/model/request/register_request_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/register_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterDataSource)
class RegisterDataSourceImp implements RegisterDataSource {
  final ApiServices _apiServices;
  RegisterDataSourceImp(this._apiServices);
  @override
  Future<RegisterResponseDto> registerUser(RegisterRequestDto requestDto) {
    return _apiServices.registerUser(requestDto);
  }
}
