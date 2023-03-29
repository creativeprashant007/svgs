import 'package:flutter/foundation.dart';

class SendOTP {
  final int success;
  final int error;
  final int otp;

  SendOTP({@required this.success, @required this.error, @required this.otp});
}
