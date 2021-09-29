import 'package:dio/dio.dart';
import 'package:laundro/models/order.dart';
import 'package:laundro/models/payment/flutterwave.dart';
import 'package:laundro/utils/api_routes.dart';

import 'Exceptions/dio_exception.dart';
import 'interceptors/auth_interceptor.dart';

class OrderApi {
  late Dio _dio;
  bool? addAccessToken;
  OrderApi({required bool addAccessToken}) {
    print('Access Token $addAccessToken');
    final options = BaseOptions(
      connectTimeout: 100000,
      receiveTimeout: 80000,
    );
    _dio = Dio(options);
    if (addAccessToken) {
      print('adding interceptor');
      _dio.interceptors.add(AuthInterceptor());
    }
  }

  /// Fetch Orders
  Future<OrderList> fetchUserOrders() async {
    print('FetchCategories WAS CALLED');
    try {
      final response = await _dio.get(ApiRoutes.orders);
      print('AKIN ${response}');
      print('FOLUWA  ${response.data}');
      return OrderList.fromJson(response.data);
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();

      throw Exception('$errorMessage');
    }
  }

  /// Create Orders
  Future createOrder(data) async {
    print('REGISTER WAS CALLED $data');
    try {
      final response = await _dio.post(ApiRoutes.orders, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('response.data ${response.data}');
        return response.data;
      }
    } on DioError catch (error) {
      print('ERROR WAS KNOCKED! ${error}');
      print('error WAS ! ${error.response}');
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw Exception('$errorMessage');
    }
  }

  /// Fetch API keys
  Future<Flutterwave> fetchFlutterWaveKeys() async {
    print('fetchFlutterWaveKeys WAS CALLED');
    try {
      final response = await _dio.get(ApiRoutes.flutterwave);
      print('Flutterwave Keys ${response}');
      return Flutterwave.fromJson(response.data);
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw Exception('$errorMessage');
    }
  }

  /// Update Orders
  // Future<Orders> fetchUserOrders() async {
  //   print('FetchCategories WAS CALLED');
  //   try {
  //     // var response = await _dio.get(ApiRoutes.categories);
  //     final response = await Dio().get(ApiRoutes.categories);
  //     return CategoryList.fromJson(response.data);
  //   } on DioError catch (error) {
  //     final errorMessage = DioExceptions.fromDioError(error).toString();
  //     print('FOLUWA  $errorMessage');
  //     throw Exception('$errorMessage');
  //   }
  // }
}
