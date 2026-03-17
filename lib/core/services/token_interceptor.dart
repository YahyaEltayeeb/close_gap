import 'package:dio/dio.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:injectable/injectable.dart';
import '../di/di.dart';
import '../network/network_constants.dart';

@injectable
class TokenInterceptor extends Interceptor {
  final TokenService tokenService = getIt.get<TokenService>();
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String token ='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjEiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiaGFzc2FuZmFycmFnIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiaGFzc2FuQGV4YW1wbGUuY29tIiwiZXhwIjoxODAyNDQ5Mzk5LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDoxMjM0LyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjcyOTUvYXBpIn0.pAFTjHaIPOoT0IDR9sMByI0sWe3MZuGPONmAL7EiKgE';
    // await tokenService.getToken();
   // if (token != null) {
      options.headers[NetworkConstants.authorization] =
          "${NetworkConstants.bearer} $token";
  //  }
    return super.onRequest(options, handler);
  }
}
