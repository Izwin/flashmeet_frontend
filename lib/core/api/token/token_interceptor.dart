import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  int retryCount = 0;
  final int maxRetry = 3;

  TokenInterceptor({required this.dio});

  @override
  Future<void> onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        String? token = await user.getIdToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      }
      handler.next(options);
    }
    catch (e) {
      handler.reject(DioException(requestOptions: options));
    }
  }

  @override
  Future<void> onError(DioException err,
      ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && retryCount < maxRetry) {
      retryCount++;
      try {
        User? user = _firebaseAuth.currentUser;
        if (user != null) {
          String? token = await user.getIdToken();
          if (token != null) {
            err.requestOptions.headers['Authorization'] = 'Bearer $token';
          }
          final response = await dio.request(
              err.requestOptions.path, options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers
          ),
              queryParameters: err.requestOptions.queryParameters,
              data: err.requestOptions.data);

          retryCount = 0;
          return handler.resolve(response);
        }
      }
      catch (e){
        retryCount = 0;
      }
    }

    handler.next(err);
  }
}
