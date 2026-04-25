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
    final String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc3NjgwNzQ0MCwianRpIjoiNzdjNTk5NmYtYTI1YS00ZjQwLTllYjYtNmQ3MzM2ZjJhMmRiIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IjEiLCJuYmYiOjE3NzY4MDc0NDAsImNzcmYiOiI3NGZkMTJiMC0yNjE2LTQ4ZTQtYTAxOS1mOTY4NTI0NWQ4NWMiLCJleHAiOjE3Nzc0MTIyNDAsInJvbGUiOiJTVFVERU5UIn0.H4TXV8lJnSN7Z9QTwNnkevtwUT2Y1nwRi48BFhrh0Rw';
    // await tokenService.getToken();

    print('🔑 TOKEN FROM STORAGE: $token'); // ← حطه هنا
    print('🔑 IS TOKEN SAVED: ${tokenService.isTokenSaved}');
    if (token != null) {
      options.headers[NetworkConstants.authorization] =
          "${NetworkConstants.bearer} $token";
    }
    return handler.next(options);
  }
}
