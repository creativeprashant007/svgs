import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:svgs_app/helpers/db_user_details.dart';
import 'package:svgs_app/model/user_details.dart';

class UserDetailsProvider with ChangeNotifier {
  List<UserDetails> _userDetails = [];
  List<UserDetails> get userDetails {
    return [..._userDetails];
  }

  Future<void> storeUserData(
    String memberId,
    String name,
    String email,
    String phone,
    String areaId,
    String areaName,
  ) async {
    try {
      final dataList = await DBHelper.getData('user_data');
      if (dataList.length < 1) {
        DBHelper.insertUserData('user_data', {
          'memberId': memberId,
          'name': name,
          'email': email,
          'phone': phone,
          'areaId': areaId,
          'areaName': areaName,
        });
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchUserDetails() async {
    final dataList = await DBHelper.getData('user_data');
    _userDetails = dataList
        .map((userData) => UserDetails(
              memberId: userData['memberId'],
              name: userData['name'],
              email: userData['email'],
              phone: userData['phone'],
              areaId: userData['areaId'],
              areaName: userData['areaName'],
            ))
        .toList();
    //print(_userDetails[0].name);

    notifyListeners();
  }
}
