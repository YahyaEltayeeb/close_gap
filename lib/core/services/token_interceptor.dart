import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../network/network_constants.dart';

@lazySingleton
class TokenInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers[NetworkConstants.authorization] =
         "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc3NTk5ODQ1MSwianRpIjoiZDJlYmNiMGMtOWMxNy00ODBmLTllMTYtYzA2MmZmOTQzZDgzIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IjEiLCJuYmYiOjE3NzU5OTg0NTEsImNzcmYiOiJjNTVmNDI5NC05MWJjLTQ4NzktYjFkYS1kZjljMmViYjBkYmEiLCJleHAiOjE3NzY2MDMyNTEsInJvbGUiOiJTVFVERU5UIn0.jcJwpk2vAJH6ll5D06Q5BErcNNZzmIHH_Cd9e1nRZ5E";;
    return super.onRequest(options, handler);
  }
}
