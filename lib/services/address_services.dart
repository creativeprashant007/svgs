import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:svgs_app/model/address_model.dart';

Future<String> _loadProduct() async {
  return await rootBundle.loadString('assets/address.json');
}
