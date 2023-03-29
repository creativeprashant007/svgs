import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:svgs_app/helpers/db_helper.dart';

class ApiProviders with ChangeNotifier {
  String uniqueId;

  String _uniqueId = "";

  String get uid {
    return _uniqueId;
  }

  Future<void> uniqueIdApi() async {
    //print('hello');
    final url = 'https://www.svgs.co/api/createuniqueid';
    print('url is ' + url);
    try {
      final response = await http.get(Uri.parse(url));
      final extractedResponse = json.decode(response.body);

      print('heserssssssss' + response.body);

      uniqueId = extractedResponse['uniqueid'].toString();
      print('heserssssssss');
      print(uniqueId);

      notifyListeners();
      final dataList = await DBHelper.getData('unique_id');
      if (dataList.length < 1) {
        DBHelper.insertUniqueId('unique_id', {
          'id': uniqueId,
        });
      }
    } catch (error) {
      print('error123' + "-------------------------------------------");
      print('error123' + error);
    }
  }

  Future<void> fetchAndSetUniqueId() async {
    final dataList = await DBHelper.getData('unique_id');
    // _uniqueId = dataList.map((e) => e['id']).toString();
    _uniqueId = dataList[0]['id'].toString().trim();
    //print(_uniqueId.split(',')[0]);
    //_uniqueId = _uniqueId.split(',')[0];
    print(_uniqueId);
    print("gyhyhyjhvjhjhvyhbh---------$_uniqueId");
    print(_uniqueId);
    notifyListeners();
  }
}
