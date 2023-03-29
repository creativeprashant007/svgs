import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:svgs_app/model/send_otp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceOrderProvider with ChangeNotifier {
  List<SendOTP> _sendOtp_response = [];

  String success;
  String error;
  String order_id;

  Future<void> fetchAndSetPlaceOrder({
    String branch_id,
    String mem_id,
    String deli_type,
    String deli_date,
    String delivery_slot,
    String custaddr_id,
    String need_prod,
    String take_branch,
    String platform_os,
    String payment_status,
    String payment_method,
    String razor_pay_id,
  }) async {
    print(branch_id);
    final url =
        'https://www.svgs.co/api/postCheckout?brch_id=$branch_id&mem_id=$mem_id&deli_type=$deli_type&deli_date=$deli_date&delivery_slot=$delivery_slot&custaddr_id=$custaddr_id&need_prod=$need_prod&take_branch=$take_branch&mob_type=$platform_os';
    print('place_order_done-----------------------');
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      print(response);

      final extractedPlace = json.decode(response.body);

      print("pppppppppppppppppppppp");
      print(extractedPlace['success']);

      success = extractedPlace['success'].toString();
      error = extractedPlace['error'].toString();
      order_id = extractedPlace['order_id'].toString();

      print("qqqqqqqqqqqqqqqqqqqqqqq");
      print(success);
      print(error);
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetPlaceOrderRz({
    String branch_id,
    String mem_id,
    String deli_type,
    String deli_date,
    String delivery_slot,
    String custaddr_id,
    String need_prod,
    String take_branch,
    String platform_os,
    String payment_status,
    String payment_method,
    String razor_pay_id,
  }) async {
    print(branch_id);
    final url =
        'https://www.svgs.co/api/postCheckoutRz?brch_id=$branch_id&mem_id=$mem_id&deli_type=$deli_type&deli_date=$deli_date&delivery_slot=$delivery_slot&custaddr_id=$custaddr_id&need_prod=$need_prod&take_branch=$take_branch&mob_type=$platform_os&payment_status=$payment_status&payment_method=$payment_method&razor_pay_id=$razor_pay_id';
    print('place_order_done-----------------------');
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      print(response);

      final extractedPlace = json.decode(response.body);

      print("pppppppppppppppppppppp");
      print(extractedPlace['success']);

      success = extractedPlace['success'].toString();
      error = extractedPlace['error'].toString();
      order_id = extractedPlace['order_id'].toString();

      print("qqqqqqqqqqqqqqqqqqqqqqq");
      print(success);
      print(error);
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetPlaceOrderCod({
    String branch_id,
    String mem_id,
    String deli_type,
    String deli_date,
    String delivery_slot,
    String custaddr_id,
    String need_prod,
    String take_branch,
    String platform_os,
    String payment_status,
    String payment_method,
    String razor_pay_id,
  }) async {
    print(branch_id);
    final url =
        'https://www.svgs.co/api/postCheckoutRz?brch_id=$branch_id&mem_id=$mem_id&deli_type=$deli_type&deli_date=$deli_date&delivery_slot=$delivery_slot&custaddr_id=$custaddr_id&need_prod=$need_prod&take_branch=$take_branch&mob_type=$platform_os&payment_status=$payment_status&payment_method=$payment_method&razor_pay_id=$razor_pay_id';
    print('place_order_done-----------------------');
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      print(response);

      final extractedPlace = json.decode(response.body);
      print(extractedPlace);
      print("pppppppppppppppppppppp");
      print(extractedPlace['success']);

      success = extractedPlace['success'].toString();
      error = extractedPlace['error'].toString();
      order_id = extractedPlace['order_id'].toString();

      print("qqqqqqqqqqqqqqqqqqqqqqq");
      print(success);
      print(error);
    } catch (error) {
      throw error;
    }
  }

/* List<SendOTP> get response_items {
    return [..._sendOtp_response];
  }*/

}
