import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:svgs_app/model/send_otp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddAddressProvider with ChangeNotifier {
  List<SendOTP> _sendOtp_response = [];

  String success;
  String error;
  String message;

  //http://www.svgs.co/api/addAddress?edit_id=INSERTED ID&mem_id=1&name=bbbaaa&mobile=8282828282&address=123,test%20addr&postcode=605001&area_id=590&area=Pondicherry&state=Pondicherry&city=Pondicherry&landmark=near%20school&ctry=IN

  Future<void> fetchAndSetAddAddress(
      String mem_id,
      String name,
      String mobile,
      String address,
      String postcode,
      String area_id,
      String area,
      String city,
      String landmark,
      String ship_id) async {
    print(mem_id);
    String url;
    if (ship_id == '0') {
      url =
          'https://www.svgs.co/api/addAddress?mem_id=$mem_id&name=$name&mobile=$mobile&address=$address&postcode=$postcode&area_id=$area_id&area=$area&state=Pondicherry&city=$city&landmark=$landmark&ctry=IN';
      print('place_order_done-----------------------0000000');
      print(url);
    } else {
      url =
          'https://www.svgs.co/api/addAddress?edit_id=$ship_id&mem_id=$mem_id&name=$name&mobile=$mobile&address=$address&postcode=$postcode&area_id=$area_id&area=$area&state=Pondicherry&city=$city&landmark=$landmark&ctry=IN';
      print('place_order_done-----------------------');
      print(url);
    }

    try {
      final response = await http.get(Uri.parse(url));
      print(response);

      final extractedPlace = json.decode(response.body);

      print("pppppppppppppppppppppp");
      print(extractedPlace['success']);

      success = extractedPlace['success'].toString();
      error = extractedPlace['error'].toString();
      message = extractedPlace['message'].toString();

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
