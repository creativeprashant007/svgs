import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:svgs_app/model/static_content/contact_us_response.dart';
import 'package:svgs_app/model/static_content/static_content_response.dart';
import 'package:svgs_app/networking/api_error.dart';
import 'package:svgs_app/networking/network/api_handlers.dart';
import 'package:svgs_app/networking/network/apis.dart';

class StaticPageProvider with ChangeNotifier {
  var _isLoading = false;

  getLoading() => _isLoading;

  Future<dynamic> getAboutUs(BuildContext context) async {
    setLoading();
    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandlerHTTP.get(
      context: context,
      url: "${APIs.aboutUs}",
    );
    print('${APIs.aboutUs}');
    print(response);
    hideLoader();
    if (response is APIError) {
      completer.complete(response);
      return completer.future;
    } else {
      StaticContentResponse aboutUsResponse =
          StaticContentResponse.fromJson(json.decode(response));
      completer.complete(
        aboutUsResponse,
      );
      notifyListeners();
      return completer.future;
    }
  }

  Future<dynamic> getPrivacyPolicy(BuildContext context) async {
    setLoading();
    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandlerHTTP.get(
      context: context,
      url: "${APIs.privacyPolicy}",
    );
    print('${APIs.privacyPolicy}');
    print(response);
    hideLoader();
    if (response is APIError) {
      completer.complete(response);
      return completer.future;
    } else {
      StaticContentResponse aboutUsResponse =
          StaticContentResponse.fromJson(json.decode(response));
      completer.complete(
        aboutUsResponse,
      );
      notifyListeners();
      return completer.future;
    }
  }

  Future<dynamic> getTermsAndConditions(BuildContext context) async {
    setLoading();
    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandlerHTTP.get(
      context: context,
      url: "${APIs.termsConditions}",
    );
    print('${APIs.termsConditions}');
    print(response);
    hideLoader();
    if (response is APIError) {
      completer.complete(response);
      return completer.future;
    } else {
      StaticContentResponse aboutUsResponse =
          StaticContentResponse.fromJson(json.decode(response));
      completer.complete(
        aboutUsResponse,
      );
      notifyListeners();
      return completer.future;
    }
  }

  Future<dynamic> getContactUs(BuildContext context) async {
    setLoading();
    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandlerHTTP.get(
      context: context,
      url: "${APIs.contactUs}",
    );
    print('${APIs.contactUs}');
    print(response);
    hideLoader();
    if (response is APIError) {
      completer.complete(response);
      return completer.future;
    } else {
      ContactUsResponse aboutUsResponse =
          ContactUsResponse.fromJson(json.decode(response));
      completer.complete(
        aboutUsResponse,
      );
      notifyListeners();
      return completer.future;
    }
  }

  void hideLoader() {
    _isLoading = false;
    notifyListeners();
  }

  void setLoading() {
    _isLoading = true;
    notifyListeners();
  }
}
