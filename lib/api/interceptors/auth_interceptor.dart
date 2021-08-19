import 'package:dio/dio.dart';

import '../../utils/api_routes.dart';
import '../../utils/preferences.dart';

class AuthInterceptor extends Interceptor {
  late Preference myPrefs;

  // @override
  // Future onRequest(RequestOptions options) async {
  //   myPrefs = Preference();
  //   final token = await myPrefs.getJwt();
  //   options.headers['Authorization'] = 'Bearer $token';
  //   return super.onRequest(options);
  //   //return super.onRequest(options);
  // }

  @override
  Future onError(DioError error, ErrorInterceptorHandler) async {
    print('in error: ${error.message} ${error.error.toString()}');
    // ignore: unrelated_type_equality_checks
    if (error.runtimeType == 'String') {
      print(error);
      return error;
    }
    if (error.response != null) {
      var responseObject = new Map<String, dynamic>.from(error.response?.data);

      //TODO: CHECK CONDITIONS
      if (error.response?.statusCode == 401 &&
          responseObject['subCode'] == 601) {
        var data = await _refreshToken(error);
        return data;
      }
    }

    return super.onError;
  }

  // Future<void> _refreshToken(error) async {
  Future<Response<dynamic>> _refreshToken(error) async {
    var token = await myPrefs.getJwt();
    final response =
        await Dio().post(ApiRoutes.refreshToken, data: {'token': token});
    Dio().interceptors.responseLock.lock();
    if (response.statusCode == 200) {
      final jsonObject = Map<String, dynamic>.from(response.data);
      final jwt = jsonObject['data']
          ['access_token']; // get new refresh token from response
      await myPrefs.setJWT(jwt);
      error.request.headers['Authorization'] = 'Bearer $jwt';
      // make another request with new token and return data
      var request = Dio().request(error.request.baseUrl + error.request.path,
          options: error.request);
      return request;
    }
    var request = Dio().request(error.request.baseUrl + error.request.path,
        options: error.request);
    return request;
  }
}
