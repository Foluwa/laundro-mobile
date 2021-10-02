import 'package:dio/dio.dart';

import '../../utils/api_routes.dart';
import '../../utils/preferences.dart';

class AuthInterceptor extends Interceptor {
  late Preference myPrefs;

  @override
  Future onError(DioError error, ErrorInterceptorHandler) async {
    final responseObject = Map<String, dynamic>.from(error.response?.data);

    //TODO: check this condition wont be the same as yours
    if (error.response?.statusCode == 401 && responseObject['subCode'] == 601) {
      final data = await _refreshToken(error);
      return data;
    }
    return super.onError;
  }

  //Future<void> _refreshToken(error) async {
  Future<Response<dynamic>> _refreshToken(error) async {
    final token = await myPrefs.getJwt();
    final response =
        await Dio().post(ApiRoutes.refreshToken, data: {'token': token});
    Dio().interceptors.responseLock.lock();
    if (response.statusCode == 200) {
      final jsonObject = Map<String, dynamic>.from(response.data);
      // get new refresh token from response
      final jwt = jsonObject['data']['access_token'];
      await myPrefs.setJWT(jwt);
      error.request.headers['Authorization'] = 'Bearer $jwt';
      // make another request with new token and return data
      final request = Dio().request(error.request.baseUrl + error.request.path,
          options: error.request);
      return request;
    }
    final request = Dio().request(error.request.baseUrl + error.request.path,
        options: error.request);
    return request;
  }
}
