import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:cashier_app_mobile/helper/app_exception.dart';

class NetworkUtil {
  static final NetworkUtil _instance = NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  Future<dynamic> post(String url, {Map<String, dynamic>? body, Map<String, String>? headers, Map<String, String>? param, encoding}) async {
    String jsonBody = json.encode(body);
    Map<String, String> headerJson = {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, PATCH, DEL"
    };
    if (headers != null) {
      headerJson.addAll(headers);
    }

    if (kDebugMode) {
      print(jsonBody);
    }

    if (kDebugMode) {
      print(headerJson);
    }
    return await http
        .post(_setParameter(url, param), headers: headerJson, body: jsonBody, encoding: encoding)
        .then((http.Response response) => _returnResponse(response));
  }

  Future<dynamic> get(
    String url, {
    Map<String, String>? param,
    Map<String, String>? headers,
  }) {
    return http.get(_setParameter(url, param), headers: headers).then((http.Response response) => _returnResponse(response));
  }

  Future<dynamic> getImage(
    String url, {
    Map<String, String>? param,
    Map<String, String>? headers,
  }) {
    return http.get(_setParameter(url, param), headers: headers).then((http.Response response) => _returnResponseImage(response));
  }

  Future<dynamic> formPost(
    String url, {
    Map<String, String>? body,
    Map<String, String>? headers,
    Map<String, String>? param,
  }) async {
    Uri uri = _setParameter(url, param);
    var request = http.MultipartRequest('POST', uri);
    if (headers != null && headers.isNotEmpty) request.headers.addAll(headers);
    if (body != null && body.isNotEmpty) request.fields.addAll(body);
    return await http.Response.fromStream(await request.send()).then((http.Response response) => _returnResponse(response));
  }

  Future<dynamic> formPut(
    String url, {
    Map<String, String>? body,
    Map<String, String>? headers,
    Map<String, String>? param,
  }) async {
    Uri uri = _setParameter(url, param);
    var request = http.MultipartRequest('PUT', uri);
    if (headers != null && headers.isNotEmpty) request.headers.addAll(headers);
    if (body != null && body.isNotEmpty) request.fields.addAll(body);
    return await http.Response.fromStream(await request.send()).then((http.Response response) => _returnResponse(response));
  }

  Future<dynamic> delete(String url, {Map<String, String>? headers, Map<String, String>? param, encoding}) async {
    if (kDebugMode) {
      print(url);
    }
    return await http.delete(_setParameter(url, param), headers: headers).then(
          (http.Response response) => _returnResponse(response),
        );
  }

  Future<dynamic> multipartOneFile(String req, String url,
      {File? image, Map<String, String>? headers, Map<String, String>? param, Map<String, String>? body, encoding}) async {
    if (kDebugMode) {
      print(url);
    }
    Uri uri = _setParameter(url, param);
    var request = http.MultipartRequest(req, uri);
    if (headers != null && headers.isNotEmpty) request.headers.addAll(headers);
    if (body != null && body.isNotEmpty) request.fields.addAll(body);
    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          image.path,
        ),
      );
    }
    // ? SENDING REQ
    http.StreamedResponse response = await request.send();
    final responseGetter = await response.stream.bytesToString();

    switch (response.statusCode) {
      case 200:
        Map responseJson = {};
        var responseHeader = response.headers;
        responseJson.addAll(responseHeader);

        var responseBody = json.decode(responseGetter);
        if (responseBody is Map) responseJson.addAll(responseBody);

        return responseJson;
      case 400:
        throw BadRequestException('Error 400');
      case 401:
        throw InvalidSessionExpression('Response 401');
      case 403:
        throw UnauthorisedException(response.headers.toString());
      case 500:
        Map responseJson = {};
        responseJson.addAll(response.headers);
        var responseBody = json.decode(responseGetter);
        responseJson.addAll(responseBody);
        var message = responseJson['message'];
        throw FetchDataException('Error 500 : $message');
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic _returnResponseImage(http.Response response) {
    switch (response.statusCode) {
      case 200:
        String responseJson;

        responseJson = response.body;

        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        throw BadRequestException(responseJson['message']);
      case 401:
        throw InvalidSessionExpression('Response 401');
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        var responseJson = json.decode(response.body.toString());
        throw FetchDataException(responseJson['message']);
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> responseJson = {};
        var responseHeader = response.headers;
        responseJson.addAll(responseHeader);

        late Map<String, dynamic> responseBody;
        try {
          responseBody = json.decode(response.body);
        } catch (e) {
          throw FetchDataException('Successfully requested, but an invalid response retrieved');
        }

        responseJson.addAll(responseBody);

        return responseJson;
      case 400:
        throw BadRequestException('Error 400');
      case 401:
        throw InvalidSessionExpression('Response 401');
      case 403:
        throw UnauthorisedException(response.headers.toString());
      case 422:
        throw InvalidInputException(response.body);
      case 500:
        Map responseJson = {};
        responseJson.addAll(response.headers);
        var responseBody = json.decode(response.body);
        responseJson.addAll(responseBody);
        var message = responseJson['message'];
        throw FetchDataException('Error 500 : $message');
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Uri _setParameter(String url, Map<String, dynamic>? param) {
    int count = 0;
    if (param != null) {
      if (!url.endsWith('?')) {
        url = url + '?';
      }
      param.forEach((key, value) {
        if (count == 0) {
          url = url + key + '=$value';
          count++;
        } else {
          url = url + '&' + key + '=$value';
        }
      });
    }

    if (kDebugMode) {
      print(url);
    }
    return Uri.parse(url);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
