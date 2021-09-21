import 'package:dio/dio.dart';

import '../models/category.dart';
import '../models/currency.dart';
import '../models/location.dart';
import '../models/product.dart';
import '../utils/api_routes.dart';
import 'Exceptions/dio_exception.dart';

class LaundryApi {
  // Dio _dio;
  // bool addAccessToken;
  LaundryApi() {
    //print('Access Token $addAccessToken');
    // final options = BaseOptions(
    //   connectTimeout: 100000,
    //   receiveTimeout: 80000,
    // );
    // _dio = Dio(options);
    // if (this.addAccessToken) {
    //   print('adding interceptor');
    //   _dio.interceptors.add(AuthInterceptor());
    // }
  }

  /// Fetch Categories and Sub-Categories
  Future<CategoryList> fetchCategories() async {
    print('FetchCategories WAS CALLED');
    try {
      // var response = await _dio.get(ApiRoutes.categories);
      final response = await Dio().get(ApiRoutes.categories);
      return CategoryList.fromJson(response.data);
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      print('FOLUWA  $errorMessage');
      throw Exception('$errorMessage');
    }
  }

  /// Fetch All Products in a subcategory
  Future<ProductList> fetchAllProducts() async {
    try {
      print('FetchAllProducts WAS CALLED');
      final response = await Dio().get(ApiRoutes.products);
      // print('RESPONSE ${response.data}');
      return ProductList.fromJson(response.data);
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      print('FOLUWA  $errorMessage');
      throw Exception('$errorMessage');
    }
  }

  /// Fetch Locations
  Future<LocationList> fetchAllLocations() async {
    try {
      print('fetchAllLocations WAS CALLED');
      final response = await Dio().get(ApiRoutes.locations);
      return LocationList.fromJson(response.data);
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      print('FOLUWA  $errorMessage');
      throw Exception('$errorMessage');
    }
  }

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
}
