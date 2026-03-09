import 'package:dio/dio.dart';
import 'failures.dart';

sealed class ApiResult<T> {}

class ApiSuccessResult<T> extends ApiResult<T> {
  final T data;

  ApiSuccessResult({required this.data});
}

class ApiErrorResult<T> extends ApiResult<T> {
 // final Failure failure;
 final String failure;

  ApiErrorResult({required this.failure});
}

Future<ApiResult<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
  // final bool isConnected =
  //     await InternetConnectionChecker.instance.hasConnection;
  // if (!isConnected) {
  //   return ApiErrorResult<T>(failure: 'no internet innn'
  //  // Failure(errorMessage: 'no internet')
  //   );
  // }

  try {
    final result = await apiCall();
    return ApiSuccessResult<T>(data: result);
  } on DioException catch (dioError) {
     print("REAL ERROR => ${dioError.error}");
    print("TYPE => ${dioError.type}");
    return ApiErrorResult<T>(
      failure: dioError.error?.toString() ?? dioError.message ?? "Dio error"
      // ServerFailure.fromDioError(dioException: dioError),
    );
  } catch (error) {
    return ApiErrorResult<T>(failure:error.toString()
    // Failure(errorMessage: error.toString())
    );
  }
}

// Future<ApiResult<T>> safeLocalCall<T>(Future<T> Function() localCall) async {
//   try {
//     final result = await localCall();
//     return ApiSuccessResult<T>(data: result);
//   } catch (error) {
//     return ApiErrorResult<T>(failure: Failure(errorMessage: error.toString()));
//   }
//}
