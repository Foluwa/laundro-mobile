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
        //return error['message'];
        return 'Email or password incorrect';
      case 401:
        return 'Not authorized';
      case 403:
        return 'Not authorized';
      case 404:
        return 'Resource not found';
      case 500:
        return 'Oops something went wrong';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
