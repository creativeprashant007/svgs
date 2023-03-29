import 'package:flutter/cupertino.dart';

import "package:flutter/material.dart";
import '../model/Category_Pro_Model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetail with ChangeNotifier {
  //List<Product> _product_detail = [];

  String productId = "";
  String productName = "";
  String productDescription = "";
  String productItemId = "";
  String productSlug = "";
  String productImage = "";
  String productItemsOldPrice = "";
  String productItemsOrginalSellprice = "";
  String productItemsDiscount = "";
  String productItemsSpec = "";
  String productItemsUnit = "";
  String productItemsStock = "";

  Future<void> fetchAndSetProductDetail(
    String alias,
    String uniqueId,
    String branch_id,
    String mem_id,
  ) async {
    print('we are at product details page----------------cre');
    final url =
        'https://www.svgs.co/api/productdetail?brch_id=$branch_id&alias=$alias&unique_id=$uniqueId&mem_id=$mem_id';
    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      print(response.body);

      final extractedProducts = json.decode(response.body) as dynamic;

      productId = extractedProducts['product_id'].toString();
      productName = extractedProducts['product_name'];
      productDescription = extractedProducts['product_desc'];
      productItemId = extractedProducts['item_id'];
      productSlug = extractedProducts['product_slug'];
      productImage = extractedProducts['item_image'];
      productItemsOldPrice = extractedProducts['item_mrp'];
      productItemsOrginalSellprice = extractedProducts['item_sellprice'];
      productItemsDiscount = extractedProducts['save_pri'];
      productItemsSpec = extractedProducts['item_spec'];
      productItemsUnit = extractedProducts['item_unit'];
      productItemsStock = extractedProducts['item_stock'];

      notifyListeners();

      //(extractedProducts['item_mrp'].split(','))[0]

    } catch (error) {
      //throw error;
      print('----------------------productDetails error ------$error');
    }
  }
}
