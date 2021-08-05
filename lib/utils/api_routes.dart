import 'constants.dart';

class ApiRoutes {
  static String baseUrl = Constants.baseUrl;

  /// USER ROUTES
  static String register = '$baseUrl/auth/local/register';
  static String login = '$baseUrl/auth/local';
  static String resetPassword = '$baseUrl';
  static String verifyMe = '$baseUrl/users/me';

  /// LAUNDRY ROUTES
  static String products = '$baseUrl/products';
  static String locations = '$baseUrl/locations';
  static String categories = '$baseUrl/categories';
  static String sub_categories = '$baseUrl/sub-categories';
  static String currency = '$baseUrl/currency';
}
