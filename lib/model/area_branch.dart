import 'package:flutter/foundation.dart';

class AreaBranch {
  final String branchid;
  final String pin;
  final String area;
  final String message;
  final String no_of_orders;

  AreaBranch(
      {@required this.branchid,
      @required this.pin,
      @required this.area,
      @required this.message,
      @required this.no_of_orders});
}
