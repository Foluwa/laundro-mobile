import 'constants.dart';

class ApiRoutes {
  static String baseUrl = Constants.baseUrl;

  /// USER ROUTES

  /// LAUNDRY ROUTES
  static String products = '$baseUrl/products';
  static String locations = '$baseUrl/locations';
  static String categories = '$baseUrl/categories';
  static String sub_categories = '$baseUrl/sub-categories';
  static String currency = '$baseUrl/currency';
}
