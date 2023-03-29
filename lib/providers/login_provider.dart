import 'dart:collection';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginProvider with ChangeNotifier {
  HashMap<String, dynamic> _login_success_response =
      new HashMap<String, dynamic>();
  List<HashMap<String, dynamic>> list_success_res;
  int success;
  int error;

  Future<void> fetchAndSetLogin(
      String number, String otp, String unique_id) async {
    print(number);
    final url =
        'https://www.svgs.co/api/loginWithOtp?phone=$number&otp=$otp&unique_id=$unique_id';

    print(
        "======================================url====================================");
    print(url);

    try {
      final response = await http.get(Uri.parse(url));
      print(response);

      final extractedLoginResponse = json.decode(response.body) as List;

      print("Login_extractedLoginResponse");
      print(extractedLoginResponse[0]['success']);

      success = extractedLoginResponse[0]['success'];
      error = extractedLoginResponse[0]['error'];

      print("extractedLoginResponse");
      print(success);
      print(error);

      if (success == 1) {
        //_login_success_response.add(extractedLoginResponse[0]['user']);

        var json = extractedLoginResponse[0]['user'];
        print("json-------------------------------------------$json");

        var id = json['id'];
        var name = json['name'];
        var email = json['email'];
        var mobotp_verify = json['mobotp_verify'];
        var postcode = json['postcode'];
        var address1 = json['address1'];
        var address2 = json['address2'];
        var area_id = json['area_id'];
        var area_name = json['area_name'];
        var city = json['city'];
        var state = json['state'];
        var country = json['country'];
        var phone = json['phone'];

        var status = json['status'];
        var group = json['group'];

        print("id-------------------------------------------$id");
        list_success_res = new List<HashMap<String, dynamic>>();

        _login_success_response['id'] = id;
        _login_success_response['name'] = name;
        _login_success_response['email'] = email;
        _login_success_response['phone'] = phone;

        _login_success_response['postcode'] = postcode;
        _login_success_response['address1'] = address1;
        _login_success_response['address2'] = address2;
        _login_success_response['area_id'] = area_id;
        _login_success_response['area_name'] = area_name;
        _login_success_response['city'] = city;
        _login_success_response['state'] = state;
        _login_success_response['country'] = country;

        print("success-------------------------------------------");
        print(_login_success_response);

        list_success_res.add(_login_success_response);
        print(list_success_res);
      }
    } catch (error) {
      throw error;
    }
  }

/* List<SendOTP> get response_items {
    return [..._sendOtp_response];
  }*/

}
