import 'package:close_gap/core/network/network_constants.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TokenInterceptor extends Interceptor {
  final TokenService tokenService;

  TokenInterceptor(this.tokenService);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final baseHost = Uri.parse(NetworkConstants.baseUrl).host;
    if (options.uri.host != baseHost) {
      return handler.next(options);
    }

    final String? token = await tokenService.getToken();
    if (token != null) {
      options.headers[NetworkConstants.authorization] =
          "${NetworkConstants.bearer} $token";
    }
    return handler.next(options);
  }
}
