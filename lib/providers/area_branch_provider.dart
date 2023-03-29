import 'dart:collection';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:svgs_app/constants/IDClass.dart';
import 'package:svgs_app/helpers/db_area_branch.dart';
import 'dart:convert';

import 'package:svgs_app/model/area_branch.dart';

class AreaBranchProvider with ChangeNotifier {
  int success = 0;
  String branchid;
  String pin;
  String area;
  String message;
  String no_of_orders;

  String _branchid = "";
  String _pin = "";
  String _area = "";

  String get branch_id_v {
    print(
        "branch_id---branch_id------------------123---------------------------$_branchid");
    return _branchid;
  }

  String get area_v {
    return _area;
  }

  String get pin_v {
    return _pin;
  }

  Future<void> fetchAndSetBranch(String id) async {
    print(id);
    final url = 'https://www.svgs.co/api/setlocation?areaid=$id';

    print(url);

    try {
      final response = await http.get(Uri.parse(url));
      print(response);

      final extractedResponse = json.decode(response.body);

      print("Login_extractedLoginResponse");
      print(extractedResponse);

      branchid = extractedResponse['branchid'].toString();
      pin = extractedResponse['pin'].toString();
      area = extractedResponse['area'].toString();
      message = extractedResponse['message'].toString();
      no_of_orders = extractedResponse['no_of_orders'].toString();

      /*AreaBranch(
        branchid: res[0]['branchid'].toString(),
        pin: res[0]['pin'].toString(),
        area: res[0]['area'].toString(),
        message: res[0]['message'].toString(),
        no_of_orders: res[0]['no_of_orders'].toString()
        );*/

      notifyListeners();

      print("AreaBranch---------------------123---------------------------");
      print(branchid);
      print(pin);
      print(area);

      IDCardClass.branch_id_v = branchid;
      IDCardClass.area_v = area;
      IDCardClass.pin_v = pin;

      final dataList = await DBHelperBranch.getData('area_data');

      print("data_list================================");
      print(dataList.length);

      if (dataList.length < 1) {
        DBHelperBranch.insertAreaBranchId(
            'area_data', {'branchid': branchid, 'pin': pin, 'area': area});
      } else {
        DBHelperBranch.deleteUser();
        DBHelperBranch.insertAreaBranchId(
            'area_data', {'branchid': branchid, 'pin': pin, 'area': area});
      }

      success = 1;
      print(
          "DBHelperBranch---------------------123---------------------------");
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAreaDetails() async {
    final dataList = await DBHelperBranch.getData('area_data');

    print(
        "dataList---------------------123---------------------------$dataList");

    if (!dataList.isEmpty) {
      _branchid = dataList[0]['branchid'].toString();
      _pin = dataList[0]['pin'].toString();
      _area = dataList[0]['area'].toString();

      print(_branchid);

      print(
          "_branchid---------------------123---------------------------$_branchid");
      print("_pin---------------------123---------------------------$_pin");
      print("_area---------------------123---------------------------$_area");
    } else {
      _branchid = "";
      _pin = "";
      _area = "";
    }

    notifyListeners();
  }

/* List<SendOTP> get response_items {
    return [..._sendOtp_response];
  }*/

}
