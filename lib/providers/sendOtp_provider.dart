import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:svgs_app/model/send_otp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SendOtpProvider with ChangeNotifier {
  List<SendOTP> _sendOtp_response = [];

  int success;
  int error;
  int otp;

  Future<void> fetchAndSetSendOTP(String number) async {
    print(number);
    final url = 'https://www.svgs.co/api/sendOtp?phone=' + number;
    try {
      final response = await http.get(Uri.parse(url));
      print(response);

      final extractedSendOTP = json.decode(response.body) as List;

      print("pppppppppppppppppppppp");
      print(extractedSendOTP[0]['success']);

      success = extractedSendOTP[0]['success'];
      error = extractedSendOTP[0]['error'];
      otp = extractedSendOTP[0]['otp'];

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
