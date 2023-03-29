import "package:flutter/material.dart";
import '../model/Category_Pro_Model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopCategoriesProvider with ChangeNotifier {
  List<ShopCategories> _shop_categories_items = [];

  Future<void> fetchAndSetShopCategories() async {
    _shop_categories_items.clear();
    const url = 'https://www.svgs.co/api/shopByCategory';
    try {
      final response = await http.get(Uri.parse(url));

      final extractedCats = json.decode(response.body) as List;

      final List<ShopCategories> loadedItem = [];
      extractedCats.forEach((shopCategories) {
        // print((topDeal['item_sellprice'].split(','))[0]);
        loadedItem.add(ShopCategories(
          catImage: shopCategories['catimage'],
          catName: shopCategories['catname'],
          catSlug: shopCategories['catslug'],
          catid: shopCategories['catid'].toString(),
        ));
        _shop_categories_items = loadedItem;
        notifyListeners();

        print('checking_well======================================');
        print(_shop_categories_items);

        //(topDeal['item_mrp'].split(','))[0]
      });
    } catch (error) {
      throw error;
    }
  }

  List<ShopCategories> get shop_categories_items {
    return [..._shop_categories_items];
  }
}
