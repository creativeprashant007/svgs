import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:svgs_app/model/offers/offers_response.dart';
import 'package:svgs_app/model/static_content/contact_us_response.dart';
import 'package:svgs_app/model/static_content/static_content_response.dart';
import 'package:svgs_app/networking/api_error.dart';
import 'package:svgs_app/networking/network/api_handlers.dart';
import 'package:svgs_app/networking/network/apis.dart';

class OfferProvider with ChangeNotifier {
  var _isLoading = false;

  getLoading() => _isLoading;

  getOffers(BuildContext context) async {
    setLoading();
    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandlerHTTP.get(
      context: context,
      url: "${APIs.offer_popup}",
    );
    print('${APIs.offer_popup}');
    print(response);
    hideLoader();
    if (response is APIError) {
      completer.complete(response);
      return completer.future;
    } else {
      OffersResponse offersResponse =
          OffersResponse.fromJson(json.decode(response));
      completer.complete(
        offersResponse,
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
