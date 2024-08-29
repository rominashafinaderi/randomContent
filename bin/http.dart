import 'dart:convert';
import 'package:http/http.dart' as http;
import 'helper.dart';

class Http {
  Future<http.Response> get(String path, {Map<String, String>? queryParams}) async {

    final getCountUri = Uri.https('api.12application.ir', path, queryParams);

    try {
      final response = await http
          .get(getCountUri)
          .catchError((_) => (_timeoutErrorResponse()));
      return await _handleRequest(response);
    } catch (e) {
      return _timeoutErrorResponse();
    }
  }

  Future<http.Response> _handleRequest(http.Response response) async {
    if (response.statusCode < 300) {
      return response;
    }
    if (response.statusCode == 408) {
      await Future.delayed(Duration(seconds: 2));
      return response;
    }
    if (response.statusCode == 401) {
      return _generateErrorResponse(
          message: 'لطفا مجدد وارد حساب کاربری شوید', statusCode: 401);
    }

    if (response.statusCode >= 500) {
      return _generateErrorResponse(
          message: 'خطا در سمت سرور', statusCode: 500);
    }
    return response;
  }

  http.Response _generateErrorResponse(
      {int statusCode = 500, String message = "خطایی غیر منتظره رخ داد"}) {
    return http.Response(
      jsonEncode({"message": encodeUtf8(message), "status": false}),
      statusCode,
    );
  }

  http.Response _timeoutErrorResponse() {
    return _generateErrorResponse(
        message: "خطا در اتصال به اینترنت", statusCode: 408);
  }
}
