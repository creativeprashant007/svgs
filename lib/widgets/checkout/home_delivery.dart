import 'dart:convert';
import '../../widgets/cap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/model/payment_methods.dart';
import 'package:svgs_app/model/transaction_error_response.dart';
import 'package:svgs_app/networking/network/apis.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/providers/checkout_provider.dart';
import 'package:svgs_app/providers/placeorder_provider.dart';
import 'package:svgs_app/providers/product_cart_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/widgets/checkout/add_new_address.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:svgs_app/widgets/simmer/checkout_simmers.dart';
import '../showalertPlaceOrder.dart';

class HomeDelivery extends StatefulWidget {
  @override
  _HomeDeliveryState createState() => _HomeDeliveryState();
}

class _HomeDeliveryState extends State<HomeDelivery> {
  ProductCartProvider _productCartProvider;
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  bool _expanded = false;
  bool _dateSelect = false;
  bool _timeSelect = false;
  var _paymentMethod = "COD";
  Razorpay _razorpay;

  List<int> add_pos = [];
  List<int> dates_pos = [];
  List<int> time_pos = [];
  List dates_dynamic = [];
  List time_dynamic = [];
  List address_dynamic = [];

  String deli_type = '1';
  String deli_date = '';
  String delivery_slot = '';
  String custaddr_id = '';
  String need_prod = '';
  String take_branch = '';
  bool _isLoggedIn = false;
  String shipping_id = '';
  bool _hide_delete_ic = false;

  Future<void> shipping_addres(String mem_id) async {
    print("checking==================date_res");

    try {
      await Provider.of<CheckoutProvider>(
        context,
        listen: false,
      ).fetchAndSetDeliveryAddress(mem_id);

      if (!add_pos.isEmpty) {
        add_pos.clear();
      }

      if (!Provider.of<CheckoutProvider>(
        context,
        listen: false,
      ).addresses.isEmpty) {
        for (int i = 0;
            i <
                Provider.of<CheckoutProvider>(
                  context,
                  listen: false,
                ).addresses.length;
            i++) {
          print('think_before');
          print(Provider.of<CheckoutProvider>(
            context,
            listen: false,
          ).addresses.length);
          print(i);
          if (i == 0
              // Provider.of<CheckoutProvider>(
              //   context,
              //   listen: false,
              // ).addresses.length

              ) {
            add_pos.add(1);
            custaddr_id = Provider.of<CheckoutProvider>(
              context,
              listen: false,
            ).addresses[i].id.toString();
          } else {
            add_pos.add(0);
          }
          //dates_pos.add(i);

        }
        address_dynamic = Provider.of<CheckoutProvider>(
          context,
          listen: false,
        ).addresses;
        // address_dynamic[0].isSelected = true;
        // var listOfAdd = address_dynamic;
        // int index = listOfAdd.indexWhere((element) => element.isSelected);
        // final item = listOfAdd.removeAt(index);
        // listOfAdd.insert(0, item);
        // setState(() {
        //   address_dynamic = listOfAdd;
        // });

        if (Provider.of<CheckoutProvider>(
              context,
              listen: false,
            ).addresses.length ==
            1) {
          _hide_delete_ic = false;
        } else {
          _hide_delete_ic = true;
        }
      }

      setState(() {});
    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  }

  Future<void> date_res() async {
    print("checking==================date_res");

    try {
      await Provider.of<CheckoutProvider>(
        context,
        listen: false,
      ).fetchAndSetDates();

      if (!Provider.of<CheckoutProvider>(
        context,
        listen: false,
      ).dates.isEmpty) {
        for (int i = 0;
            i <
                Provider.of<CheckoutProvider>(
                  context,
                  listen: false,
                ).dates.length;
            i++) {
          if (i == 0) {
            dates_pos.add(1);

            final date_v =
                DateFormat('dd-MM-yyyy').parse(Provider.of<CheckoutProvider>(
              context,
              listen: false,
            ).dates[i].date);
            print("pppppppppppppppppppppppppppppppppppppppp");
            deli_date = DateFormat('yyyy-MM-dd').format(date_v).toString();

            print(deli_date);
          } else {
            dates_pos.add(0);
          }
          //dates_pos.add(i);

        }
        dates_dynamic = Provider.of<CheckoutProvider>(
          context,
          listen: false,
        ).dates;
      }

      print("checking_vera_level============================view_cartddd");
      print(
          "checking_vera_level============================view_cart$dates_pos");
      //  print(dates);
      setState(() {});
    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  } // refresh_view_cart

  Future<void> time_res() async {
    try {
      await Provider.of<CheckoutProvider>(
        context,
        listen: false,
      ).fetchAndSetTimes();

      if (!time_dynamic.isEmpty) {
        time_dynamic.clear();
      }
      if (!time_pos.isEmpty) {
        time_pos.clear();
      }
      if (!Provider.of<CheckoutProvider>(
        context,
        listen: false,
      ).standardDelivery.isEmpty) {
        for (int i = 0;
            i <
                Provider.of<CheckoutProvider>(
                  context,
                  listen: false,
                ).standardDelivery.length;
            i++) {
          if (i == 0) {
            //  time_dynamic.add(Provider.of<CheckoutProvider>(context,listen:false,).standardDelivery);
            final v = Provider.of<CheckoutProvider>(
              context,
              listen: false,
            ).standardDelivery;
            final standardTimeSlot = Provider.of<CheckoutProvider>(
              context,
              listen: false,
            ).standardTimeSlot;

            if (DateFormat("HH:mm")
                .parse(Provider.of<CheckoutProvider>(
                  context,
                  listen: false,
                ).standardTimeSlot)
                .isBefore(
                    DateFormat("HH:mm").parse(Provider.of<CheckoutProvider>(
                  context,
                  listen: false,
                ).standardDelivery[i].fromTime.toString()))) {
              print('123DateFormat=======================1234567890');
              Map<String, dynamic> data = new Map<String, dynamic>();

              data['id'] = v[i].id;
              data['fromTime'] = v[i].fromTime;
              data['toTime'] = v[i].toTime;

              time_dynamic.add(data);

              final str_ft =
                  DateFormat("HH:mm:ss").parse(Provider.of<CheckoutProvider>(
                context,
                listen: false,
              ).standardDelivery[i].fromTime);
              final str_tt =
                  DateFormat("HH:mm:ss").parse(Provider.of<CheckoutProvider>(
                context,
                listen: false,
              ).standardDelivery[i].toTime);

              String str_from_time =
                  DateFormat("HH:mm").format(str_ft).toString();
              String str_to_time =
                  DateFormat("HH:mm").format(str_tt).toString();

              print("time_slot_checking--------------------------");
              print(str_from_time + "n" + str_to_time);

              delivery_slot = str_from_time + "||" + str_to_time;
            } else {
              print('456DateFormat=======================1234567890');
            }

            print('WHAT ARE YOU LOOKING FORWARD=======================');
            print(time_dynamic);
            print(standardTimeSlot);

            time_pos.add(1);
          } else {
            final v = Provider.of<CheckoutProvider>(
              context,
              listen: false,
            ).standardDelivery;
            if (DateFormat("HH:mm")
                .parse(Provider.of<CheckoutProvider>(
                  context,
                  listen: false,
                ).standardTimeSlot)
                .isBefore(
                    DateFormat("HH:mm").parse(Provider.of<CheckoutProvider>(
                  context,
                  listen: false,
                ).standardDelivery[i].fromTime.toString()))) {
              Map<String, dynamic> data = new Map<String, dynamic>();

              data['id'] = v[i].id;
              data['fromTime'] = v[i].fromTime;
              data['toTime'] = v[i].toTime;

              time_dynamic.add(data);

              final str_ft =
                  DateFormat("HH:mm:ss").parse(Provider.of<CheckoutProvider>(
                context,
                listen: false,
              ).standardDelivery[i].fromTime);
              final str_tt =
                  DateFormat("HH:mm:ss").parse(Provider.of<CheckoutProvider>(
                context,
                listen: false,
              ).standardDelivery[i].toTime);

              String str_from_time =
                  DateFormat("HH:mm").format(str_ft).toString();
              String str_to_time =
                  DateFormat("HH:mm").format(str_tt).toString();

              print("time_slot_checking--------------------------");
              print(str_from_time + "n" + str_to_time);

              delivery_slot = str_from_time + "||" + str_to_time;
            } else {
              print('444444456DateFormat=======================1234567890');
            }
            time_pos.add(0);
          }
        }

        print('map_testing_purpose================================');
        print(time_dynamic);
        //time_dynamic = Provider.of<CheckoutProvider>(context).standardDelivery;
        setState(() {});
      } else {
        delivery_slot = '';
      }

      // parse date
      DateTime date = DateFormat.jm().parse("6:45 PM");
      DateTime date2 = DateFormat("HH:mm:ss")
          .parse("14:30:00"); // think this will work better for you
// format date
      print(DateFormat("HH:mm").format(date));
      print(DateFormat("hh:mma").format(date2));
      print("checking-----------------------------to_date");

      //  print(dates);

    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  }

  Future<void> all_time_res() async {
    try {
      await Provider.of<CheckoutProvider>(
        context,
        listen: false,
      ).fetchAndSetTimes();
      if (!time_dynamic.isEmpty) {
        time_dynamic.clear();
      }
      if (!time_pos.isEmpty) {
        time_pos.clear();
      }
      if (!Provider.of<CheckoutProvider>(
        context,
        listen: false,
      ).standardDelivery.isEmpty) {
        for (int i = 0;
            i <
                Provider.of<CheckoutProvider>(
                  context,
                  listen: false,
                ).standardDelivery.length;
            i++) {
          if (i == 0) {
            final str_ft =
                DateFormat("HH:mm:ss").parse(Provider.of<CheckoutProvider>(
              context,
              listen: false,
            ).standardDelivery[i].fromTime);
            final str_tt =
                DateFormat("HH:mm:ss").parse(Provider.of<CheckoutProvider>(
              context,
              listen: false,
            ).standardDelivery[i].toTime);

            String str_from_time =
                DateFormat("HH:mm").format(str_ft).toString();
            String str_to_time = DateFormat("HH:mm").format(str_tt).toString();

            print("123time_slot_checking--------------------------");
            print(str_from_time + "n" + str_to_time);

            delivery_slot = str_from_time + "||" + str_to_time;

            final v = Provider.of<CheckoutProvider>(
              context,
              listen: false,
            ).standardDelivery;
            Map<String, dynamic> data = new Map<String, dynamic>();

            data['id'] = v[i].id;
            data['fromTime'] = v[i].fromTime;
            data['toTime'] = v[i].toTime;

            time_dynamic.add(data);
            print(time_dynamic);
            time_pos.add(1);
          } else {
            final v = Provider.of<CheckoutProvider>(
              context,
              listen: false,
            ).standardDelivery;
            Map<String, dynamic> data = new Map<String, dynamic>();

            data['id'] = v[i].id;
            data['fromTime'] = v[i].fromTime;
            data['toTime'] = v[i].toTime;

            time_dynamic.add(data);
            time_pos.add(0);
          }
        }

        print('map_testing_purpose================================');
        print(time_dynamic);
        print('time_pos=============$time_pos');
        //time_dynamic = Provider.of<CheckoutProvider>(context,listen:false,).standardDelivery;
        setState(() {});
      } else {
        delivery_slot = '';
      }

      // parse date
      DateTime date = DateFormat.jm().parse("6:45 PM");
      DateTime date2 = DateFormat("HH:mm:ss")
          .parse("14:30:00"); // think this will work better for you
// format date
      print(DateFormat("HH:mm").format(date));
      print(DateFormat("hh:mma").format(date2));
      print("checking-----------------------------to_date");

      //  print(dates);

    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  }

  Future<void> place_order({
    String transactionId,
    String paymentStatus,
  }) async {
    final userDetails =
        Provider.of<UserDetailsProvider>(context, listen: false).userDetails;
    String mem_id;
    if (userDetails.isEmpty) {
      mem_id = '';
    } else {
      mem_id = Provider.of<UserDetailsProvider>(
        context,
        listen: false,
      ).userDetails[0].memberId.toString().trim();
    }
    final branch_id = Provider.of<AreaBranchProvider>(
      context,
      listen: false,
    ).branch_id_v;
    try {
      setState(() {
        _isLoggedIn = true;
      });

      var platform = Theme.of(
        context,
      ).platform;
      var is_platform = "4";

      if (platform == TargetPlatform.iOS) {
        is_platform = "3";
      } else {
        is_platform = "4";
      }
      if (_paymentMethod == "COD") {
        print('we are inside code:');
        await Provider.of<PlaceOrderProvider>(
          context,
          listen: false,
        ).fetchAndSetPlaceOrderCod(
          branch_id: branch_id,
          mem_id: mem_id,
          deli_type: deli_type,
          deli_date: deli_date,
          delivery_slot: delivery_slot,
          custaddr_id: custaddr_id,
          need_prod: need_prod,
          take_branch: take_branch,
          platform_os: is_platform,
          payment_method: _paymentMethod,
          payment_status: paymentStatus,
          razor_pay_id: transactionId,
        );
      } else {
        await Provider.of<PlaceOrderProvider>(
          context,
          listen: false,
        ).fetchAndSetPlaceOrderRz(
          branch_id: branch_id,
          mem_id: mem_id,
          deli_type: deli_type,
          deli_date: deli_date,
          delivery_slot: delivery_slot,
          custaddr_id: custaddr_id,
          need_prod: need_prod,
          take_branch: take_branch,
          platform_os: is_platform,
          payment_method: _paymentMethod,
          payment_status: paymentStatus,
          razor_pay_id: transactionId,
        );
      }

      var success = Provider.of<PlaceOrderProvider>(
        context,
        listen: false,
      ).success.toString();
      print("here is the success code");
      print(success);

      if (success == "1") {
        final order_id = Provider.of<PlaceOrderProvider>(
          context,
          listen: false,
        ).order_id.toString();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: ((BuildContext context) {
              return PlaceOrderDialog(id: order_id);
            }));
      } else {}

      setState(() {
        _isLoggedIn = false;
        print("done_done=============================================");
      });
    } catch (error) {
      print("----------------------------------$error");
      setState(() {
        _isLoggedIn = false;
      });
      throw (error);
    }
  }

  // deleted address -----------------------
  Future<void> remove_address(String ship_id) async {
    print("checking==================date_res");

    setState(() {
      _isLoggedIn = true;
    });

    try {
      await Provider.of<CheckoutProvider>(
        context,
        listen: false,
      ).fetchAndRemoveAddress(ship_id);

      if (Provider.of<CheckoutProvider>(
            context,
            listen: false,
          ).success ==
          1) {
        final userDetails = Provider.of<UserDetailsProvider>(
          context,
          listen: false,
        ).userDetails;
        String mem_id;
        if (userDetails.isEmpty) {
          mem_id = '';
        } else {
          mem_id = Provider.of<UserDetailsProvider>(
            context,
            listen: false,
          ).userDetails[0].memberId.toString().trim();
        }
        shipping_addres(mem_id);
      }

      print("date____________________removed");

      setState(() {
        _isLoggedIn = false;
      });
    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) {
      _getPaymentMethods();
      final userDetails = Provider.of<UserDetailsProvider>(
        context,
        listen: false,
      ).userDetails;
      String mem_id;
      if (userDetails.isEmpty) {
        mem_id = '';
      } else {
        mem_id = Provider.of<UserDetailsProvider>(
          context,
          listen: false,
        ).userDetails[0].memberId.toString().trim();
      }
      // Provider.of<CheckoutProvider>(context).fetchAndSetDeliveryAddress(mem_id);

      //Provider.of<CheckoutProvider>(context).fetchAndSetDeliveryAddress();
      //Provider.of<CheckoutProvider>(context).fetchAndSetDates();
      // Provider.of<CheckoutProvider>(context).fetchAndSetTimes();

      shipping_addres(mem_id);
      date_res();
      time_res();
    });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  List<PaymentMethod> _paymentMethods = [];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  _getPaymentMethods() async {
    var response = await _productCartProvider.getPaymentMethods(context);
    if (response is PaymentMethodResponse) {
      _paymentMethods.addAll(response.result.payment_methods);
    } else {
      print(response.error);
    }
  }

  void openCheckout(double amount) async {
    final userDetails =
        Provider.of<UserDetailsProvider>(context, listen: false).userDetails;
    var options = {
      'key': '${APIs.razorPayApi}',
      'amount': amount * 100,
      'name': 'SVGS',
      'description': 'Shop More And More ',
      'prefill': {
        'contact': '${userDetails[0].phone}',
        'email': '${userDetails[0].email}',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        backgroundColor: AppColors.themecolor,
        textColor: AppColors.whiteColor,
        fontSize: 14.0,
        gravity: ToastGravity.CENTER,
        msg: "SUCCESS",
        toastLength: Toast.LENGTH_SHORT);
    // showSnackBar("success");
    // print(response);
    // createCouponPaymentGetway(response.paymentId!);
    place_order(paymentStatus: '3', transactionId: response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    TransactionErrorResponse transactionErrorResponse =
        TransactionErrorResponse.fromJson(
      json.decode(response.message),
    );
    Fluttertoast.showToast(
      backgroundColor: AppColors.themecolor,
      textColor: AppColors.whiteColor,
      fontSize: 14.0,
      gravity: ToastGravity.CENTER,
      msg: transactionErrorResponse.error.description,
      toastLength: Toast.LENGTH_SHORT,
    );
    place_order(paymentStatus: '1', transactionId: 'failed');
    print(response.code);
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        backgroundColor: AppColors.themecolor,
        textColor: AppColors.whiteColor,
        fontSize: 14.0,
        gravity: ToastGravity.CENTER,
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
    print(response);

    ///place_order(paymentStatus: 'success', transactionId: response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    _productCartProvider = Provider.of<ProductCartProvider>(context);
    var totalAmount = double.parse(Provider.of<CartProvider>(context).total);
    var deliveryCharge =
        double.parse(Provider.of<CartProvider>(context).delivery_charge);
    var deliveryCheck =
        double.parse(Provider.of<CartProvider>(context).deliveryCheck);

    if (totalAmount >= deliveryCheck) {
      deliveryCharge = 0.0;
    }

    var totalAmountToPay = totalAmount + deliveryCharge;

    var platform = Theme.of(context).platform;

    return ModalProgressHUD(
      inAsyncCall: _isLoggedIn,
      child: SingleChildScrollView(
        child: Container(
          // height: 650.0,
          margin: EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //for delivery address adding
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Delivery Address',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Container(
                        color: AppColors.svgs_theme,
                        child: FlatButton.icon(
                          icon: Icon(Icons.add, color: AppColors.whiteColor),
                          onPressed: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new AddNewAddress(
                                      from_key: 'add', ship_id: "0")),
                            ).then((value) {
                              setState(() {
                                final userDetails =
                                    Provider.of<UserDetailsProvider>(
                                  context,
                                  listen: false,
                                ).userDetails;
                                String mem_id;
                                if (userDetails.isEmpty) {
                                  mem_id = '';
                                } else {
                                  mem_id = Provider.of<UserDetailsProvider>(
                                    context,
                                    listen: false,
                                  ).userDetails[0].memberId.toString().trim();
                                }
                                shipping_addres(mem_id);
                              });
                            });
                            /*Navigator.of(context)
                                  .pushNamed(AddNewAddress.routeName);*/
                          },
                          label: Text(
                            'Add New Address',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //delivery address list
                Container(
                  height: 220.0,
                  child: address_dynamic.length < 1
                      ? DeliveryAddressSimmer()
                      : ListView.builder(
                          itemCount: address_dynamic.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return Container(
                              height: 220.0,
                              width: 250.0,
                              decoration: BoxDecoration(
                                color: add_pos[index] == 1
                                    ? AppColors.themecolor
                                    : AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[400].withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.all(6.0),
                              child: Card(
                                elevation: 0.0,
                                color: add_pos[index] == 1
                                    ? AppColors.themecolor
                                    : AppColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),

                                //crossAxisAlignment: CrossAxisAlignment.start,

                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.only(
                                          left: 6.0,
                                          top: 6.0,
                                          right: 0.0,
                                          bottom: 6.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${address_dynamic[index].shipName}'
                                                        .capitalizeFirstofEach,
                                                    style: TextStyle(
                                                      color: add_pos[index] != 1
                                                          ? AppColors.blackColor
                                                          : AppColors
                                                              .whiteColor,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 0.5,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      IconButton(
                                                          icon: Icon(Icons.edit,
                                                              size: 25.0),
                                                          onPressed: () {
                                                            shipping_id =
                                                                address_dynamic[
                                                                        index]
                                                                    .id
                                                                    .toString();

                                                            shipping_id =
                                                                address_dynamic[
                                                                        index]
                                                                    .id
                                                                    .toString();
                                                            String shipName =
                                                                address_dynamic[
                                                                        index]
                                                                    .shipName
                                                                    .toString();
                                                            String shipMobile =
                                                                address_dynamic[
                                                                        index]
                                                                    .shipMobile
                                                                    .toString();

                                                            String shipAddress =
                                                                address_dynamic[
                                                                        index]
                                                                    .shipAddress
                                                                    .toString();

                                                            String shipPinCode =
                                                                address_dynamic[
                                                                        index]
                                                                    .shipPinCode
                                                                    .toString();
                                                            String
                                                                shipLandmark =
                                                                address_dynamic[
                                                                        index]
                                                                    .shipLandmark
                                                                    .toString();
                                                            String shipCity =
                                                                address_dynamic[
                                                                        index]
                                                                    .shipCity
                                                                    .toString();

                                                            String shipAreaId =
                                                                address_dynamic[
                                                                        index]
                                                                    .shipAreaId
                                                                    .toString();
                                                            String shipArea =
                                                                address_dynamic[
                                                                        index]
                                                                    .shipArea
                                                                    .toString();

                                                            print(
                                                                "5555555555555555555555555");
                                                            print(shipName);
                                                            print(shipLandmark);
                                                            print(shipCity);

                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new AddNewAddress(
                                                                      from_key:
                                                                          "edit",
                                                                      ship_id:
                                                                          shipping_id,
                                                                      shipName:
                                                                          shipName,
                                                                      shipMobile:
                                                                          shipMobile,
                                                                      shipAddress:
                                                                          shipAddress,
                                                                      shipPinCode:
                                                                          shipPinCode,
                                                                      shipLandmark:
                                                                          shipLandmark,
                                                                      shipCity:
                                                                          shipCity,
                                                                      shipAreaId:
                                                                          shipAreaId,
                                                                      shipArea:
                                                                          shipArea)),
                                                            ).then((value) {
                                                              setState(() {
                                                                final userDetails =
                                                                    Provider.of<
                                                                        UserDetailsProvider>(
                                                                  context,
                                                                  listen: false,
                                                                ).userDetails;
                                                                String mem_id;
                                                                if (userDetails
                                                                    .isEmpty) {
                                                                  mem_id = '';
                                                                } else {
                                                                  mem_id = Provider.of<
                                                                          UserDetailsProvider>(
                                                                    context,
                                                                    listen:
                                                                        false,
                                                                  )
                                                                      .userDetails[
                                                                          0]
                                                                      .memberId
                                                                      .toString()
                                                                      .trim();
                                                                }
                                                                shipping_addres(
                                                                    mem_id);
                                                              });
                                                            });
                                                          }),
                                                      Visibility(
                                                        visible:
                                                            _hide_delete_ic,
                                                        child: IconButton(
                                                            color: AppColors
                                                                .errorStateBrightRed,
                                                            icon: Icon(
                                                                Icons
                                                                    .delete_forever,
                                                                size: 25.0),
                                                            onPressed: () {
                                                              shipping_id =
                                                                  address_dynamic[
                                                                          index]
                                                                      .id
                                                                      .toString();

                                                              print(
                                                                  "deleted ===================================== source");
                                                              print(
                                                                  shipping_id);

                                                              remove_address(
                                                                  shipping_id);

                                                              /*  Navigator.of(context,listen: false,)
                                                             .pushNamed(
                                                             AddNewAddress
                                                                 .routeName);*/
                                                            }),
                                                      )
                                                    ])
                                              ],
                                            ),
                                          ),
                                          _verticalDivider(),
                                          new Text(
                                              '${address_dynamic[index].shipAddress}'
                                                  .capitalizeFirstofEach,
                                              style: TextStyle(
                                                color: add_pos[index] != 1
                                                    ? AppColors.blackColor
                                                    : AppColors.whiteColor,
                                                fontSize: 16.0,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis),
                                          _verticalDivider(),
                                          new Text(
                                            address_dynamic[index]
                                                        .shipLandmark ==
                                                    null
                                                ? ""
                                                : address_dynamic[index]
                                                    .shipLandmark,
                                            style: TextStyle(
                                              color: add_pos[index] != 1
                                                  ? AppColors.blackColor
                                                  : AppColors.whiteColor,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          _verticalDivider(),
                                          new Text(
                                            '${address_dynamic[index].shipPinCode}',
                                            style: TextStyle(
                                              color: add_pos[index] != 1
                                                  ? AppColors.blackColor
                                                  : AppColors.whiteColor,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          new Container(
                                            margin: EdgeInsets.only(
                                                left: 00.0,
                                                top: 05.0,
                                                right: 0.0,
                                                bottom: 5.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(
                                                  'Delivery Address',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: add_pos[index] != 1
                                                        ? AppColors.blackColor
                                                        : AppColors.whiteColor,
                                                  ),
                                                ),
                                                _verticalD(),
                                                add_pos[index] == 1
                                                    ? new Checkbox(
                                                        activeColor: AppColors
                                                            .whiteColor,
                                                        checkColor: AppColors
                                                            .themecolor,
                                                        value: true,
                                                        onChanged:
                                                            (bool value) {
                                                          setState(() {
                                                            /*address_dynamic[index]
                                                          .isSelected = value;*/
                                                          });
                                                        },
                                                      )
                                                    : new Checkbox(
                                                        activeColor: AppColors
                                                            .themecolor,
                                                        checkColor: AppColors
                                                            .whiteColor,
                                                        value: false,
                                                        onChanged:
                                                            (bool value) {
                                                          setState(() {
                                                            address_dynamic[0]
                                                                    .isSelected =
                                                                true;
                                                            for (int i = 0;
                                                                i <
                                                                    add_pos
                                                                        .length;
                                                                i++) {
                                                              if (index == i) {
                                                                setState(() {
                                                                  add_pos
                                                                      .setAll(i,
                                                                          [1]);
                                                                  //dates.setAll(i, [StandardDate(date_pos: 1)]);
                                                                  print(
                                                                      "2===========================SHARIYATH====================$address_dynamic");
                                                                  print(add_pos[
                                                                      index]);
                                                                  custaddr_id =
                                                                      address_dynamic[
                                                                              index]
                                                                          .id
                                                                          .toString();
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  add_pos
                                                                      .setAll(i,
                                                                          [0]);
                                                                  //dates.setAll(i, [StandardDate(date_pos: 0)]);
                                                                  print(
                                                                      "2===========================SHARIYATH====================$address_dynamic");
                                                                  print(add_pos[
                                                                      index]);
                                                                });
                                                              }
                                                            }
                                                            /* address_dynamic[index]
                                                          .isSelected = value;*/
                                                          });
                                                        },
                                                      )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                //choosing payment methods
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.0),
                        width: double.infinity,
                        child: Text(
                          'Payment Method',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 5, bottom: 0),
                              title: Row(
                                children: [
                                  Icon(FlutterIcons.payment_mdi),
                                  SizedBox(width: 10),
                                  Text(_paymentMethod),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  _expanded
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _expanded = !_expanded;
                                  });
                                },
                              ),
                            ),
                            if (_expanded)
                              Container(
                                height: 70,
                                //width: double.infinity,
                                child: _productCartProvider.getLoading()
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                        ),
                                      )
                                    : ListView.builder(
                                        padding: EdgeInsets.all(0),
                                        itemCount: 1,
                                        // itemCount: _paymentMethods.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _paymentMethod = "COD";
                                                    // _paymentMethod =
                                                    //     "${_paymentMethods[index].method}";
                                                    _expanded = false;
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            index == 0
                                                                ? Icon(
                                                                    FlutterIcons
                                                                        .money_faw,
                                                                    color: AppColors
                                                                        .themecolor)
                                                                : Icon(
                                                                    Icons
                                                                        .credit_card,
                                                                    color: AppColors
                                                                        .themecolor),
                                                            SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            Text(
                                                                "${_paymentMethods[index].method}",
                                                                style: TextStyles
                                                                    .themeColorText),
                                                          ],
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .keyboard_arrow_right,
                                                          color: AppColors
                                                              .themecolor,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                          // return FlatButton.icon(
                                          //   onPressed: () {
                                          //     setState(() {
                                          //       _paymentMethod =
                                          //           "${_paymentMethods[index].method}";
                                          //       _expanded = false;
                                          //     });
                                          //   },
                                          //   icon:
                                          //       Icon(MaterialIcons.attach_money),
                                          //   label: Text(
                                          //       '${_paymentMethods[index].method}'),
                                          // );
                                        }),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      //for delivery date

                      Container(
                        margin: EdgeInsets.all(
                          5.0,
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Choose Delivery Date',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Card(
                              child: Container(
                                height: 90,
                                child: dates_dynamic.length < 1
                                    ? DeliveryDateSimmer()
                                    : ListView.builder(
                                        itemCount: dates_dynamic.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final date = DateFormat('dd-MM-yyyy')
                                              .parse(dates_dynamic[index].date);

                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                print(
                                                    "==00000000000000000000000000000000000==");
                                                //print("1===========================SHARIYATH====================$dates_dynamic");
                                                print(index);

                                                for (int i = 0;
                                                    i < dates_pos.length;
                                                    i++) {
                                                  if (index == i) {
                                                    setState(() {
                                                      dates_pos.setAll(i, [1]);
                                                      //dates.setAll(i, [StandardDate(date_pos: 1)]);
                                                      print(
                                                          "2===========================SHARIYATH====================$dates_dynamic");
                                                      print(dates_pos[index]);
                                                      //deli_date = DateFormat('yyyy-mm-dd').parse(dates_dynamic[index].date).toString();
                                                      final date_v = DateFormat(
                                                              'dd-MM-yyyy')
                                                          .parse(dates_dynamic[
                                                                  index]
                                                              .date);
                                                      print(
                                                          "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
                                                      deli_date = DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(date_v)
                                                          .toString();
                                                      print(deli_date);

                                                      if (i == 0) {
                                                        time_res();
                                                      } else {
                                                        all_time_res();
                                                      }
                                                    });
                                                  } else {
                                                    setState(() {
                                                      dates_pos.setAll(i, [0]);
                                                      //dates.setAll(i, [StandardDate(date_pos: 0)]);
                                                      print(
                                                          "2===========================SHARIYATH====================$dates_dynamic");
                                                      print(dates_pos[index]);
                                                      //deli_date = DateFormat('yyyy-mm-dd').parse(dates_dynamic[index].date).toString();
                                                    });
                                                  }
                                                }
                                              });
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Container(
                                                // color: _selectedDate ? Colors.blue : Colors.grey,

                                                decoration: BoxDecoration(
                                                  color: dates_pos[index] == 1
                                                      ? AppColors.themecolor
                                                      : AppColors.grey_btn,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(15.0),
                                                  ),
                                                ),
                                                width: 90,
                                                child: Center(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        DateFormat(
                                                                'EE', 'en_US')
                                                            .format(date),
                                                        style: TextStyle(
                                                          color: dates_pos[
                                                                      index] ==
                                                                  1
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        DateFormat(
                                                                'MMMd', 'en_US')
                                                            .format(date),
                                                        style: TextStyle(
                                                          color: dates_pos[
                                                                      index] ==
                                                                  1
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),

                      // for delivery data
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: Card(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                  'Choose Delivery Time',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                height: 50.0,
                                child: time_dynamic.length < 1
                                    ? Center(
                                        child: time_dynamic.length < 1
                                            ? Center(
                                                child: Text(
                                                    "Today's time slot over.Select date.",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.red)))
                                            : CircularProgressIndicator())
                                    : ListView.builder(
                                        itemCount: time_dynamic.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final time_format_from =
                                              DateFormat("HH:mm:ss").parse(
                                                  time_dynamic[index]
                                                      ['fromTime']);
                                          final time_format_to =
                                              DateFormat("HH:mm:ss").parse(
                                                  time_dynamic[index]
                                                      ['toTime']);

                                          return Container(
                                            margin: EdgeInsets.only(
                                              left: 5.0,
                                              right: 15.0,
                                              bottom: 5.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: time_pos[index] == 1
                                                  ? AppColors.themecolor
                                                  : AppColors.grey_btn,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  for (int i = 0;
                                                      i < time_pos.length;
                                                      i++) {
                                                    if (index == i) {
                                                      setState(() {
                                                        time_pos.setAll(i, [1]);

                                                        final str_ft = DateFormat(
                                                                "HH:mm:ss")
                                                            .parse(time_dynamic[
                                                                    index]
                                                                ['fromTime']);
                                                        final str_tt = DateFormat(
                                                                "HH:mm:ss")
                                                            .parse(time_dynamic[
                                                                    index]
                                                                ['toTime']);

                                                        String str_from_time =
                                                            DateFormat("HH:mm")
                                                                .format(str_ft)
                                                                .toString();
                                                        String str_to_time =
                                                            DateFormat("HH:mm")
                                                                .format(str_tt)
                                                                .toString();

                                                        print(
                                                            "1234time_slot_checking--------------------------");
                                                        print(str_from_time +
                                                            "n" +
                                                            str_to_time);

                                                        delivery_slot =
                                                            str_from_time +
                                                                "||" +
                                                                str_to_time;

                                                        //dates.setAll(i, [StandardDate(date_pos: 1)]);
                                                        print(
                                                            "2===========================SHARIYATH====================$time_dynamic");
                                                        print(time_pos[index]);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        time_pos.setAll(i, [0]);
                                                        //dates.setAll(i, [StandardDate(date_pos: 0)]);
                                                        print(
                                                            "2===========================SHARIYATH====================$time_dynamic");
                                                        print(time_pos[index]);
                                                      });
                                                    }
                                                  }
                                                });
                                              },
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(
                                                    '${DateFormat("hh:mma").format(time_format_from)} - ${DateFormat("hh:mma").format(time_format_to)}',
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color:
                                                            time_pos[index] == 1
                                                                ? Colors.white
                                                                : Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                          margin: const EdgeInsets.all(
                            10.000000000000,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(
                                    Icons.info,
                                    color: AppColors.blackColor,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    width: 125.0,
                                    child: Text(
                                      'Sub Total :',
                                      style: TextStyles.highlitedText,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  ),
                                  Text('\₹ ${totalAmount.toStringAsFixed(2)}',
                                      style: TextStyles.txt_16_black_normal),
                                  SizedBox(
                                    width: 50.0,
                                  )
                                ],
                              ),
                              Divider(
                                color: AppColors.themecolor,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(Icons.info, color: AppColors.blackColor),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    width: 125.0,
                                    child: Text(
                                      'Delivery Charge :',
                                      style: TextStyles.highlitedText,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  ),
                                  Text(
                                      '\₹ ${deliveryCharge.toStringAsFixed(2)}',
                                      style: TextStyles.txt_16_black_normal),
                                ],
                              ),
                              Divider(
                                color: AppColors.themecolor,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Icon(
                                        Icons.info,
                                        color: AppColors.blackColor,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Container(
                                        width: 125.0,
                                        child: Text(
                                          'Total :',
                                          style: TextStyles.highlitedText,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40.0,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          '₹ ${totalAmountToPay.toStringAsFixed(2)}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                              color: Colors.green),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )),
                      FlatButton.icon(
                        color: AppColors.themecolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        icon: Icon(
                          Icons.shopping_cart,
                          color: AppColors.whiteColor,
                        ),
                        onPressed: () {
                          /* Navigator.of(context).pushNamed(OrderList.routeName);*/

                          print(
                              "Testing_purpose=====================================");
                          print(delivery_slot);
                          if (delivery_slot == '') {
                            Fluttertoast.showToast(
                                msg: "Today's time slot over.Select date.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            // if (_paymentMethod.trim() == "COD") {
                            place_order(
                              paymentStatus: '1',
                              transactionId: 'cod',
                            );
                            //  } else {
                            // openCheckout(totalAmountToPay);
                            // print('You Select on line payment');
                          }
                          //  }
                        },
                        label: Text(
                          'Place Order',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}
