import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioErrorType.connectTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioErrorType.other:
        message = 'Connection to API server failed due to internet connection';
        break;
      case DioErrorType.receiveTimeout:
        message = 'Receive timeout in connection with API server';
        break;
      case DioErrorType.response:
        message = _handleError(
            dioError.response!.statusCode!, dioError.response!.data);
        break;
      case DioErrorType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      default:
        message = 'Something went wrong';
        break;
    }
  }

  String message = 'Error Encountered';

  String _handleError(int statusCode, error) {
    switch (statusCode) {
      case 400:
        return error;
      case 401:
        return error['message'];
      // case 403:
      //   return error['message'];
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
