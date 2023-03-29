import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:svgs_app/model/orders_list.dart';
import 'package:http/http.dart' as http;

class OrderListProvider with ChangeNotifier {
  List<Orders> _orders = [];

  List<Orders> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders(String mem_id) async {
    int memberId = int.parse(mem_id);
    final url = "https://www.svgs.co/api/orders?mem_id=$memberId";
    print("url===========================");
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      final extratedData = json.decode(response.body)['order']['data'] as List;
      print(extratedData);
      final List<Orders> loadedOrder = [];
      extratedData.forEach((orderData) {
        print('started');
        loadedOrder.add(
          Orders(
            id: orderData['id'].toString(),
            userId: orderData['user_id'].toString(),
            goFrugalId: orderData['gofrugal_id'].toString(),
            goFrugalMsg: orderData['gofrugal_msg'].toString(),
            orderShowId: orderData['order_showid'].toString(),
            orderBranchId: orderData['order_branchid'].toString(),
            orderDeliverType: orderData['order_deliverytype'].toString(),
            orderDeliverDate: orderData['order_deliverydate'].toString(),
            orderDeliverFromTime: orderData['order_deliveryfmtime'].toString(),
            orderDeliverToTime: orderData['order_deliverytotime'].toString(),
            orderShippingId: orderData['order_shippingid'].toString(),
            order_itemcount: orderData['order_itemcount'].toString(),
            subTotal: orderData['subtotal'].toString(),
            shipping: orderData['shipping'].toString(),
            discount: orderData['discount'].toString(),
            paymentStatus: orderData['payment_status'].toString(),
            shippingStatus: orderData['shipping_status'].toString(),
            status: orderData['status'].toString(),
            updatedBy: orderData['updated_by'].toString(),
            tax: orderData['tax'].toString(),
            total: orderData['total'].toString(),
            currency: orderData['currency'].toString(),
            exchangeRate: orderData['exchange_rate'].toString(),
            received: orderData['received'].toString(),
            balance: orderData['balance'].toString(),
            firstName: orderData['first_name'].toString(),
            lastName: orderData['last_name'].toString(),
            address1: orderData['address1'].toString(),
            address2: orderData['address2'].toString(),
            city: orderData['city'].toString(),
            state: orderData['state'].toString(),
            country: orderData['country'].toString(),
            company: orderData['company'].toString(),
            postCode: orderData['postcode'].toString(),
            phone: orderData['phone'].toString(),
            email: orderData['email'].toString(),
            comment: orderData['comment'].toString(),
            paymentMethod: orderData['payment_method'].toString(),
            shippingMethod: orderData['shipping_method'].toString(),
            needProd: orderData['need_prod'].toString(),
            userAgent: orderData['user_agent'].toString(),
            ip: orderData['ip'].toString(),
            transaction: orderData['transaction'].toString(),
            createdAt: orderData['created_at'].toString(),
            updatedAt: orderData['updated_at'].toString(),
          ),
        );
        print('ended');
        _orders = loadedOrder;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  List<OrderDetails> _orderDetails = [];

  List<OrderDetails> get orderDetails {
    return [..._orderDetails];
  }

  String orderId = '';
  String orderDate = '';
  String orderStatus = '';
  String totalAmount = '';
  String paymentMethos = '';

  Future<void> fetchAndSetOrderDetails(String orderId, String mem_id) async {
    final url = "https://www.svgs.co/api/orders/$orderId?mem_id=$mem_id";
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      final extratedData = json.decode(response.body)['orderdetails'] as List;
      print('here============prderDetails');

      print(extratedData);
      final List<OrderDetails> loadedOrder = [];
      extratedData.forEach((orderDetail) {
        print('started');
        loadedOrder.add(OrderDetails(
          id: orderDetail['id'].toString(),
          order_id: orderDetail['order_id'].toString(),
          product_id: orderDetail['product_id'].toString(),
          item_id: orderDetail['item_id'].toString(),
          name: orderDetail['name'].toString(),
          price: orderDetail['price'].toString(),
          qty: orderDetail['qty'].toString(),
          total_price: orderDetail['total_price'].toString(),
          tax: orderDetail['tax'].toString(),
          sku: orderDetail['sku'].toString(),
          currency: orderDetail['currency'].toString(),
          exchange_rate: orderDetail['exchange_rate'].toString(),
          attribute: orderDetail['attribute'].toString(),
          created_at: orderDetail['created_at'].toString(),
          updated_at: orderDetail['updated_at'].toString(),
        ));
        print('ended');
        _orderDetails = loadedOrder;
        notifyListeners();
      });
    } catch (error) {
      //throw error;
    }
  }
}
