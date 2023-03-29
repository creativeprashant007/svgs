import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:svgs_app/providers/api_provider.dart';
import '../model/cart_item.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  // String uniqueId = ApiProviders().uid;
  int success = 0;
  int error = 1;
  List<CartItem> _items = [];
  String deliverOverAmount = "";
  String deliveryCheck = "";
  String total = "";
  String totalSaving = "";
  String delivery_charge = "";
  int success_rmove_cart = 0;

  List<CartItem> get items {
    print(
        "quantity checking==============================shariyath==============================================");
    // print(items[0].quantity);
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  // double get totalAmount {
  //   var total = 0.0;
  //   _items.forEach((key, cartItem) {
  //     total += cartItem.price * cartItem.quantity;
  //   });
  //   return total;
  // }

  Future<void> fetchAndSetCartItem(
      String branchId, String uniqueId, String mem_id) async {
    print('here to print unique id');
    String url;
    print(uniqueId);

    url =
        "https://www.svgs.co/api/viewCart?brch_id=$branchId&unique_id=$uniqueId&mem_id=$mem_id";

    print(
        "Auto_loaded===========================shariyath===================================");
    print(url);

    try {
      final response = await http.get(Uri.parse(url));
      print(response.body);

      final extractedData = json.decode(response.body);
      final extractedItem = extractedData['cart_items'] as List;
      print("--------------here-------");
      print(extractedItem);
      final List<CartItem> loadedItem = [];
      deliverOverAmount = extractedData['delivery_ovr_amnt'];
      total = extractedData['total'];
      totalSaving = extractedData['total_savings'];
      delivery_charge = extractedData['delivery_charge'];
      deliveryCheck = extractedData['delivery_check'];

      success = 1;

      extractedItem.forEach((cartItem) {
        print('start');
        //print(cartItem);
        // print(cartItem['cart_id']);

        loadedItem.add(
          CartItem(
            cartId: cartItem['cart_id'].toString(),
            productId: cartItem['pro_id'].toString(),
            itemId: cartItem['item_id'].toString(),
            productName: cartItem['pro_name'],
            productSlug: cartItem['pro_slug'],
            productImage: cartItem['pro_image'],
            itemPrice: cartItem['item_mrp'].toString(),
            itemSellPrice: cartItem['item_sellprice'].toString(),
            quantity: cartItem['cart_qty'].toString(),
            subTotal: cartItem['sub_total'].toString(),
            savings: cartItem['savings'],
          ),
        );

        // print('end');

        _items = loadedItem;
        print(_items);

        notifyListeners();
      });
    } catch (error) {
      // throw error;
      print(error);
    }
  }

  Future<void> addItem(String productId, String itemId, int qty,
      String uniqueId, String mem_id, String branch_id) async {
    print('adding to cart');

    print(uniqueId);
    print(mem_id);
    print(branch_id);
    // int branchId = int.parse(branch_id);
    final url =
        "https://www.svgs.co/api/addtocart?brch_id=$branch_id&unique_id=$uniqueId&proid=${productId}&itemid=${itemId}&qty=$qty&mem_id=$mem_id";
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      print(response.body);
      final extractedResponse = json.decode(response.body);
      success = extractedResponse['success'];
      error = extractedResponse['error'];
      notifyListeners();
    } catch (error) {}
  }

  Future<void> addOneMore(String cartId, String branch_id) async {
    int branchId = int.parse(branch_id);
    int id = int.parse(cartId);
    final url =
        "https://www.svgs.co/api/updateToCart?type=add&id=$id&brch_id=$branchId";
    print('---------------here is the add url-----------');
    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      print('---------------response_add_one_more-----------');
      print(response.body);
      final extractedResponse = json.decode(response.body);
      success = extractedResponse['success'];
      error = extractedResponse['error'];
      print(error);
      print(success);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> removeOneMore(String cartId, String branch_id) async {
    int branchId = int.parse(branch_id);
    int id = int.parse(cartId);
    final url =
        "https://www.svgs.co/api/updateToCart?type=minus&id=$id&brch_id=$branchId";

    print("Tetsing_remove_one_more");
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      final extractedResponse = json.decode(response.body);
      success = extractedResponse['success'];
      error = extractedResponse['error'];
      print(error);
      print(success);
      print(response.body);
      notifyListeners();
    } catch (error) {}
  }

  Future<void> clearCart(
    String uniqueId,
    String mem_id,
    String branch_id,
  ) async {
    print(branch_id);
    print(mem_id);
    // int branchId = int.parse(branch_id);
    // int memberId = int.parse(mem_id);
    final url =
        "https://www.svgs.co/api/clearCart?brch_id=$branch_id&unique_id=$uniqueId&mem_id=$mem_id";
    try {
      final response = await http.get(Uri.parse(url));
      print(response.body);
      _items.clear();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> removeSingleItem(String id) async {
    final url = "https://www.svgs.co/api/removeCart?id=$id";
    print("checking========================================url");
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      print(response.body);
      _items.removeWhere((cart) => cart.cartId == id);
      notifyListeners();
      success_rmove_cart = 1;
    } catch (error) {
      throw error;
    }
  }
}
