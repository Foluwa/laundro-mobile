class OrderApi {
  // Dio _dio;
  // bool addAccessToken;
  OrderApi() {
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
