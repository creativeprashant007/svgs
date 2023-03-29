import "package:flutter/material.dart";
import '../model/Category_Pro_Model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryProductListingProvider with ChangeNotifier {
  var _isLoading = false;

  getLoading() => _isLoading;
  List<Product> _category_Product_items = [];
  int success = 0;
  int last_page = 0;

  Future<void> fetchAndSetCategoryProduct(
    String alias,
    String uniqueId,
    String branch_id,
    String mem_id,
    int page,
  ) async {
    setLoading();
    _category_Product_items.clear();
    // print('${alias}');
    String url;

    print(alias);
    print(uniqueId);
    print("${branch_id}");
    print("${mem_id}");
    if (page == 1) {
      url =
          'https://www.svgs.co/api/category?brch_id=$branch_id&alias=$alias&unique_id=$uniqueId&mem_id=';
    } else {
      url =
          'https://www.svgs.co/api/category?brch_id=$branch_id&alias=$alias&unique_id=$uniqueId&mem_id=&page[number]=$page';
    }

    try {
      final response = await http.get(Uri.parse(url));

      print(
          "========================================SHARIYATH=====================================");
      print(url);
      print(response);
      print(response.body);

      final extractedProducts = json.decode(response.body) as dynamic;
      hideLoader();

      last_page = extractedProducts['last_page'];
      final List<Product> loadedItem = [];
      extractedProducts.forEach((key, category_product) {
        // print((category_product['item_sellprice'].split(','))[0]);
        loadedItem.add(Product(
          productId: category_product['product_id'],
          productName: category_product['product_name'],
          productSlug: category_product['product_slug'],
          productItemId: category_product['item_id'],
          productImage: category_product['item_image'],
          productItemsOldPrice: category_product['item_mrp'],
          productItemsOrginalSellprice: category_product['item_sellprice'],
          productItemsDiscount: category_product['save_pri'],
          productItemsSpec: category_product['item_spec'],
          productItemsUnit: category_product['item_unit'],
          //productCatSlug: category_product['cate_list']['name'],
        ));
        _category_Product_items = loadedItem;
        success = 1;

        // print(_category_Product_items);
        notifyListeners();

        //(category_product['item_mrp'].split(','))[0]
      });
    } catch (error) {
      // throw error;
    }
  }

  List<Product> get category_Product_items {
    // _category_Product_items.clear();
    return [..._category_Product_items];
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
