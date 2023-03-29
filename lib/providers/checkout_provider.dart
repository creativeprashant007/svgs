import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:svgs_app/model/delivery_address.dart';
import 'package:http/http.dart' as http;
import 'package:svgs_app/model/timeslot.dart';

class CheckoutProvider with ChangeNotifier {
  int success = 0;
  int error = 0;
  String standardTimeSlot = '';
  List<DeliveryAddress> _addresses = [];
  List<StandardDate> _dates = [];
  List<StandardDelivery> _standardDelivery = [];

  List<DeliveryAddress> get addresses {
    return [..._addresses];
  }

  List<StandardDate> get dates {
    return [..._dates];
  }

  List<StandardDelivery> get standardDelivery {
    return [..._standardDelivery];
  }

  Future<void> fetchAndSetTimes() async {
    final url = "https://www.svgs.co/api/timeSlot";
    try {
      final response = await http.get(Uri.parse(url));

      final extractedData =
          json.decode(response.body)['standard_delivery'] as List;
      standardTimeSlot =
          json.decode(response.body)['standard_timeslot'].toString();
      final List<StandardDelivery> loadedItem = [];
      extractedData.forEach((standard_delivery) {
        loadedItem.add(
          StandardDelivery(
            fromTime: standard_delivery['from_time'],
            toTime: standard_delivery['to_time'],
            noOfOrders: standard_delivery['no_of_orders'],
            id: standard_delivery['id'].toString(),
          ),
        );
        _standardDelivery = loadedItem;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetDates() async {
    final url = "https://www.svgs.co/api/timeSlot";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body)['standard_date'] as List;
      standardTimeSlot =
          json.decode(response.body)['standard_timeslot'].toString();
      final List<StandardDate> loadedItem = [];
      extractedData.forEach((date) {
        loadedItem.add(
          StandardDate(date: date, date_pos: 0),
        );
        _dates = loadedItem;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetDeliveryAddress(String mem_id) async {
    final url = "https://www.svgs.co/api/shipping?mem_id=$mem_id";
    print("shipping_adddres====================");
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData =
          (json.decode(response.body)['shipping_details']) as List;
      //  print(extractedData);
      final List<DeliveryAddress> loadedItem = [];

      extractedData.forEach((address) {
        loadedItem.add(
          DeliveryAddress(
            id: address['id'].toString(),
            shipCustId: address['ship_custid'].toString(),
            shipName: address['ship_name'],
            email: address['email'],
            shipMobile: address['ship_mobile'].toString(),
            shipAddress: address['ship_address'],
            shipLandmark: address['ship_landmark'],
            shipPinCode: address['ship_pincode'].toString(),
            shipAreaId: address['ship_areaid'].toString(),
            shipArea: address['ship_area'],
            shipCity: address['ship_city'],
            shipState: address['ship_state'],
            shipCountry: address['ship_country'],
            shipDefaultAdd: address['ship_default_add'].toString(),
            shipLastEdit: address['ship_lastedit'],
            shipEditIp: address['ship_editip'],
            shipAddStatus: address['ship_add_status'].toString(),
          ),
        );
        _addresses = loadedItem.reversed.toList();
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndRemoveAddress(String ship_id) async {
    final url = "https://www.svgs.co/api/removeShipping?id=$ship_id";
    print("remove_adddress------------------");
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      success = json.decode(response.body)['success'];
      print("remove_adddress------------------$success");
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
