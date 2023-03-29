import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:svgs_app/model/Common_Model.dart';

import 'package:svgs_app/model/delivery_address.dart';
import 'package:http/http.dart' as http;
import 'package:svgs_app/model/timeslot.dart';

class CommonProvider with ChangeNotifier {
  List<CommonBranchDetails> _branch_list = [];
  String android_version = "1";
  String ios_version = "1";

  Future<void> fetchAndSetCommon() async {
    const url = 'https://www.svgs.co/api/commonServices';
    try {
      final response = await http.get(Uri.parse(url));

      final extractedCats = json.decode(response.body);
      print(response.body);

      print("shariyath==========================================");

      print(extractedCats);

      android_version = extractedCats['android_version'] as String;
      ios_version = extractedCats['ios_version'] as String;

      print("android_version==========================================");
      print(android_version);
      print(ios_version);

      final extractedRes = extractedCats['branch_details'] as List;

      final List<CommonBranchDetails> loadedItem = [];
      extractedRes.forEach((branch) {
        // print((topDeal['item_sellprice'].split(','))[0]);
        loadedItem.add(
          CommonBranchDetails(
            id: branch['id'].toString(),
            brch_name: branch['brch_name'],
            brch_area: branch['brch_area'],
            brch_pincode: branch['brch_pincode'].toString(),
            brch_address: branch['brch_address'],
            brch_city: branch['brch_city'],
            brch_state: branch['brch_state'],
            brch_country: branch['brch_country'],
            brch_phone: branch['brch_phone'],
            brch_mobile: branch['brch_mobile'],
          ),
        );
        _branch_list = loadedItem;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  List<CommonBranchDetails> get branch_items {
    return [..._branch_list];
  }
}
