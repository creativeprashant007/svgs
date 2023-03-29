import 'package:flutter/material.dart';
import 'package:svgs_app/model/address_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AreaProvider with ChangeNotifier {
  List<AreaDetails> _area_list = [];

  Future<void> fetchAndSetArea(String area_name) async {
    final url =
        'https://www.svgs.co/api/areasearchbyhome?searchTerm=' + area_name;
    print("Checking_process----------------------homepage");
    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      final extractedCats = json.decode(response.body) as List;
      print(response.body);

      final List<AreaDetails> loadedItem = [];
      extractedCats.forEach((res) {
        // print((topDeal['item_sellprice'].split(','))[0]);
        loadedItem.add(
          AreaDetails(
            id: res['id'].toString(),
            area_name: res['area_name'].toString(),
            area_latitute: res['area_latitute'].toString(),
            area_longitute: res['area_longitute'].toString(),
            area_pincode: res['area_pincode'].toString(),
            area_city: res['area_city'].toString(),
            area_state: res['area_state'].toString(),
            area_country: res['area_country'].toString(),
            area_status: res['area_status'].toString(),
          ),
        );
        _area_list = loadedItem;

        print("testing_purpose=========================");
        print(loadedItem);
        print(_area_list);

        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  List<AreaDetails> get area_items {
    return [..._area_list];
  }
}
