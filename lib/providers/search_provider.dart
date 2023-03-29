import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:svgs_app/model/Category_Pro_Model.dart';

class SearchProvider with ChangeNotifier {
  List<Product> _searchItem = [];
  List<Product> get searchItem {
    return [..._searchItem];
  }

  int last_page = 0;

  Future<void> fetchAndSetSearchItem(String branchId, String keyWord,
      String uniqueId, String memberId, int page) async {
    String url;

    if (page == 1) {
      url =
          'https://www.svgs.co/api/search?brch_id=$branchId&keyword=$keyWord&unique_id=$uniqueId&mem_id=$memberId';
    } else {
      url =
          'https://www.svgs.co/api/search?brch_id=$branchId&keyword=$keyWord&unique_id=$uniqueId&mem_id=$memberId&page[number]=$page';
    }

    try {
      final response = await http.get(Uri.parse(url));

      print(
          "========================================SHARIYATH=====================================");
      print(url);
      print(response);
      print(response.body);

      final extractedProducts = json.decode(response.body) as dynamic;

      last_page = extractedProducts['last_page'];
      print("QWERT_QWERT");
      print(last_page);

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
        _searchItem = loadedItem;

        notifyListeners();

        //(category_product['item_mrp'].split(','))[0]
      });
    } catch (error) {
      // throw error;
    }
  }
}
