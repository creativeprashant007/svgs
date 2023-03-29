import 'dart:collection';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterProvider with ChangeNotifier {
  HashMap<String, dynamic> _lreg_success_response =
      new HashMap<String, dynamic>();
  List<HashMap<String, dynamic>> list_success_res;
  int success;
  int error;

  Future<void> fetchAndSetReg(
      String nName,
      String last_name,
      String nEmail,
      String nPhoneNumber,
      String nPassord,
      String nAddress,
      String area_country,
      String area_pin,
      String area_id,
      String area_name,
      String area_state,
      String area_city) async {
    print(nName);
    final url =
        'https://www.svgs.co/api/signUp?first_name=$nName&last_name=$last_name&email=$nEmail&phone=$nPhoneNumber&password=$nPassord&address1=$nAddress&country=IN&postcode=$area_pin&area_id=$area_id&area=$area_name&state=$area_state&city=$area_city';

    print(url);

    try {
      final response = await http.get(Uri.parse(url));
      print(response);

      final extractedResponse = json.decode(response.body) as List;

      print("Login_extractedLoginResponse");
      print(extractedResponse[0]['success']);

      success = extractedResponse[0]['success'];
      error = extractedResponse[0]['error'];

      print("extractedLoginResponse");
      print(success);
      print(error);

      if (success == 1) {
        //_login_success_response.add(extractedLoginResponse[0]['user']);

        var json = extractedResponse[0]['user'];
        print("json-------------------------------------------$json");

        var first_name = json['first_name'];
        var last_name = json['last_name'];
        var email = json['email'];
        var phone = json['phone'];
        var address1 = json['address1'];
        var address2 = json['address2'];
        var country = json['country'];
        var postcode = json['postcode'];
        var area_id = json['area_id'];
        var area_name = json['area_name'];
        var state = json['state'];
        var city = json['city'];
        var updated_at = json['updated_at'];
        var created_at = json['created_at'];
        var id = json['id'];
        var address_id = json['address_id'];
        var name = json['name'];

        print("id-------------------------------------------$id");
        list_success_res = new List<HashMap<String, dynamic>>();

        _lreg_success_response['id'] = id;
        _lreg_success_response['name'] = name;
        _lreg_success_response['email'] = email;
        _lreg_success_response['phone'] = phone;

        _lreg_success_response['postcode'] = postcode;
        _lreg_success_response['address1'] = address1;
        _lreg_success_response['address2'] = address2;
        _lreg_success_response['area_id'] = area_id;
        _lreg_success_response['area_name'] = area_name;
        _lreg_success_response['city'] = city;
        _lreg_success_response['state'] = state;
        _lreg_success_response['country'] = country;

        print("success-------------------------------------------");
        print(_lreg_success_response);

        list_success_res.add(_lreg_success_response);
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
