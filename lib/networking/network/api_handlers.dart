import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import 'package:svgs_app/utils/messages.dart';

import '../api_error.dart';

enum MethodType { POST, GET, PUT, DELETE }

const Duration timeoutDuration = const Duration(seconds: 60);

class APIHandlerHTTP {
  static Map<String, String> defaultHeaders = {
    "Content-Type": "application/json",
    "device_type": Platform.isAndroid ? "1" : "2",
    "app_version": "1.0.0",
  };

  // POST method
  static Future<dynamic> post({
    dynamic requestBody,
    @required BuildContext context,
    @required String url,
    Map<String, String> additionalHeaders = const {},
  }) async {
    print("hittt post $requestBody");
    return await _hitApi(
      context: context,
      url: url,
      methodType: MethodType.POST,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,
    );
  }

  // GET method
  static Future<dynamic> get({
    @required String url,
    @required BuildContext context,
    dynamic requestBody,
    Map<String, String> additionalHeaders = const {},
  }) async {
    return await _hitApi(
      context: context,
      url: url,
      methodType: MethodType.GET,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,
    );
  }

  // GET method
  static Future<dynamic> delete({
    @required String url,
    @required BuildContext context,
    Map<String, String> additionalHeaders = const {},
  }) async {
    return await _hitApi(
      context: context,
      url: url,
      methodType: MethodType.DELETE,
      additionalHeaders: additionalHeaders,
    );
  }

  // PUT method
  static Future<dynamic> put({
    @required dynamic requestBody,
    @required BuildContext context,
    @required String url,
    Map<String, String> additionalHeaders = const {},
  }) async {
    return await _hitApi(
      context: context,
      url: url,
      methodType: MethodType.PUT,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,
    );
  }

  // Generic HTTP method
  static Future<dynamic> _hitApi({
    @required BuildContext context,
    @required MethodType methodType,
    @required String url,
    dynamic requestBody,
    Map<String, String> additionalHeaders = const {},
  }) async {
    Completer<dynamic> completer = new Completer<dynamic>();
    try {
      Map<String, String> headers = {};
      headers.addAll(defaultHeaders);
      headers.addAll(additionalHeaders);

      var response;

      switch (methodType) {
        case MethodType.POST:
          response = await http
              .post(Uri.parse(url), body: requestBody)
              .timeout(timeoutDuration);

          break;
        case MethodType.GET:
          response = await http
              .get(
                Uri.parse(url),
              )
              .timeout(timeoutDuration);
          break;
        // case MethodType.PUT:
        //   response = await dio
        //       .put(
        //         url,
        //         data: json.encode(requestBody),
        //         options: Options(
        //           headers: headers,
        //         ),
        //       )
        //       .timeout(timeoutDuration);
        //   break;
        // case MethodType.DELETE:
        //   response = await dio
        //       .delete(
        //         url,
        //         options: Options(
        //           headers: headers,
        //         ),
        //       )
        //       .timeout(timeoutDuration);
        //   break;
      }

      print("url: ${url}");
      print("api handler requestbody: $requestBody");
      print("api handler responsebody: ${json.encode(response.body)}");
      print("api handler response code: ${response?.statusCode}");

      completer.complete(response.body);
    } on DioError catch (e) {
      print("dio cath ${e.message}");
      print("error ${e.response?.statusCode}");
      print("messag ${e.response?.data}");
      print("messag ${e.response}");

      if (e.response?.statusCode == 403) {
        APIError apiError = new APIError(
          error: parseError(e.response.data),
          status: 403,
          onAlertPop: () {},
        );
        completer.complete(apiError);
      } else if (e.response?.statusCode == 400) {
        print(e.response.data);
        APIError apiError = new APIError(
          error: parseError(e.response.data),
          message: e.response.data,
          status: 400,
          onAlertPop: () {
//             onLogoutSuccess(
//               context: context,
//             );
          },
        );
        completer.complete(apiError);
      } else if (e.response?.statusCode == 401) {
        APIError apiError = new APIError(
          error: parseError(e.response.data),
          status: 401,
          onAlertPop: () {
//             onLogoutSuccess(
//               context: context,
//             );
          },
        );
        completer.complete(apiError);
      } else {
        APIError apiError = new APIError(
            error: parseError(e.response?.data ?? ""),
            message: e.response?.data ?? "",
            status: e.response?.statusCode ?? 0);
        completer.complete(apiError);
      }
    } catch (e) {
      print("errror ${e.toString()}");
      APIError apiError =
          new APIError(error: Messages.genericError, status: 500);
      completer.complete(apiError);
    }
    return completer.future;
  }

  static String parseError(dynamic response) {
    print("parse erro ${response}");
    try {
      var error = response["error"];
      if (error == null) {
        var status = response["status"];
        if (status == false) {
          if (response["data"]["email"] = null)
            return response["data"]["email"][0] ?? Messages.genericError;
          else if (response["data"]["username"] = null)
            return response["data"]["username"][0] ?? Messages.genericError;
          else
            return Messages.genericError;
        }
      }
      return error;
    } catch (e) {
      print("error ${e.toString()}");
      return Messages.genericError;
    }
  }

  static String parseErrorMessage(dynamic response) {
    try {
      return response["message"];
    } catch (e) {
      return Messages.genericError;
    }
  }
}
