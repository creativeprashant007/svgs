import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/model/timeslot.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/providers/checkout_provider.dart';
import 'package:svgs_app/providers/common_provider.dart';
import 'package:svgs_app/providers/placeorder_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/widgets/checkout/order_list.dart';
import 'package:svgs_app/widgets/simmer/checkout_simmers.dart';

import '../showalertPlaceOrder.dart';
import 'order_details.dart';

class Takeaway extends StatefulWidget {
  @override
  _TakeawayState createState() => _TakeawayState();
}

class _TakeawayState extends State<Takeaway> {
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  bool _expanded = false;
  bool _dateSelect = false;
  bool _timeSelect = false;

  int _value = 1;
  bool _isLoggedIn = false;

  List<int> add_pos = [];
  List<int> dates_pos = [];
  List<int> time_pos = [];
  List dates_dynamic = [];
  List time_dynamic = [];
  List address_dynamic = [];
  List<String> spinner_dynamic = [];
  List<DropdownMenuItem<String>> _dropdownMenuItems;

  String dropdownValue = 'One';
  List<String> spinnerItems = ['One', 'Two', 'Three', 'Four', 'Five'];

  String deli_type = '3';
  String deli_date = '';
  String delivery_slot = '';
  String custaddr_id = '';
  String need_prod = '';
  String take_branch = '';

  // http://www.svgs.co/api/postCheckout?brch_id=1&mem_id=1&deli_type=3&deli_date=&delivery_slot=&custaddr_id=1&need_prod=&take_branch=1

  Future<void> spinner_branch() async {
    try {
      final branch_items = Provider.of<CommonProvider>(
        context,
        listen: false,
      ).branch_items;

      for (int i = 0; i < branch_items.length; i++) {
        setState(() {
          take_branch = branch_items[0].id.toString();
          dropdownValue = branch_items[0].brch_name.toString();
          spinner_dynamic.add(branch_items[i].brch_name.toString());
        });
      }
      print(
          "spinner_dynamic----------------------------------$spinner_dynamic");
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

  Future<void> place_order(
      String branch_id,
      String mem_id,
      String deli_type,
      String deli_date,
      String delivery_slot,
      String custaddr_id,
      String need_prod,
      String take_branch) async {
    try {
      setState(() {
        _isLoggedIn = true;
      });

      var platform = Theme.of(context).platform;
      var is_platform = "4";

      if (platform == TargetPlatform.iOS) {
        is_platform = "3";
      } else {
        is_platform = "4";
      }

      await Provider.of<PlaceOrderProvider>(
        context,
        listen: false,
      ).fetchAndSetPlaceOrder(
        branch_id: branch_id,
        mem_id: mem_id,
        deli_type: deli_type,
        deli_date: deli_date,
        delivery_slot: delivery_slot,
        custaddr_id: custaddr_id,
        need_prod: need_prod,
        take_branch: take_branch,
        platform_os: is_platform,
        payment_method: 'TBD',
        payment_status: 'Pending',
        razor_pay_id: 'TBD',
      );

      final success = Provider.of<PlaceOrderProvider>(
        context,
        listen: false,
      ).success.toString();

      if (success == '1') {
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

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
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

      date_res();
      time_res();

      spinner_branch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final address = Provider.of<CheckoutProvider>(context).addresses;
    // final dates = Provider.of<CheckoutProvider>(context).dates;
    // final times = Provider.of<CheckoutProvider>(context).standardDelivery;
    final totalAmount = Provider.of<CartProvider>(context).total;

    print("==========================================$dates_dynamic");
    /*child: ModalProgressHUD(
        inAsyncCall: _isLoggedIn,*/

    return ModalProgressHUD(
        inAsyncCall: _isLoggedIn,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Pickup Branch',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                underline: Container(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                                onChanged: (String data) {
                                  setState(() {
                                    for (int i = 0;
                                        i < spinner_dynamic.length;
                                        i++) {
                                      String str_v =
                                          spinner_dynamic[i].toString();

                                      if (str_v == data) {
                                        take_branch =
                                            Provider.of<CommonProvider>(
                                          context,
                                          listen: false,
                                        ).branch_items[i].id;
                                        print(
                                            'take_branch-------------------------' +
                                                take_branch);
                                        break;
                                      }
                                    }

                                    dropdownValue = data;
                                  });
                                },
                                items: spinner_dynamic
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                            'Choose Pickup Date',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
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
                                                      .parse(
                                                          dates_dynamic[index]
                                                              .date);
                                                  print(
                                                      "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
                                                  deli_date =
                                                      DateFormat('yyyy-MM-dd')
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
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15.0),
                                              ),
                                            ),
                                            width: 90,
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    DateFormat('EE', 'en_US')
                                                        .format(date),
                                                    style: TextStyle(
                                                      color:
                                                          dates_pos[index] == 1
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    DateFormat('MMMd', 'en_US')
                                                        .format(date),
                                                    style: TextStyle(
                                                      color:
                                                          dates_pos[index] == 1
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
                              'Choose Pickup Slot',
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
                            child: time_dynamic.length == 0
                                ? Center(
                                    child: time_dynamic.length == 0
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
                                              time_dynamic[index]['fromTime']);
                                      final time_format_to =
                                          DateFormat("HH:mm:ss").parse(
                                              time_dynamic[index]['toTime']);

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
                                                        .parse(
                                                            time_dynamic[index]
                                                                ['fromTime']);
                                                    final str_tt = DateFormat(
                                                            "HH:mm:ss")
                                                        .parse(
                                                            time_dynamic[index]
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
                                                    color: time_pos[index] == 1
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
                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              width: 20.0,
                            ),
                            Text(
                              'Total :',
                              style: TextStyles.highlitedText,
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                '₹ ${totalAmount}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.green),
                              ),
                            ),
                          ],
                        ),
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
                            final userDetails =
                                Provider.of<UserDetailsProvider>(context,
                                        listen: false)
                                    .userDetails;
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
                              place_order(
                                  branch_id,
                                  mem_id,
                                  deli_type,
                                  deli_date,
                                  delivery_slot,
                                  custaddr_id,
                                  need_prod,
                                  take_branch);
                            }
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
        ));
  }
}
