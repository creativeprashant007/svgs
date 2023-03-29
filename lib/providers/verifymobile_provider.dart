import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:svgs_app/model/send_otp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyMobileProvider with ChangeNotifier {
  int success;
  int error;
  var otp;

  Future<void> fetchAndSetVerifyMobile(
      String id, String mob_v, String number) async {
    print(number);
    final url = Uri.parse(
        'https://www.svgs.co/api/verifymobile?mem_id=$id&mobotp_verify=0&phone=$number');
    try {
      final response = await http.get(url);
      print(response);

      final extractedSendOTP = json.decode(response.body);

      print("pppppppppppppppppppppp");
      print(extractedSendOTP['success']);

      success = extractedSendOTP['success'];
      error = extractedSendOTP['error'];

      if (success == 1) {
        otp = extractedSendOTP['otp'];

        print(otp);
      } else {}

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
