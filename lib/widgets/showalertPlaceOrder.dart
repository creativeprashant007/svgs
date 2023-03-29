import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/ui/home/homepage.dart';

import 'package:svgs_app/widgets/checkout/order_list.dart';

import '../main.dart'; // test

class PlaceOrderDialog extends StatefulWidget {
  PlaceOrderDialog({this.id});

  final String id;
  /* final String number;
  final String mob_v;
  final String otp;*/

/*  final String str_message;
  final String str_message_hint;
  final String str_btn;*/

  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<PlaceOrderDialog> {
  String _id;
  String _number;
  String _mob_v;
  String _otp;
  String nOtp = "";
  bool _isLoggedIn = false;
  String userUniqueId = '';
  String userBranchId = '';

  String userMemberId = '';

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _id = widget.id;
    /*  _number = widget.number;
    _mob_v = widget.mob_v;
    _otp = widget.otp;*/

    userUniqueId = Provider.of<ApiProviders>(context, listen: false).uid;
    userBranchId =
        Provider.of<AreaBranchProvider>(context, listen: false).branch_id_v;
    userMemberId = Provider.of<UserDetailsProvider>(context, listen: false)
        .userDetails[0]
        .memberId;
    callCart();

    super.initState();
  }

  Future<void> callCart() async {
    setState(() {
      Provider.of<CartProvider>(context, listen: false)
          .fetchAndSetCartItem(userBranchId, userUniqueId, userMemberId);
    });
    Provider.of<CartProvider>(context, listen: false)
        .clearCart(userUniqueId, userMemberId, userBranchId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).orientation == Orientation.portrait;
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: ModalProgressHUD(
            inAsyncCall: _isLoggedIn,
            child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0)), //this right here
                child: SingleChildScrollView(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: new Container(
                              color: Colors.white,
                              margin: new EdgeInsets.all(16.0),
                              width: double.infinity,
                              height: 96.0,
                              child: new Image.network(
                                  'https://www.svgs.co/data/logo/scart-mid.png',
                                  fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Order Successfully Placed",
                              style: TextStyles.h1Heading,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Thank you for your purchase!",
                              style: TextStyles.txt_14_black_normal,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Your Order $_id",
                              style: TextStyles.txt_14_black_normal,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Kindly note this order number for your future communication and tracking order",
                              textAlign: TextAlign.center,
                              style: TextStyles.txt_12_black_normal,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: InkWell(
                                      onTap: () {
                                        //_submit();
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          callCart();
                                          Navigator.of(context)
                                              .pushNamed(OrderList.routeName)
                                              .then((value) =>
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePage()),
                                                      ModalRoute.withName(
                                                          "/src/homepage")));
                                        },
                                        child: Container(
                                          width: 120.0,
                                          height: 40.0,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          alignment: Alignment.topCenter,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.grey.shade200,
                                                    offset: Offset(2, 4),
                                                    blurRadius: 5,
                                                    spreadRadius: 2)
                                              ],
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color(0xFF694489),
                                                    Color(0xFF694489),
                                                    Color(0xFF694489)
                                                  ])),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "View Order",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ))),
                              SizedBox(
                                width: 16,
                              ),
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: InkWell(
                                      onTap: () {
                                        callCart();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()),
                                            ModalRoute.withName(
                                                "/src/homepage"));
                                      },
                                      child: Container(
                                        width: 120.0,
                                        height: 40.0,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.grey.shade200,
                                                  offset: Offset(2, 4),
                                                  blurRadius: 5,
                                                  spreadRadius: 2)
                                            ],
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Color(0xFF28a745),
                                                  Color(0xFF28a745),
                                                  Color(0xFF28a745)
                                                ])),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Continue",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ))),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
