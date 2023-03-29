import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/order_list_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/widgets/checkout/order_details.dart';
import 'package:svgs_app/widgets/order_status.dart';

class OrderList extends StatefulWidget {
  static const routeName = '/order-list';

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  // String orderState;
  String orderStatus(String statusId) {
    if (statusId == "1") return "New";
    if (statusId == "2") return "Confirmed";
    if (statusId == "3") return "Hold";
    if (statusId == "4") return "Canceled";
    if (statusId == "5") return "Delivered";
    if (statusId == "6") return "Failed";
  }

  bool isloading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      fetchOrder();
    });
    super.initState();
  }

  fetchOrder() async {
    setState(() {
      isloading = true;
    });
    final memberId = await Provider.of<UserDetailsProvider>(
      context,
      listen: false,
    ).userDetails[0].memberId;
    await Provider.of<OrderListProvider>(
      context,
      listen: false,
    ).fetchAndSetOrders(memberId);
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderListProvider>(context).orders;
    final appBar = AppBar(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor: AppColors.themecolor,
      title: Text(
        'My Orders',
        style: TextStyles.actionTitle_w,
      ),
    );
    final appBarHeight = appBar.preferredSize.height;
    final padding = MediaQuery.of(context).padding.top;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.all(
          10.0,
        ),
        child: isloading
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.themecolor,
                ),
              )
            : orders.length == 0
                ? Center(
                    child: Text(
                      'No Item in order List',
                      style: TextStyles.paragraphBold,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.themecolor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              '${orders.length} Orders',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: (height - appBarHeight - padding) * 0.96,
                          child: ListView.builder(
                              //  physics: NeverScrollableScrollPhysics(),
                              // shrinkWrap: false,
                              itemCount: orders.length,
                              itemBuilder: (ctx, index) {
                                final orderState =
                                    orderStatus(orders[index].status);

                                return Column(
                                  children: [
                                    Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Container(
                                        //  margin: const EdgeInsets.only(top: 10.0),
                                        padding: EdgeInsets.all(5.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Order Number: ${orders[index].orderShowId}',
                                                  style: TextStyles
                                                      .txt_14_black_bold,
                                                ),
                                                Text(''),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  (orders[index].orderDeliverDate)
                                                              .toString() ==
                                                          'null'
                                                      ? 'Date not Found'
                                                      : ' ${DateFormat.yMMMd().format(DateTime.parse(orders[index].orderDeliverDate))}',
                                                  style: TextStyles.greyText13,
                                                ),
                                                Text(''),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 20.0),
                                                  color: AppColors.themecolor,
                                                  height: 1.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                ),
                                                Text(
                                                    '${orders[index].order_itemcount} items',
                                                    style: TextStyles
                                                        .txt_12_black_bold),
                                                Text(''),
                                              ],
                                            ),

                                            //below line
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text('Total Price:'),
                                                        Text(
                                                          ' ₹ ${double.parse(orders[index].total).toStringAsFixed(2)}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('Status:  '),
                                                        OrderStatus(
                                                          statusValue:
                                                              orders[index]
                                                                  .status,
                                                        ),
                                                        SizedBox(
                                                          width: 3.0,
                                                        ),
                                                        Text('${orderState}'),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                FlatButton(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              OrderDetails
                                                                  .routeName,
                                                              arguments: {
                                                            'orderId':
                                                                orders[index]
                                                                    .id,
                                                            'orderNo': orders[
                                                                    index]
                                                                .orderShowId,
                                                            'orderDate':
                                                                orders[index]
                                                                    .createdAt,
                                                            'orderStatus':
                                                                orderState,
                                                            'totalAmount':
                                                                orders[index]
                                                                    .total,
                                                            'shippping':
                                                                orders[index]
                                                                    .shipping,
                                                            'subTotal':
                                                                orders[index]
                                                                    .subTotal,
                                                            'paymentMethod':
                                                                orders[index]
                                                                    .paymentMethod,
                                                            'deliveryDate': orders[
                                                                    index]
                                                                .orderDeliverDate,
                                                            'shippingMethod':
                                                                orders[index]
                                                                    .shippingMethod,
                                                            'orderDeliverType':
                                                                orders[index]
                                                                    .orderDeliverType,
                                                          });
                                                    },
                                                    child: Text(
                                                      'View Order',
                                                      style:
                                                          TextStyles.whteText13,
                                                    ),
                                                    color:
                                                        AppColors.themecolor),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    SizedBox(
                                      child: Container(
                                        height: 5.0,
                                        color: AppColors.themecolor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
