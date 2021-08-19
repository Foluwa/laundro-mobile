import 'package:dio/dio.dart';

import '../models/currency.dart';
import '../models/user.dart';
import '../utils/api_routes.dart';
import 'Exceptions/dio_exception.dart';
import 'interceptors/auth_interceptor.dart';

class UserApi {
  Dio? _dio;
  bool? addAccessToken;
  UserApi() {
    // print('Access Token $addAccessToken');
    final options = BaseOptions(
      connectTimeout: 100000,
      receiveTimeout: 80000,
    );
    _dio = Dio(options);
    if (addAccessToken != null) {
      print('adding interceptor');
      _dio!.interceptors.add(AuthInterceptor());
    }
  }

  /// Get User Profile
  Future<User> fetchUser() async {
    try {
      ///TODO: Ask isreal how to add access token to request in flutter
      final response = await Dio().get(ApiRoutes.verifyMe);
      // if (response.statusCode == 200) {
      //   // print('Currency ${response.data}');
      //   // print('HERE ${Currency.fromJson(response.data)}');
      //   return Currency.fromJson(response.data);
      // }
      return User.fromJson(response.data);
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw Exception('$errorMessage');
    }
  }

  /// Registration
  Future<User> registerUser(data) async {
    print('REGISTER WAS CALLED $data');
    try {
      print('ATTEMPTING POST');
      final response = await Dio().post(ApiRoutes.register, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('statusCode ${response.statusCode}');
        print('response ${response.data['user']}');

        final String jwt = response.data['jwt'];
        print('JWT $jwt');
        final user = response.data;
        print('USER $user');
        final kk = User.fromJson(user);
        print('KKK $kk');
        return User.fromJson(response.data);
      } else {
        print('RESPONSE ${response.statusCode}');
        return User.fromJson(response.data);
      }
    } on DioError catch (error) {
      print('ERROR WAS KNOCKED! ${error}');
      print('error WAS ! ${error.response}');
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw Exception('$errorMessage');
    }
  }

  /// Authentication
  Future<User> authenticateUser(data) async {
    try {
      final response = await Dio().post(ApiRoutes.login, data: data);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      print('statusCode ${response.statusCode}');
      print('response ${response.data['user']}');
      return User.fromJson(response.data);
      // } else {
      //   print('RESPONSE ${response.statusCode}');
      //   return User.fromJson(response.data);
      // }
    } on DioError catch (error) {
      print('ERROR WAS KNOCKED! ${error}');
      print('error WAS ! ${error.response}');
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw Exception('$errorMessage');
    }
  }

  /// Update User account
  Future<User> updateInfo(userId, data) async {
    try {
      print('API LEVEL userId ${userId}');
      print('API_LEVEL DATA ${data}');
      final response =
          await Dio().put('${ApiRoutes.user}/${userId}', data: data);
      return User.fromJson(response.data);
    } on DioError catch (error) {
      print('ERROR WAS KNOCKED! ${error}');
      print('error WAS ! ${error.response}');
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw Exception('$errorMessage');
    }
  }

  /// Forgot password
  Future forgotPassword(data) async {
    try {
      final response = await Dio().post(ApiRoutes.forgotPassword, data: data);
      print('statusCode ${response.statusCode}');
      // print('response ${response.data['user']}');
      // return response.data;
      if (response.statusCode == 200) {
        return true;
      }
    } on DioError catch (error) {
      print('ERROR WAS KNOCKED! ${error}');
      print('error WAS ! ${error.response}');
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw Exception('$errorMessage');
    }
  }

  /// Reset/Update password

  /// Fetch currency
  Future<Currency> fetchCurrency() async {
    try {
      final response = await Dio().get(ApiRoutes.currency);
      // if (response.statusCode == 200) {
      //   // print('Currency ${response.data}');
      //   // print('HERE ${Currency.fromJson(response.data)}');
      //   return Currency.fromJson(response.data);
      // }
      return Currency.fromJson(response.data);
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw Exception('$errorMessage');
    }
  }

  /// Fetch Phone number

  /// Fetch Email Address

  /// Fetch Terms and Conditions
}
