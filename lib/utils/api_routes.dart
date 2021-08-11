import 'constants.dart';

class ApiRoutes {
  static String baseUrl = Constants.baseUrl;

  /// USER ROUTES
  static String register = '$baseUrl/auth/local/register';
  static String login = '$baseUrl/auth/local';
  static String verifyMe = '$baseUrl/users/me';
  static String forgotPassword = '$baseUrl/auth/forgot-password';
  static String resetPassword = '$baseUrl';

  /// Business
  static String phoneNumber = '$baseUrl/phone-number';
  static String email = '$baseUrl/email';
  static String tandC = '$baseUrl/terms-and-conditions';

  /// LAUNDRY ROUTES
  static String products = '$baseUrl/products';
  static String locations = '$baseUrl/locations';
  static String categories = '$baseUrl/categories';
  static String sub_categories = '$baseUrl/sub-categories';
  static String currency = '$baseUrl/currency';
}
