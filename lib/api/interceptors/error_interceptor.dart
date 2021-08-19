import 'package:dio/dio.dart';
import '../../utils/api_routes.dart';
import '../../utils/preferences.dart';

class AuthInterceptor extends Interceptor {
  late Preference myPrefs;

  @override
  Future onError(DioError error, ErrorInterceptorHandler) async {
    var responseObject = Map<String, dynamic>.from(error.response?.data);

    //TODO: check this condition wont be the same as yours
    if (error.response?.statusCode == 401 && responseObject['subCode'] == 601) {
      var data = await _refreshToken(error);
      return data;
    }
    return super.onError;
  }

  //Future<void> _refreshToken(error) async {
  Future<Response<dynamic>> _refreshToken(error) async {
    var token = await myPrefs.getJwt();
    var response =
        await Dio().post(ApiRoutes.refreshToken, data: {'token': token});
    Dio().interceptors.responseLock.lock();
    if (response.statusCode == 200) {
      var jsonObject = Map<String, dynamic>.from(response?.data);
      // get new refresh token from response
      var jwt = jsonObject['data']['access_token'];
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
