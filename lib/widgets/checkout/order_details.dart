import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/widgets/order_status.dart';
import 'package:svgs_app/providers/order_list_provider.dart';
import 'package:svgs_app/providers/order_list_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';

class OrderDetails extends StatefulWidget {
  static const routeName = '/order-details';

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      fetchProducts();
    });
    super.initState();
  }

  fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    final memberId =
        await Provider.of<UserDetailsProvider>(context, listen: false)
            .userDetails[0]
            .memberId;
    final routeArgs = ModalRoute.of(
      context,
    ).settings.arguments as Map<String, String>;

    final orderId = routeArgs['orderId'];
    await Provider.of<OrderListProvider>(context, listen: false)
        .fetchAndSetOrderDetails(orderId, memberId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final orderNo = routeArgs['orderNo'];
    final orderDate = routeArgs['orderDate'];
    final orderStatus = routeArgs['orderStatus'];
    final totalAmount = routeArgs['totalAmount'];
    final paymentMethod = routeArgs['paymentMethod'];
    final shippping = routeArgs['shippping'];
    final subTotal = routeArgs['subTotal'];
    final deliveryDate = routeArgs['deliveryDate'];
    final shippingMethod = routeArgs['shippingMethod'];
    final orderDeliverType = routeArgs['orderDeliverType'];
    var dateType = '';

    if (orderDeliverType == '3') {
      dateType = 'Pick Up Date';
    } else {
      dateType = 'Delivery Date';
    }

    final ordersDetail = Provider.of<OrderListProvider>(
      context,
    ).orderDetails;

    //print(cart.items[0].productImage);
    // TODO: implement build

    IconData _add_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.add_circle;
        case TargetPlatform.iOS:
          return Icons.add_circle;
      }
      assert(false);
      return null;
    }

    IconData _sub_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.remove_circle;
        case TargetPlatform.iOS:
          return Icons.remove_circle;
      }
      assert(false);
      return null;
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double dd = width * 0.77;
    double hh = height - 215.0;
    int item = 0;
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subtitle1
        .copyWith(color: theme.textTheme.caption.color);

    ///
    final appBar = AppBar(
        backgroundColor: AppColors.themecolor,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          'My Orders',
          style: TextStyles.actionTitle_w,
        ));
    final appBarHeight = appBar.preferredSize.height;
    final padding = MediaQuery.of(context).padding.top;
    // final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.themecolor,
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      // height: 80.0,
                      margin: const EdgeInsets.only(top: 5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: AppColors.themecolor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        //order Details
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order No: ${orderNo}'),
                              Text(
                                  'Order Date: ${DateFormat.yMMMd().format(DateTime.parse(orderDate))}'),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order Status: ${orderStatus}'),
                              Text(deliveryDate.toString() == 'null'
                                  ? '$dateType: not found '
                                  : '$dateType: ${DateFormat.yMMMd().format(DateTime.parse(deliveryDate))}'),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [Text('Order Type:$shippingMethod')],
                          ),
                          SizedBox(height: 15.0),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      //   height: (height - appBarHeight - padding) * 0.938,
                      margin: EdgeInsets.only(
                          bottom: 30.0, left: 10.0, right: 10.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.themecolor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Container(
                                    margin: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'Product Details(${ordersDetail.length})',
                                      style: TextStyles.whteText13,
                                    )),
                              ),

                              ///orderdetails
                              Container(
                                  //  height: 500.0,

                                  child: ordersDetail.length == 0
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ListView.builder(
                                          itemCount: ordersDetail.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder:
                                              (BuildContext cont, int ind) {
                                            return Container(
                                              alignment: Alignment.topLeft,
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: <Widget>[
                                                      Card(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                        child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10.0,
                                                                    vertical:
                                                                        5.0),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            width:
                                                                                270,
                                                                            child:
                                                                                Text(
                                                                              '${ordersDetail[ind].name}',
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              softWrap: true,
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Colors.black),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            'Unit price: \₹ ${ordersDetail[ind].price}',
                                                                            style:
                                                                                TextStyle(fontSize: 15.0, color: Colors.black54),
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Text(
                                                                              'Total qty: ${ordersDetail[ind].qty}',
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      '${ordersDetail[ind].total_price}',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              13.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          })),

                              ///////////////////////
                            ],
                          ),
                          Column(
                            children: [
                              Divider(
                                color: Colors.black,
                                height: 2.0,
                              ),
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                width: double.infinity,
                                child: Text(
                                    'Sub Total:  \₹ ${double.parse(subTotal).toStringAsFixed(2)}'),
                              ),
                              Divider(
                                color: Colors.black,
                                height: 2.0,
                              ),
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                width: double.infinity,
                                child: Text(
                                    'Delivery Charge:  \₹ ${double.parse(shippping).toStringAsFixed(2)}'),
                              ),
                              Divider(
                                color: Colors.black,
                                height: 2.0,
                              ),
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                width: double.infinity,
                                child: Text(
                                    'Total Amount:  \₹ ${double.parse(totalAmount).toStringAsFixed(2)}'),
                              ),
                              Divider(
                                color: Colors.black,
                                height: 2.0,
                              ),
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                width: double.infinity,
                                child: Text('Payment Method: ${paymentMethod}'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 07.0, bottom: 0.0),
      );
}
