import 'package:flutter/foundation.dart';

class CartItem {
  final String cartId;
  final String productId;
  final String itemId;
  final String productName;
  final String productSlug;
  final String productImage;
  final String itemPrice;
  final String itemSellPrice;
  final String quantity;
  final String subTotal;
  final String savings;
  bool isLoading;

  CartItem({
    @required this.cartId,
    @required this.productId,
    @required this.itemId,
    @required this.productName,
    @required this.productSlug,
    @required this.productImage,
    @required this.itemPrice,
    @required this.itemSellPrice,
    @required this.quantity,
    @required this.subTotal,
    @required this.savings,
    this.isLoading = false,
  });
}
