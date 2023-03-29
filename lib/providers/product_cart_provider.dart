import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:svgs_app/model/cart/product_add_to_cart_request.dart';
import 'package:svgs_app/model/cart/product_add_to_cart_response.dart';
import 'package:svgs_app/model/payment_methods.dart';
import 'package:svgs_app/networking/api_error.dart';
import 'package:svgs_app/networking/network/api_handlers.dart';
import 'package:svgs_app/networking/network/apis.dart';

class ProductCartProvider with ChangeNotifier {
  var _isLoading = false;
  final controller = StreamController<dynamic>.broadcast();

  getLoading() => _isLoading;
  bool _isFiltered = false;

  getIsFiltered() => _isFiltered;

  Future<dynamic> productAddToCart(
    ProductAddToCartRequest request,
    BuildContext context,
  ) async {
    setLoading();
    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandlerHTTP.get(
      context: context,
      url:
          "${APIs.addToCart}?brch_id=${request.branch_id}&unique_id=${request.uniqueId}&proid=${request.productId}&itemid=${request.itemId}&qty=${request.qty}&mem_id=${request.mem_id}",
    );

    print(response);
    hideLoader();
    if (response is APIError) {
      completer.complete(response);
      return completer.future;
    } else {
      ProductAddToCartResponse productAddToCartResponse =
          ProductAddToCartResponse.fromJson(json.decode(response));
      completer.complete(
        productAddToCartResponse,
      );
      notifyListeners();
      return completer.future;
    }
  }

  Future<dynamic> getPaymentMethods(
    BuildContext context,
  ) async {
    setLoading();
    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandlerHTTP.get(
      context: context,
      url: "${APIs.paymentMethods}",
    );

    print(response);
    hideLoader();
    if (response is APIError) {
      completer.complete(response);
      return completer.future;
    } else {
      PaymentMethodResponse paymentMetodResponse =
          PaymentMethodResponse.fromJson(json.decode(response));
      completer.complete(
        paymentMetodResponse,
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
