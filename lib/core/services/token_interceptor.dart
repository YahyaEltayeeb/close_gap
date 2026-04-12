import 'package:close_gap/core/network/network_constants.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../network/network_constants.dart';

@lazySingleton
class TokenInterceptor extends Interceptor {
  final TokenService tokenService;

  TokenInterceptor(this.tokenService);
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? token = await tokenService.getToken();
     
  print('🔑 TOKEN FROM STORAGE: $token'); // ← حطه هنا
  print('🔑 IS TOKEN SAVED: ${tokenService.isTokenSaved}');
    if (token != null) {
      options.headers[NetworkConstants.authorization] =
          "${NetworkConstants.bearer} $token";
    }
    return  handler.next(options);
  }
}
