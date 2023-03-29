import "package:flutter/material.dart";
import '../model/Category_Pro_Model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TopDealProducts with ChangeNotifier {
  List<Product> _top_deals_items = [];

  Future<void> fetchAndSetTopDealProduct(String branch_id) async {
    String url;

    print('toppppppppppppp');
    print(branch_id);
    if (branch_id.isEmpty) {
      url = 'https://www.svgs.co/api/homepage?brch_id=1';
    } else {
      int branchId = int.parse(branch_id);
      url = 'https://www.svgs.co/api/homepage?brch_id=$branchId';
    }
    try {
      final response = await http.get(Uri.parse(url));

      final extractedProducts = json.decode(response.body) as List;

      final List<Product> loadedItem = [];
      extractedProducts.forEach((topDeal) {
        // print((topDeal['item_sellprice'].split(','))[0]);
        loadedItem.add(Product(
          productId: topDeal['product_id'],
          productName: topDeal['product_name'],
          productDescription: topDeal['product_desc'],
          productItemId: topDeal['item_id'],
          productSlug: topDeal['product_slug'],
          productImage: topDeal['item_image'],
          productItemsOldPrice: topDeal['item_mrp'],
          productItemsOrginalSellprice: topDeal['item_sellprice'],
          productItemsDiscount: topDeal['save_pri'],
          productItemsSpec: topDeal['item_spec'],
          productItemsUnit: topDeal['item_unit'],
          productItemsStock: topDeal['item_stock'],
        ));
        _top_deals_items = loadedItem;
        notifyListeners();

        //(topDeal['item_mrp'].split(','))[0]
      });
    } catch (error) {
      throw error;
    }
  }

  List<Product> get top_deal_items {
    return [..._top_deals_items];
  }
}
