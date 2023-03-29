import 'package:flutter/cupertino.dart';

class UserDetails {
  final int id;
  final String memberId;
  final String name;
  final String email;
  final String phone;
  final String areaId;
  final String areaName;

  UserDetails({
    this.id,
    @required this.memberId,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.areaId,
    @required this.areaName,
  });
}
