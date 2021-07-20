import 'package:dio/dio.dart';
import 'package:laundro/models/products.dart';

import '../models/categories.dart';
import '../models/currency.dart';
import '../utils/api_routes.dart';
import 'Exceptions/dio_exception.dart';

class LaundryApi {
  Dio _dio;
  bool addAccessToken;
  LaundryApi({this.addAccessToken}) {
    print('Access Token $addAccessToken');
    final options = BaseOptions(
      connectTimeout: 100000,
      receiveTimeout: 80000,
    );
    _dio = Dio(options);
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
      // print('RESPONSE $response');
      // print('Called Categories  ${response.data}');
      return CategoryList.fromJson(response.data);
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      print('FOLUWA  $errorMessage');
      throw Exception('$errorMessage');
    }
  }

  /// Fetch Products in a subcategory
  Future<ProductList> fetchProducts(var id) async {
    try {
      print('FetchProducts WAS CALLED');
      //var url = ApiRoutes.sub_categories + id;
      var url2 = 'https://laundro-staging-api.herokuapp.com/sub-categories/2';
      // print('URL is $url');
      final response =
          await Dio().get(url2); // '${ApiRoutes.sub_categories}/${id}'
      print('RESPONSE ${response.data['products']}');
      return ProductList.fromJson(response.data['products']);
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      print('FOLUWA  $errorMessage');
      throw Exception('$errorMessage');
    }
  }

  /// Fetch Location
  /// Fetch currency
  Future<Currency> fetchCurrency() async {
    try {
      final response = await _dio.get(ApiRoutes.currency);
      if (response.statusCode == 200) {
        print('Currency ${response.data}');
        print('HERE ${Currency.fromJson(response.data)}');
        return Currency.fromJson(response.data);
      }
      return null;
    } catch (error, stacktrace) {
      print('stacktrace $stacktrace');
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw Exception('$errorMessage');
    }
  }
}
