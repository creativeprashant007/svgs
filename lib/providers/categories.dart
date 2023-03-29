import 'package:flutter/material.dart';
import 'package:svgs_app/model/Category_Pro_Model.dart';

import '../model/Category_Pro_Model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesProvider with ChangeNotifier {
  var _isLoading = false;

  getLoading() => _isLoading;
  List<CateDetails> _categories_list = [];
  List<SubSubCateDetails> _sub_sub_categories_list = [];

  Future<void> fetchAndSetCategories() async {
    const url = 'https://www.svgs.co/api/homecategories';
    try {
      final response = await http.get(Uri.parse(url));

      final extractedCats = json.decode(response.body) as List;
      // print(response.body);

      final List<CateDetails> loadedItem = [];
      extractedCats.forEach((categories) {
        // print((topDeal['item_sellprice'].split(','))[0]);
        loadedItem.add(
          CateDetails(
            catid: categories['cat_id'].toString(),
            categoryname: categories['cat_name'],
            catslug: categories['cat_slug'],
            sub_cat_id: categories['subcat_id'].toString(),
            subCatName: categories['subcat_name'],
            subCatSlug: categories['subcat_slug'],
          ),
        );
        _categories_list = loadedItem;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  List<CateDetails> get cat_items {
    return [..._categories_list];
  }

  Future<void> fetchAndSetSubSubCategories(String sub_cat_id) async {
    //_sub_sub_categories_list.clear();
    setLoading();
    final url = 'https://www.svgs.co/api/subsubCategory?id=$sub_cat_id';
    print("Shariyath khan=================================================");
    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      final extractedCats = json.decode(response.body) as List;
      // print(response.body);

      final List<SubSubCateDetails> loadedSubSubItem = [];

      loadedSubSubItem.add(
        SubSubCateDetails(title: 'All', alias: 'all', id: 0),
      );
      hideLoader();
      extractedCats.forEach((sub_sub_categories) {
        // print((topDeal['item_sellprice'].split(','))[0]);
        //print("=============wewe============");
        print(sub_sub_categories);
        loadedSubSubItem.add(
          SubSubCateDetails(
              title: sub_sub_categories['title'],
              alias: sub_sub_categories['alias'],
              id: sub_sub_categories['id']),
        );
        _sub_sub_categories_list = loadedSubSubItem;
        notifyListeners();
      });

      print("=============wewe============");
      print(_sub_sub_categories_list);
    } catch (error) {
      throw error;
    }
  }

  List<SubSubCateDetails> get sub_sub_cat_items {
    return [..._sub_sub_categories_list];
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
